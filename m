Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1C3C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA66E61185
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA66E61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801296E8D9;
	Mon,  7 Jun 2021 13:59:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA406E8D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0ivOERswp/WDNg/oPkqQbuIU/JI1fqk1PKg7Y3lmjzRD7EB988t1JexsszPjnKmJr0eUSxKiNBD4R4d256hLBoTqce65j5YRFlZkj0UWgEh4J4uv9c8jjUVjedImFQASKiExZxS2+3JxA10w40p07ZHFV/ePqFvWhZUCthDsdlkXGhdB1TUg5smazV3he5YvuGVWtUPIu+3Y3FEkH24QCaJ/g3tGxe/1Tb9NSJKfArvbpb67lAUAjfbQY72aSpEZQKfKNzAo+FvqytBl7cFUoYPlJGw4LRSEHFSyisGTKuAt2tRYet5L1DwRog6ViE08hFrnyOnTTxniNZrnrn2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vYzK1Dldj8vS3wKNsr99EOXYWch3hm2wU/NYmBqblM=;
 b=M5TGIrcltz03b9HxvEPD6QWREcep2H48XUIw0AHQpNiJjEKsnXyYhS2bhoSQ5dRad75RydKsjgo71POUjfJz9Ar6aDNaEtJthNDAM8qrOZhTx01u1cG+AXpGum9RHLm7Y+v+Q9/ZjU/fTZk158CoVUf0nRUya/n9IwvVHotpSFCAYzzuEJumHhD8sr/H6cgpyDfJHPOoUnsWJjImrHUfiICgc2Yi7rET3Jpiv5Fq/yM1rt0t0e6PQBYaq1GQa9fRjiSf/COpY/W2VDlYqurNnp3fw7B+05HQ+RbgLmMLh/e7mzN4gMJtfxheHV9l2LeDks13Y06it9rGYFBZXQ6PNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vYzK1Dldj8vS3wKNsr99EOXYWch3hm2wU/NYmBqblM=;
 b=br9rkr7JqcTG4YT7CS2CaC1TwtdRV5z8cqnlu9p+DlxAzmQnJE5SRabuePBwTDuZe7BZRpxLF4Vzt0NK/H2+TRurK+eFFrJlhjimijvDBSv7nBYCe/IQY5Nzdy30YyjTQsVWuPWvHuxd033hzRk7xXSlBDcEOVZ5XFcLqhvv4VE=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 13:59:41 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 13:59:41 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and
 aldebaran sriov vf
Thread-Topic: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and
 aldebaran sriov vf
Thread-Index: AQHXWIKfcL3O3knLbk2rT6fkgWUYlKsCZMYAgAAEp9CABi4PgIAAAVfQ
Date: Mon, 7 Jun 2021 13:59:40 +0000
Message-ID: <BL1PR12MB531764BBBCF134D9E893318DF1389@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-4-zhigang.luo@amd.com>
 <DM6PR12MB55344CFCAD9394BC48B36665F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
 <BL1PR12MB53179B09844D1195B7DB3B47F13C9@BL1PR12MB5317.namprd12.prod.outlook.com>
 <BN9PR12MB536854A30D4B84DF839AD285FC389@BN9PR12MB5368.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB536854A30D4B84DF839AD285FC389@BN9PR12MB5368.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bb9e67cd-c7e9-4d10-8c1b-efc80f472007;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-07T13:57:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.8.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a99b498-5100-4ccc-74e0-08d929bc7ef9
x-ms-traffictypediagnostic: BL1PR12MB5364:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB53647D7EA458EC3C5A640C1AF1389@BL1PR12MB5364.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nps9pCFM3aG0i44qH+zCba9JdTW0mD7gi/yM88asvJMJ43VwvT/ACSsWsoUhAGV5lA+urlI6POLMN6gld6YM4eyi4wUrfD87Nu7EsjoPz14lUoUIJWwhMf39VAjEPg0gDZBKw1aj6ZT38dNM9WN11/u/SQ6Gepx8LOO8fv0WyzPSQeavyz5NAF0ZyWjfAJmgTt+UQtnE4fq7ki5HE6ZNrJ6Mb7SVt0CovROIPTjIN+0ogEnWhejkj0AXb2iG/iG9enwda0uQ+HECqgli4HlWD3XKKkS+TtulejO5s812X4LDUXSak6wuNdbOOmpiEWHvwnpoE/4xpf8cKYE7DiPd6ZegP8Aw/DuPhV8I87wsRPv6R6SShurzx8Dr3d7eX03gcTdElaBoJkNBjs5mlY9Zg66RT+BtHi1AwUnYHPcRiuJDm46bMjk2UA0WwHnbMk/behAjsCDJY0LWBYjUGYFM0FysB7dJvuuW3K852HvCSPObIpSpqynivYCwkyeC5pZ97HIW13YajE7Yt5c/XYh9yaw0iwzIksdx/n94UxDgb6h9mNPipnxp1UDYXyaG0EgsVni5wJXXggTTolxUb7ZA9n81PY2qJWRqsKGI0L6KLXw5v6/fhdSZsltj4DHXQTL186RNzF/o2b+1SGMS9yvNoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(366004)(110136005)(316002)(83380400001)(9686003)(76116006)(38100700002)(186003)(64756008)(66946007)(5660300002)(122000001)(71200400001)(33656002)(8936002)(45080400002)(7696005)(8676002)(53546011)(6506007)(52536014)(2906002)(26005)(966005)(66476007)(478600001)(55016002)(66446008)(86362001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K2N02dV135ftKLfxO3Y55zivpMycU6Bo60fB8WbvLWZTN6drlFJ3GvDTLVCP?=
 =?us-ascii?Q?bQ9z5g86F0eO9C8q97ZuAui4ACASGeMRyDJmRepFGp71tidaQEYwHiZRJb06?=
 =?us-ascii?Q?17NtadMX3hX5x/ZGvPAd2B2cL8whYq79u9TfGMr0em+Px4cxHwsS37qnpexd?=
 =?us-ascii?Q?5GOi1lyDDi4U7TbrluBojtExy4PaYzN4B5M9k2jyuXjWuhK0CZ+cNo2Du3Sa?=
 =?us-ascii?Q?5zWWJY6XK3LMJZi4sOln3N5RocRcCCtG2oI8zscJGjXLNnPQzy9NFwtFWgba?=
 =?us-ascii?Q?lCPo8aiKNLvqywQ7Alouxv77TCnbHo24xHr6xS5Oyv3dBhsXnnpUZIiC1TVL?=
 =?us-ascii?Q?T1Xx1mNsbu+RyTReo3A4wcPGe9QSyKClMHacHVT29UQ3WS+id4pO7X3Wc3wS?=
 =?us-ascii?Q?vJsBxfCx0wIrrvrU3cdi5JCOA8neO2VJ5JJphCg3YkkCztsHiaVm8EiPDb61?=
 =?us-ascii?Q?1Ja2Y+bgMRTn5e0N9Sfw7UfKEnd5DhkhKwCiyOxFH/tmMLwKZaAYjgYMmlX1?=
 =?us-ascii?Q?Hnr1QIBS4zExC+s7ZGBlY1i7m1oJIN/lGUxTJqvS9DBJeDG1sMjdTezzazX5?=
 =?us-ascii?Q?GaMfYon8UKtq0LnAsg1BYlprRNRJhsCO0DJri30ykbeHI5Owk54Un9TUTXHU?=
 =?us-ascii?Q?Y0A5wHA/dzTEXSt/oMDA//jeXXl4K9RdOzV5YjALAVIdaf4GMf/Ee8FOCM3D?=
 =?us-ascii?Q?s39X+my87Fe6/SD7tskhV5DwiCMoXIE5AZ2ikECqaaPZrJFi7RWN6Jgs34J1?=
 =?us-ascii?Q?y/fnZSvMkIRxJcSFS+sO8n5pmVYRB0qG/YhhIiaDQjP5nhUdFwBp3iLreN6d?=
 =?us-ascii?Q?oW5LSmu24b21+i0zDJPwVz7tNM3VQr+8qfS2wONztg4uR4u+pa6HZp719+e7?=
 =?us-ascii?Q?ObbI5KQW+7fEq0E/o4kt7MSJyDyXf9KBOd7C8cASYGqSt8VArJ0TpCW0b5wp?=
 =?us-ascii?Q?a+GZwJrq+CriAiPZSiiZ/VOsFm4ss0UN2hDPE8mTVnDipT+4ZKcejkX6jAh9?=
 =?us-ascii?Q?X3Wz4tDMHaJtMDzH/rs0ZHGYGXIeRjiGoIHmQX8ZWAeedbZHIM1n1yOnPQs9?=
 =?us-ascii?Q?JKLmDD4DTT0tgn/xUjmi+BT9kc10lGeZnSF18/AtEcN+tSslwoFU/4j7NJEj?=
 =?us-ascii?Q?//Cy3f/Nks2GQBRAJORVu+pXINHB5jjEKAgsPLsAdbc2fYesvN7P5CVh6RwA?=
 =?us-ascii?Q?bSJpS+XTdyG4MZ17+dJRM+X23y7xOeOkbxFsIwyRbSr0Hj/YVas9mmNs8X1l?=
 =?us-ascii?Q?iJrwDBJIYeLk+jxqcpoESJEIH3kDxQo0mgeVdZSNHXbrE0tqcoJ2c85H7atr?=
 =?us-ascii?Q?JXM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a99b498-5100-4ccc-74e0-08d929bc7ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 13:59:40.9737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dnIaZhRzSosbYdn/yEy/yfts/kH5M989/6iZeBmCWenr0ubaFzpIc0+WX27xqsG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
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

[Public]

Okay. I will update the change as you suggested.

Thanks,
Zhigang

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: June 7, 2021 9:52 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

[AMD Official Use Only]

You can call psp_init_ta_microcode directly in sriov vf case so you don't need to initialize unnecessary psp firmware structures.

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luo, Zhigang
Sent: Thursday, June 3, 2021 23:32
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

Yeah, it will also init psp sos and asd mircrocode. But I think it's harmless.

Thanks,
Zhigang

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: June 3, 2021 11:13 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

[AMD Official Use Only]

This one  doesn't looks apply to  XGMI TA  only , it's for whole PSP init , can  you double check it ?


Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

need to load xgmi ta for arcturus and aldebaran sriov vf.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..6bd7e39c3e75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -170,7 +170,8 @@ static int psp_sw_init(void *handle)
        struct psp_context *psp = &adev->psp;
        int ret;

-       if (!amdgpu_sriov_vf(adev)) {
+       if ((adev->asic_type == CHIP_ARCTURUS) ||
+           (adev->asic_type == CHIP_ALDEBARAN) || (!amdgpu_sriov_vf(adev))) {
                ret = psp_init_microcode(psp);
                if (ret) {
                        DRM_ERROR("Failed to load psp firmware!\n");
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C36ad44d9dbca4d9ca2d408d926a4b1f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583311075104399%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tcFmUpgqBn0YW7B99DfjQl4cP4k7%2FHQGplQU0Zjj%2FGw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C36ad44d9dbca4d9ca2d408d926a4b1f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583311075104399%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tcFmUpgqBn0YW7B99DfjQl4cP4k7%2FHQGplQU0Zjj%2FGw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
