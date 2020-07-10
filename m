Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153DFC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D785B2078D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NHht77oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D785B2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7421F6EB73;
	Fri, 10 Jul 2020 08:36:42 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700056.outbound.protection.outlook.com [40.107.70.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E716EB73
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 08:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECjPei93XtQ49pdE5OeFr0yQ2wOzoihjv6He4iVahATKRP+MqsGR8lr6MdIb7zevhM2AYlmy2gWUHmKN2F5kN+jmSjKPMo5sYcAm8nVjUbTWk014RxEET6mMU2iDUXG0nmnlHpzOKsrwm25xertMsn1L3NKEm3TBcbePQPHk07Gpm2FH5OURB1zd/kpq4BADl4Up+5++8/uuAwiHJOprvobOEYD0KXDWLE53r3ETLzXQ9MW6VMxeRNNewdB2pmpjeY3JL0iU8zveDL1lFSVbPoDao5+Gj4hGydeJ9dY9WMw0vLeZ9jfoW5UayujJDXStCj6OwV71tVqwWv5bx0WbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CguD/FY3zGbgQYyatgrhzZlJFk5K0WcELI1eWh2qCxM=;
 b=NmxKt/EHS3NgP3WWVeNJYnMpwEHmTbPf6sDztXu9ZHZKow/HqQQW5rI58pOp4vIbB311+PyeJnBPE1dAWuwM19Q+oYgaG8o+DzgWinYc4kZgEThxPjLDdOHVLjOrSfk/ITXZzYIyngNAbhnS/nbJpf+p+EJX6QLyaKxnpAMIan4pc9oMAG/762h9OMHA8hyawISxylpCDK2OZd1Sg3fB+pyLJaRlpMxTcUfL2jGbKz/TNqNmDIVNcstz2FCx2vCDO7E08lCEJjlVgDwsXRnV54SS3vs5DSAMGfmQc4/fSlj0KqDHdSFhJidXg+6WZhQ83JdbnyvmZmlxJCKKmh/JQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CguD/FY3zGbgQYyatgrhzZlJFk5K0WcELI1eWh2qCxM=;
 b=NHht77oWw0CdHa7NInNdseF0VqmvBGncQznk1vIYZByjzvGrwpnjtlhkdzQIUTaYzGSVZNWMF7h4qwJd6saWHt+1/5Ss5yviRbcLOeiyITQarB03MBdVo8ev6fiBEjI12ZC3Blm1nLQDIFT5MV0ycWJMMJlsp9Ez4tcAa/3jS/M=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Fri, 10 Jul 2020 08:36:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 08:36:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: Target power profile mode should be
 the second parameter of renoir_set_power_profile_mode
Thread-Topic: [PATCH] drm/amdgpu/powerplay: Target power profile mode should
 be the second parameter of renoir_set_power_profile_mode
Thread-Index: AQHWVpMZkLB0tYagkESkQR1uQZf/BakAfSlA
Date: Fri, 10 Jul 2020 08:36:37 +0000
Message-ID: <DM6PR12MB2619E2384A1F4DFACC3E1FB9E4650@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1594369278-7808-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1594369278-7808-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=216b29dd-a130-4c93-a34c-00004c8a0f5c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-10T08:36:07Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac21e39b-f60a-4419-300c-08d824ac5c98
x-ms-traffictypediagnostic: DM6PR12MB4075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4075FB2B4E9F6D691E280529E4650@DM6PR12MB4075.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C96aiRWBqF8wqn021c38J4n8c8XDAF80eClgpAOT5vBElR1orbAWkPDOzMvhb+gEtsMniTbq/gvBMKo+6gWOBgR5Isn5KEUKuM56PH/oaABpLvXRDorASVARFNRFqg5H2y/iDm8EdPUMBEFvKt7Z+DqWOIYcq74BgnCFAx1AyiR9ui6f+tJ2rikF5MG+VzyV8V4WCfmrSpUawvjCqRwjRBLzfb3iXiZanezyjBCegACBALtctqdLYeAaMj8mE+0wazEnMjizplLAXFuC/xKm1WF6Kln+FWJy0XwnHH5NN67f+lUdCmyYl6EQgAc1oUgcD/7+0GPac1lRUf7EtN+44Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(33656002)(2906002)(86362001)(7696005)(6506007)(53546011)(4326008)(26005)(186003)(8936002)(8676002)(64756008)(66556008)(76116006)(66446008)(5660300002)(110136005)(66946007)(66476007)(55016002)(9686003)(83380400001)(316002)(71200400001)(52536014)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ZN81U8K9crPy5CXuhXQL5G1fDILDly1I0hUiETP1QFt/w5OK5bqMtAbf0mKKuXWQbKROHFErQA76zs1xPFI7n0nbPx9ALBz8EKjWzwTptTcmu67kh0rX8lrc6PKT7Spz+uwJhQPS/9E0i0JSEDZjhaSGghw66QD/iKKMH6sTjgynBsHlqmYme0Zxn9kY+0DcNsFLbobEOSdlWVm7CeBuQtRxOtsUukbi1WEMjXGDv2HO4KTx0lF2TLOK4etK6C/M/uxbjmWEd1pOt5Fx3jkG5C6UL0aIzfSMu1/YBkFwH1c7CmcmuOX4gBXghT1Ve3y9lfIKtaSPKYd6RaylQAi6SjxoeHTVxtx97qRGjtuv2Dc2MS4HbbErGk2PJb5HAoEtUgPo7MXf6tF/KTnULaX/jtH+2vUWB2G/m+YHiO0qqGZtKGLb6PwVzo3lOjPFPYY93pQxYyLBKXp9eGB28ZZZRvX9+WCTnXN0wgoPMviPF03PxelIYeAh7z+i28x0lHO9
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac21e39b-f60a-4419-300c-08d824ac5c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 08:36:37.8548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqYo6fhxJPvsMsVPkGvndEhMIKwyRZDR4yycZK2cYtIiuEqHzdJ6v+UAqpCcHn84
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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
Cc: "Gong, Curry" <Curry.Gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: chen gong <curry.gong@amd.com>
Sent: Friday, July 10, 2020 4:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Gong, Curry <Curry.Gong@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: Target power profile mode should be the second parameter of renoir_set_power_profile_mode

A small mistake

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index f286c1e..ae87c46 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -683,18 +683,18 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 uint32_t profile_mode = input[size];

 if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 return -EINVAL;
 }

 /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-workload_type = smu_workload_get_type(smu, smu->power_profile_mode);
+workload_type = smu_workload_get_type(smu, profile_mode);
 if (workload_type < 0) {
 /*
  * TODO: If some case need switch to powersave/default power mode
  * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
  */
-dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n",smu->power_profile_mode);
+dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
 return -EINVAL;
 }

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
