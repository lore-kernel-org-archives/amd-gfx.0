Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285DEC47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 16:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB508613B1
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 16:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB508613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946E96F4CA;
	Thu,  3 Jun 2021 16:43:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3B96F4CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 16:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8sOPqoa2bjpeiaJsh2d1uq3FpEO5GExqfmDkt89e5c//qpk3dzeW2TUqOGlc57oAMYX/8IRGC0frOQERtDdQQu7njnHfn4MNUWTGnW0x5hgquOX7uYX2GL52Skci1jLbC0H/Es0KfiFa4Dts1k8LI9gMuf+cBq1/6ofDYAwm1GdOkbocczNhs4jrVfr5Kt7H/4X+hWlXNjobkTR0pm1LnjjfonQ95Z2RikYAiDDVzxswxZv0MOld8RcqYJMmpHAoWmAxjk994T6QDDtdcNpyKmiRrFdZwBrdafOzx1/nE5ZhSnoeEs+BklzAZJKg8QYlmXUEt4H+wPcffdbZ9kOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3JhZgtwow/khwCh3AOTsC3Pv7q57ixnIKGSb2A2X8w=;
 b=UFetgJFxXoZqlepi4FcvcJA5jd5azCmXikusWGCc17UC5tGiuveTc+U7LNoSagSSeAcvmT7NQwquz29GAUsBVs3xdKQqgZiQDoxiF6OJf1SAu/u904f0CtmeYGMIUSs3DUYI8MPPqRMx0vGKQ9P7R/E7i1VARF+id1t8Q2PJWD+rP+L7Jj+IHDZEOHlyR0jOWnl7fSlI35NFTXg/WgRCBBgOAl/L1kai7eWSjkZN6oz7iVjtgYJeFg2xwqMLBvUmUGmcTzJrDqvZewSlCG6Ktj+JNflmW39NjgFJoXm8m1nOZS/Z3fGVRmMFjmj+yrRDUEkQJytG7hswWPL5D/NjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3JhZgtwow/khwCh3AOTsC3Pv7q57ixnIKGSb2A2X8w=;
 b=HSLC6M6qf6TxON/nGK4BX2i5F7KHMg8Dc4yCPIpYtxShBC936HDIrC2qjtJr5wBvR99WJAw/GFQ+0AjmUAQ+Njmh8UuW4RSY5AK2kHEosl9NRFTVON8YdE+4DbxGDFip34lqAn20czqAsBgN5mLkt9JDCF/wrmPXnP8hTvVvtm4=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Thu, 3 Jun 2021 16:43:07 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 16:43:07 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM
 for sriov vf
Thread-Topic: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM
 for sriov vf
Thread-Index: AQHXWIKofNTtQ+5zXEKXgCLsVxOrDKsCZNkAgAAJr4CAAA88QA==
Date: Thu, 3 Jun 2021 16:43:07 +0000
Message-ID: <DM6PR12MB55344C9909B4490FE2C5AE94F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-5-zhigang.luo@amd.com>
 <DM6PR12MB5534515D4D05368A9CBED534F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
 <BL1PR12MB5317C909CDB48412330A608DF13C9@BL1PR12MB5317.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5317C909CDB48412330A608DF13C9@BL1PR12MB5317.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T16:43:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=df1f9e2c-ea56-4c00-8085-da23f87c8241;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0801bccb-e228-40ab-9376-08d926aeaab5
x-ms-traffictypediagnostic: DM4PR12MB5104:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB51045C91E03290174A7E72FBF43C9@DM4PR12MB5104.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HuPFB/rGQ9LZ4Ewln+7lVYY5aVEgjeLZitQxq6api+DyiHIW9JwCWFIEg3wIzDZORCgKXYIECkBaS7Zjc6klPUM6JIXx2+DwmHXE5TgTCVPFlXUBsErg3MGlbt0/B4ijb0WjILq8G+eev9T7uwKhUDN1de7MRjrS9zCM1tWrBKnRRmld4DbVH1K2tJOcVoZjPB1Sv5nj46aaiZ1HH8hlNf485kHjxzQOSeZFtB4vNFNiJ29i4Lge4k66NPn0//XnDUxYQDuHmNg/GMHI2ms9DWJfVSXttkhOkCNTwlHCfgO7suirIDmWqSfrMiuB7T6sm+beAPT3EwLAvUYJ9uqAUl1D1WDm5wB9t8dGBf2DO3xDB+2Zb4Yhw3/tNM3qTWTxYVtxJT85i8eQJIcm1i5+lZd/nAY4rwYnFUBXAKlLOcU40UL83mPAxEgDsBjfLXJyz7rjKdK9uhOwUlHCzWRamUTyp4cY0PZmtjONNBxLH4RCdqUmzjT9/ylJiAtgfi6DJB2+ME7/rILch2THnAgzppdtRqB50PWgFvuSnWOqDmY3Et5GpqguPQbwPguxmanGwxFtmZGFyNNsZTkps8dae7nnwkj19c0Odj8B3QG4X1hOMM+bqmL6ZWPELmaAFFcZhMSGA7MjTDQ6OMKeHgjq0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39850400004)(346002)(396003)(136003)(53546011)(26005)(52536014)(6506007)(66556008)(966005)(7696005)(5660300002)(110136005)(316002)(71200400001)(33656002)(9686003)(66946007)(64756008)(2906002)(76116006)(38100700002)(6636002)(186003)(122000001)(8936002)(8676002)(66446008)(66476007)(478600001)(45080400002)(55016002)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+vpscKuPEwvLMlorjxtsU/geaG6LLyrwrjrbAKkUottRQHYP5ocSzYF/qIWO?=
 =?us-ascii?Q?54VHa/BF+knymHbQOEBFUc3AH1GHm+0FY0WKTNnurrCsyDSiO3VROzEtR5re?=
 =?us-ascii?Q?nAEEh3G8oNWg15+8cAsmyWfanl5TtSDKdUn9xcly7dBcMjq0zUn2T26CqMog?=
 =?us-ascii?Q?DPxGiwbTwZ84Nds99Vfl4qgaNDw3eYC1GFbQgMZXgWv0i9UOJlha2xC98AfR?=
 =?us-ascii?Q?iT7CkvyWTvsxmisuaZ5H9P+6EMiqLNaTG9V1YmBp0/72jy3V3u0r403Ru+aJ?=
 =?us-ascii?Q?BWT5IsqlFulEYvjAtMtLQ7XiNW/5qyvHKhkfauJDDSCKEE8d+iohvnJ44W/O?=
 =?us-ascii?Q?RLa8TO4POa/wdS29igo82M3wY3sHAMx1aNiQVPlfM5i7vFCtyNX1eHkPBNFx?=
 =?us-ascii?Q?KghFypCngO3f7c07VGdxKfNORQ8ye/HU/LLC3LJTQFYgpRUvAeGB8a9g7QXg?=
 =?us-ascii?Q?rhcnHrbNufSzgHxgIewypA0L94DGGFbTUGbHDu6HlPkZ6HZy2ffsvNCqkCB4?=
 =?us-ascii?Q?9PMx+IpP5GlZJ6WbanXthd664/8Ymfc3NGnc1a/sEObouzFbFOj9L8rqBvMT?=
 =?us-ascii?Q?KqSBzX5crR82LRTqCD6OoHbgzKT6mmw2eLgU0bL9uT1TtgfPxwa+t7hihHf2?=
 =?us-ascii?Q?IDJDr+WUm3CWOkiSV/3PHhMC9nwzqHWYw7vhmjUBDkLeNKHCbA8oasoJ3hbZ?=
 =?us-ascii?Q?JHAG7r+pXnL9hjVeShW0bTvITscsgXN2ipAZFcI4VsECBrqONNbdprBy4wxq?=
 =?us-ascii?Q?k7JM3jB6zBP+9XqwHkIugR2YGuKyQ5Q8BXEJq2zL2cQ6/q4a1q4GKrxqM+UB?=
 =?us-ascii?Q?Y7wYrfbZVaroU9Ht/uTzvffCxV4Yxh7Y+X+nXPg/RP98UtEYlkbuu2vlVON1?=
 =?us-ascii?Q?RfTWQb8WQFYezugMkNRpApS+nQ2pU3NRuIaySBcCeXzanuUzG8h+kh14onxc?=
 =?us-ascii?Q?KgfMpmq1zmp8faz5PXW9CnKKk5xshCgtGJIfo7MARlC08zYC7rAkHmLoAy6F?=
 =?us-ascii?Q?W5OB7TZ17ejLLcrFh2gnF4l2q18LHYtpYhB8gUZCtVtc0K6Tpo9xhk0p0kNQ?=
 =?us-ascii?Q?9tQmhhuBRuXpbkWbqfBb4HywyZ1OOWRaZAUeH/PQ/PUloFt9OIciRzkbRZUE?=
 =?us-ascii?Q?Fntv7NBl4JUqn8Jt9OESTpUa3FqOu6C6eNIRJXcONljKP2C0yK09eHxi02xC?=
 =?us-ascii?Q?8v0LIKH/VS7DLlEpuDe4rP5uwvTol53fWvbTIyGsRT7QtzaopFI4z5He/bRO?=
 =?us-ascii?Q?2SPhbklpSykbaBGSNyOa6Q/Mj2GZsSXVUmx3zIwwx/6dSC6RnHZN/fexsuGb?=
 =?us-ascii?Q?Pj8JbQb2IC8ELSJnEqe6KoqD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0801bccb-e228-40ab-9376-08d926aeaab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 16:43:07.8582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24Jyt4XlCNz9lpIuF8AGpRPLvdRZR9aD141oEQ8zDI1TemyhcnCUJ0ynbFQK6YweGYKO9cc1vSOECoBrgvfqcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
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

[AMD Official Use Only]

I will leave  Hawking to comment on this serial . 

Thanks 
Shaoyun.liu

-----Original Message-----
From: Luo, Zhigang <Zhigang.Luo@amd.com> 
Sent: Thursday, June 3, 2021 11:48 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM for sriov vf

All new PSP release will have this feature. And it will not cause any failure even the PSP doesn't have this feature yet.

Thanks,
Zhigang

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: June 3, 2021 11:15 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM for sriov vf

[AMD Official Use Only]

Please double verify whether this feature apply to all aisc PSP supported  since this is not only apply to ARCTURUS and  ALDEBARAN. 

Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM for sriov vf

psp added new feature to check fw buffer address for sriov vf. the address range must be in vf fb.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6bd7e39c3e75..7c0f1017a46b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2320,11 +2320,20 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (!psp->cmd)
 		return -ENOMEM;
 
-	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-					AMDGPU_GEM_DOMAIN_GTT,
-					&psp->fw_pri_bo,
-					&psp->fw_pri_mc_addr,
-					&psp->fw_pri_buf);
+	if (amdgpu_sriov_vf(adev)) {
+		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+						AMDGPU_GEM_DOMAIN_VRAM,
+						&psp->fw_pri_bo,
+						&psp->fw_pri_mc_addr,
+						&psp->fw_pri_buf);
+	} else {
+		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+						AMDGPU_GEM_DOMAIN_GTT,
+						&psp->fw_pri_bo,
+						&psp->fw_pri_mc_addr,
+						&psp->fw_pri_buf);
+	}
+
 	if (ret)
 		goto failed;
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7C3f624a72d2574d5c10a808d92699c9a8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583264223318916%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=4EfyfR26TENFq1%2BXlSufuOYocdCmNcdEZHyEPzAQPcc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
