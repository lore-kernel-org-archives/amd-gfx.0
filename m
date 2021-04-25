Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47266C433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5325613CB
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5325613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C486E4DD;
	Sun, 25 Apr 2021 07:30:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32A16E4DD
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkmnnEeIp56twSiTPIobGkqodlHNTsrmniuoRMOmMzQEY1JczFkWSt3IvGe1Mwby/KWxHoVgpGTSMDlnd/YVGk7wMUv/QhBYhnR4pPIWMU0s0s8tEbjUdaRvqxlrhs5X/+6lDalovK7MYDDOK4bsyGlNMj+f9sy4Nnk53kw7ZYmz6MRjcUN7ytwtHRcBQC5DJWAekN+mjllYgwFvOA2ifsocjgrv0nYZE4QW3Z9YoN+QauE0EmVl02mgDEI58+ixCeQF2tV7M6rfTRC7rHOxmyftNtgbb/S/fD6t715T3oeGrkyszXwwFPm23ntgK1J9QD5O5gZmoS8YeOD1sc8+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RCZYyUQhT4Parbxa2VL8gOxikoRBWWygMOV/o0BP/I=;
 b=hLQ3CrFYqcHyzzEv/CI5ZZbdKIZ4n6pqUobheLwCVciMQbLP8JJLMJpqeFBI1R8/ATyG9Ilclx1rT/2+mGXQLVhXgIeFO87KMiT/Ny9BN725bbMjUx+VWsMDdhNHiCfGrztRnP4RKseRzahPy162cFCITTDFmPaQtReNozA8ARKtstsBtLhfUqmwvp/VP+lfETTBqRUfVWJiMkH0BTI/CDosmdpkfSRqiL3FuReiDRXEF+u2g+EmlD4FJjZmhaPW6HljJCu/GRwxcCCKNtFMLNXfEgKirTcOJ0TAmEh8gpEE2QoH8CPzOfKT9XMJMHzwr3TtxWu99TeYgt1eDYQPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RCZYyUQhT4Parbxa2VL8gOxikoRBWWygMOV/o0BP/I=;
 b=LDfFTW2FG9wmi+UFsrLskREAvWmEVx1mctFA9XMJwBh83ZCYZugaDb93KCdXG+F0mYDIx5GomA67r0l5zaTMIz1EeA5Et6ELzia9N0jScaBNNNEM3mQyk+2cPmbsKqf/f1XUkGC8IU9rQS87lZ53iXtul7RZzq3/igBakFkhOHw=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com (10.172.77.147) by
 CY4PR12MB1368.namprd12.prod.outlook.com (10.168.169.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Sun, 25 Apr 2021 07:30:52 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f%3]) with mapi id 15.20.4065.025; Sun, 25 Apr 2021
 07:30:52 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: implement smuio callback to query socket
 id
Thread-Topic: [PATCH 1/2] drm/amdgpu: implement smuio callback to query socket
 id
Thread-Index: AQHXOaIMP4sGQXQvf0Sp/PoMyKKrMKrE1ngQ
Date: Sun, 25 Apr 2021 07:30:52 +0000
Message-ID: <CY4PR1201MB00721A4ADEF3283BC9CF0EE6FB439@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <1619334613-13073-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619334613-13073-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-25T07:30:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9a11d928-63e1-4956-bde3-193810c5785f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59eea20f-6bc3-4315-2ec3-08d907bc0e77
x-ms-traffictypediagnostic: CY4PR12MB1368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB13683BA502046BC3231F16C1FB439@CY4PR12MB1368.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:272;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3R8D05j/W1XNMlJNikeyhh7M6lCKm1n0d4axPRfM4DN0MGP0V8HI2VaUzzTOXy8sRh2IQplWTfxnXo8t+XAebWg1KrzT7V+uqWK2iUKibsBriAHxyVC8Q4Hjt8dnKO/XIX8DYRkit9MbdXha+IwpAL2iW8h2t07Q2gg/sdPpqXelkK6EE1KHzsCF5t+rmIEvOxNSazXGPkNQOj+ciwzPkEugbiMyTMUaMfeW7FNaA7V0GJ3BKZPYNWAQASUI1/27+ARHXlmx4DQwyKRjDwlqau5Ztnh98kU9t9hlGReopU2qA2vrtgrdMyB4ubat+k3lbNiQBJr3xvXStM5so+ba5moO9TYsbGy0zSj7JseEZmYu7cEvuSyZ+uKXqxMwd3CSeB7n+DjlhKeD02B564O28GnRZRec7OwKTg7J+UvCMJiw7QCAWqKstF4eFWiyei3t6qlSka8KW5eaKqs1o5mq2sXqvUTjSLzhbIyc6ukKxPosM/2gz4ZV1CzcMSbG5/xdsNTNtT8LYYBGORDMCLFuKcizCsBPv0jyQnr95R/uGBsnPKWKBRG2C/GcuL0boHTOiyYxWWBuCr+7zfG9nSJjv0s/mJeSl7yIoe7FmczoEM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(8676002)(8936002)(6506007)(6636002)(316002)(33656002)(9686003)(55016002)(66476007)(71200400001)(66446008)(52536014)(7696005)(478600001)(76116006)(66556008)(66946007)(53546011)(122000001)(64756008)(5660300002)(186003)(110136005)(38100700002)(4326008)(83380400001)(86362001)(2906002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UvQ6tgNK+zqNe9UOpOCyHsAWUmAm2/E1bPq/jtvoYBL9k0rbOAsFpCoHTqHX?=
 =?us-ascii?Q?yRRT9yQJXzTv0HkFwGkG4mP9amGL4QHNHe4Xd7cs28X2C/yDMA/XM20gtD2R?=
 =?us-ascii?Q?mYSMDFZq1lgafoM5ND3d8CJxWUN3Em2WltEK/75ZaZymjhfHG5nleGYRZhoD?=
 =?us-ascii?Q?VM6TvFu7ZUCiCuSlP4S5hFBqOa0qUpbzIV7EaPaDh2HmXG0LaeBLvzYOnqCK?=
 =?us-ascii?Q?zMHdECuw+DBESa833YVCC4lLgvwmkOXca9dXQgi+RT+HGLv9ifqaPrggBTde?=
 =?us-ascii?Q?8EHm7tOawIOpMekvKJeMnRULWeyYzUWHNMwHx4eWOcdLU2zU1WMMZS4q6Hyo?=
 =?us-ascii?Q?H1bSWZ4roH4ZrhtsZUQyIAs/VxIfVef5wqQEgUJxzF7qsHXFdiRgA3efwJad?=
 =?us-ascii?Q?L1dt1nHOd0uJtwep00xtIrFamdywoS9S323BcuGBKFUvWrBPKJiew1FpHaxY?=
 =?us-ascii?Q?epDHfaVknmRqW7Y7/3yEF/cCwEiimwwxrkgOm1+mNOvDd9MYiLshCOJwBAvU?=
 =?us-ascii?Q?S9TE0Sa6RrkcxmaEPS6cPBNjoqRWwea2YvoGXeiMgH7tWt+jntfHewUzXRLF?=
 =?us-ascii?Q?JJ2IrZGm5iDdQQI/0U9se07Kelrvkp1m6sWSTaXQdNz48i4quKy328KU8iuJ?=
 =?us-ascii?Q?NSswgQiSqBy2a8w63j4I6GvZCQnQiEG5pVzBP/tym/Mc2ZalU9WwNrvP+J00?=
 =?us-ascii?Q?c3DS0N2EfElRC2VoQCX3idpGfeVQr5Ouz0q2MhN08tymhNpNHMKnrLVoaAWC?=
 =?us-ascii?Q?L+h9Yu7Z18tkoF/wxEmfQm6wPSnmB8AkBkxQz+GwvPPoFyAiaOoek5Gugmkh?=
 =?us-ascii?Q?dGe3ndvXRkFF6pDsm481OduDmyhylxZlEJn+c/Rqrc2SDidkD7fE79Ku7Y3B?=
 =?us-ascii?Q?vwmhAcvGOzouhXdFTcSAhLWl0uPZ4FW6FlVzDp9k6DuMfBjETX5hFWharrG1?=
 =?us-ascii?Q?fJ5ve7kO6cdQRzu9aJpSZkgZnb0Fa+aS1FMrqQ0PiABTzRMieTbf0CsEu2TB?=
 =?us-ascii?Q?nCydvcjmT+NQjX62mqF7WWFYiqIusWFFkZMmDdWrrW1qAwevqPmIIBoyqAV2?=
 =?us-ascii?Q?4iUIxZ6Wt47n7Kv80Dko4afVBrymCCU6b44J7SZih0EzJuGxwtQQl0Tcj8NU?=
 =?us-ascii?Q?G/jwJiLTBrK8SSUapZK1+l1z18xmM8hnL7Brnud3Evt5ao0FwV3+uk89X3DV?=
 =?us-ascii?Q?LgqNtR7vx4hLdrXSiOyOwmctz741y7hLJ/K5/gOdkh8gfxvY3CeV5N4Ce895?=
 =?us-ascii?Q?M8AdeuTeRJn/zoLH1F5ibqC+OiT/sDeFYuKkhp/9v1MNdLyJE9P11ZCHiFA0?=
 =?us-ascii?Q?iO85hW8ZwIoL3uDLTAXrX04R?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eea20f-6bc3-4315-2ec3-08d907bc0e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 07:30:52.6384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L59fLc0XOsZqlzV0RYzy1Aicjp/x2Hulmg/IzjaSz2EFL4ScCV3n+qKhGRrQKKJCv5KQsL2PAo1GrBzJNMbCRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1368
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements<John.Clements@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Sunday, April 25, 2021 3:10 PM
To: amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: implement smuio callback to query socket id

get_socket_id is used to query socket id

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h |  1 +  drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index b860ec9..484bb3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -29,6 +29,7 @@ struct amdgpu_smuio_funcs {
 	void (*update_rom_clock_gating)(struct amdgpu_device *adev, bool enable);
 	void (*get_clock_gating_state)(struct amdgpu_device *adev, u32 *flags);
 	u32 (*get_die_id)(struct amdgpu_device *adev);
+	u32 (*get_socket_id)(struct amdgpu_device *adev);
 	bool (*is_host_gpu_xgmi_supported)(struct amdgpu_device *adev);  };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
index 079b094..3c47c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
@@ -89,6 +89,23 @@ static u32 smuio_v13_0_get_die_id(struct amdgpu_device *adev)  }
 
 /**
+ * smuio_v13_0_get_socket_id - query socket id from FCH
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns socket id
+ */
+static u32 smuio_v13_0_get_socket_id(struct amdgpu_device *adev) {
+	u32 data, socket_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	socket_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, SOCKET_ID);
+
+	return socket_id;
+}
+
+/**
  * smuio_v13_0_supports_host_gpu_xgmi - detect xgmi interface between cpu and gpu/s.
  *
  * @adev: amdgpu device pointer
@@ -115,6 +132,7 @@ const struct amdgpu_smuio_funcs smuio_v13_0_funcs = {
 	.get_rom_index_offset = smuio_v13_0_get_rom_index_offset,
 	.get_rom_data_offset = smuio_v13_0_get_rom_data_offset,
 	.get_die_id = smuio_v13_0_get_die_id,
+	.get_socket_id = smuio_v13_0_get_socket_id,
 	.is_host_gpu_xgmi_supported = smuio_v13_0_is_host_gpu_xgmi_supported,
 	.update_rom_clock_gating = smuio_v13_0_update_rom_clock_gating,
 	.get_clock_gating_state = smuio_v13_0_get_clock_gating_state,
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
