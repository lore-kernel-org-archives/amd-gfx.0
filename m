Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB00C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 09:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F5A20786
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 09:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kAz3ZriL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F5A20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9792C89930;
	Tue, 28 Jul 2020 09:43:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6956989930
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 09:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTy4gxPBB1ntRUs9i0QGnQXbNDnD/qJxuS0wUU3HZiAIcvMsaI9XTmWESw4QMoeQ1IKyQPNgR5CRxU2lAeks22fUVj0s8AyuKEvprpFLemFCJdK+Pyu756sZpTgX8+nptm3rjZXhY8U17s9cADUxnR5R+Zb4WCoDwd4NrsrnksFU9ehCh4wd9+5k9kbO0HC9iQD6r3OfCJnOqD1bstJr33Tl+cXfOrl3whkcSzAQT+12Pukjg2OESl9XS7tFVBSxc+ZbNHv+vvrwkShNO8wC552YUQ8PL1div5y1d+ay9iAPvZLnHwzLOg7CF+R6Pp1Jw7ZWWGiCERc7lORtTdgXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdgoUBSroOF3aiB4UDEhJeJ8HtJKUIkVd5zYd4D8jHc=;
 b=arQlxX+4l3ZqGaJ8Sx9reji6AEv61ozqQb83XjHsFReJ8cglqbVt+iUggWYb3HIhB+gU7beglwiEZXOko/IAPSX/21iIKS1GeFZpVRX6aNqlfmfpcctd4zWclsV9zx3PmJko9BNLgR7cmfmBy1I8Fgy8512zkU0tbhKsPbyFRmHVBoMC7+y+MY4FYLBeNUOHPjPFnGUY/CJ68/eqXdnl8KrCq52lCxrBaI1sbvYhJ1yu+H9ZkPnoR54ZWB2n2qrPtWYqnmulR8s+xBxJelbr4FFhtPOf1TjORxGzZwCnysXkTkd3GiK0ZWxRThXjLbVsfmWUPNiEMXQtR+uVFKujGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdgoUBSroOF3aiB4UDEhJeJ8HtJKUIkVd5zYd4D8jHc=;
 b=kAz3ZriLsasJJ6dMBGk3C7M7u+jBu+xYXx661d3tzzTybA9ifx7HZTQrvFV6/6NYkSZwEF4kK4NqRN9gcIgCdQskT/IN+eMAV9GvIZh1hZxmhiUDY5vLVN1ykz8qto+eu3bwINaEzgj+6QxCmrJc+7SSz7KGZd5xgFGginsIxEI=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Tue, 28 Jul 2020 09:43:24 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:43:24 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 04/12] drm/amdgpu: break driver init process when it's bad
 GPU
Thread-Topic: [PATCH 04/12] drm/amdgpu: break driver init process when it's
 bad GPU
Thread-Index: AQHWZLO39r7q2oP7EEKZQ5tjzwWl2akcup2g
Date: Tue, 28 Jul 2020 09:43:24 +0000
Message-ID: <DM5PR12MB2533F35E3050B8B3F2F665AEED730@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
 <20200728074934.12490-5-guchun.chen@amd.com>
In-Reply-To: <20200728074934.12490-5-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-28T09:43:17Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6f38a99c-a8be-4658-b5ef-98461a6011ac;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5619b9e-65ef-4ce2-e824-08d832daac66
x-ms-traffictypediagnostic: DM6PR12MB3002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3002BD84A2D64D6167FA5DE3ED730@DM6PR12MB3002.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ej2eBPSUkc4Ngk04l8jh7743LJuGaS3Tu0jT2mCAikNaJht54HFkG1OpUlIFDgjOn8PBXOm87VP1vQMoJ7rWOCbBwd1iUqTZGDPvF7J/PzluSb47pqsdQzxUnV2Y8+5KRDam0MCvpf6wPlq4Fki2m4uEchaci+pp0nGs3DhCA4hFn35z3SdBTGKJOu5YNuMLRL9lZLKEkuGxGGRVL/fnixMcA6FOFCmG8336Taf/0MYziGN7MUFy1T3lnyIn7hyyMYjh2UyPFRHGPwLN1d24PMVbJRck28o7OvDtu4PmhPiwzv+lyHSaaF3/zD8HduEALydyw5L6Q4yTK1mP0mVrnHrpTt2fpxWOXygSpeUrd6b5s2RHHKAcGBfgB+Pr3r4s
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(7696005)(53546011)(110136005)(6506007)(8676002)(9686003)(71200400001)(316002)(8936002)(2906002)(66476007)(66946007)(83380400001)(33656002)(186003)(66446008)(26005)(66556008)(76116006)(6636002)(5660300002)(52536014)(55016002)(64756008)(86362001)(478600001)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EcdevMifNHRLN7Hqh75wjdlyJifdAY6IGTyPaEfTzKw1Z6/MY6ZjuBqAfXkpDleMcWo/SxKh1uZNJc4x6p9h10q1nrQzsTtINvqiCHuiNAcLd8yCpwgHP2CcNXJNtiE8jwir3JUpwSZEHp9zidZ3w7ReadOxiw+tcsx9hKpwswke0V6OaP64NxdW2BhflgPGNJh4PASi7tPRcS0yLGhG/YhA91J5YeYRZm8Mvbvr3B12aelzb6/9YPqCyN+JX64jooJemvRPJQBtZ6TyQ8DsxC1rsYNZh1oFKmZwnw2bXgO/a//OLfArHj6XW+YYnczJM38y0gs5MODYbPPipIxVfHbddS/ZdJXB1LDsK4Ofvc8wXcSxl8wHqJ/LWZJd1jH+aVWjlXTXCyF1Rt3xRJ5FHggQibCdcR7JnsYcXoTmWWGIrMKav02ag/c49VLxku85qWQ2+8uxntUse9l3Hsb+G9oBU4VevDgUJVjxrx2nutxI06QaKV+MRM4/uUVOiYkQ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5619b9e-65ef-4ce2-e824-08d832daac66
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 09:43:24.7870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vlb+Lb5fOOH/QrClcgr83xDW3TDflNi4Nqoqil563AJVuuBTSCmgfVr88XbpiVJk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, Guchun,
      Please see my below comments.

Best Regards
Dennis Li
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, July 28, 2020 3:49 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 04/12] drm/amdgpu: break driver init process when it's bad GPU

When retrieving bad gpu tag from eeprom, GPU init should fail as the GPU needs to be retired for further check.

v2: Fix spelling typo, correct the condition to detect
    bad gpu tag and refine error message.

v3: Refine function argument name.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 ++-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2662cd7c8685..30af0dfee1a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2059,13 +2059,19 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
 	 * for some ASICs the RAS EEPROM code relies on SMU fully functioning
 	 * for I2C communication which only true at this point.
-	 * recovery_init may fail, but it can free all resources allocated by
-	 * itself and its failure should not stop amdgpu init process.
+	 *
+	 * amdgpu_ras_recovery_init may fail, but the upper only cares the
+	 * failure from bad gpu situation and stop amdgpu init process
+	 * accordingly. For other failed cases, it will still release all
+	 * the resource and print error message, rather than returning one
+	 * negative value to upper level.
 	 *
 	 * Note: theoretically, this should be called before all vram allocations
 	 * to protect retired page from abusing
 	 */
-	amdgpu_ras_recovery_init(adev);
+	r = amdgpu_ras_recovery_init(adev);
+	if (r)
+		goto init_failed;
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3c4c142e9d8a..56e1aeba2d64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1822,6 +1822,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
 	uint32_t max_eeprom_records_len = 0;
+	bool exc_err_limit = false;
 	int ret;
 
 	if (con)
@@ -1843,9 +1844,15 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
 
-	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
-	if (ret)
+	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
+	/*
+	 * We only fail this calling and halt booting up
+	 * when exc_err_limit is true.
+	 */
+	if (exc_err_limit) {
+		ret = -EINVAL;
 		goto free;
+	}

[Dennis Li] Compared with old codes,  new change miss checking ret.
 
 	if (con->eeprom_control.num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev); @@ -1868,6 +1875,13 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 out:
 	dev_warn(adev->dev, "Failed to initialize ras recovery!\n");
 
+	/*
+	 * Except error threshold exceeding case, other failure cases in this
+	 * function would not fail amdgpu driver init.
+	 */
+	if (!exc_err_limit)
+		ret = 0;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 35c0c849d49b..67995b66d7d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -241,7 +241,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 
 }
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *exceed_err_limit)

 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control); @@ -254,6 +255,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 			.buf	= buff,
 	};
 
+	*exceed_err_limit = false;
+
 	/* Verify i2c adapter is initialized */
 	if (!adev->pm.smu_i2c.algo)
 		return -ENOENT;
@@ -282,6 +285,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
 				 control->num_recs);
 
+	} else if ((hdr->header == EEPROM_TABLE_HDR_BAD) &&
+			(amdgpu_bad_page_threshold != 0)) {
+		*exceed_err_limit = true;
+		DRM_ERROR("Exceeding the bad_page_threshold parameter, "
+				"disabling the GPU.\n");

[Dennis Li] Why must introduce a new parameter exceed_err_limit?  I think it can return -EINVAL directly here.

 	} else {
 		DRM_INFO("Creating new EEPROM table");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index b272840cb069..f245b96d9599 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -77,7 +77,8 @@ struct eeprom_table_record {
 	unsigned char mcumc_id;
 }__attribute__((__packed__));
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *exceed_err_limit);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
