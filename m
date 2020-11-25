Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20271C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 03:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF1520663
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 03:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JKWsoZ6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF1520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08DCF6E804;
	Wed, 25 Nov 2020 03:47:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B71989FD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 03:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo2rq9NJjRd1Oe+wBP8J2YcQY+9CiZh9hNIez07+s1Sv68dCSHUN3sFnAeF/Y1kpaWVOOKkRZBH13kFD6SARv8EvFJEGSTsVr9crEll5GSIRSDbFjhGZYW8ksHtglqeddfLuJOpyS1DF4RUl729i3vAPchig/ljNdG7zHDC4ayWbg+001yfQw6xFB7WUT+3hlTDZWPG3AUp4HntysTwBvCZSolMd77K1nsLxG/DHI95LWOuEOLw+NGnM2fGTUJCcu0oaiq4cOggpfZQqpKutd/wiZaZ5FN1kFylm8gGA1vYaojyJAy/k3/iHyFzYkbpo1oV8UmIVpGethOLPKYK0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmQ6+PjaiP3UapzDj0+X4/s3FepbXdVRmHfofsSlEyI=;
 b=RaNEzESS4tMqvwCC73iY14Ko/G196jlQ0jSqXin3Vozr9HTxq7yE5n7HRHdmHGgnuTSRBQRC9fuFkUzYJMnCzjpeyE8QYsK0yaBmOVYcide5c6ZG1UajTqYQ8OgrxP7BUnfChbzkYCOOFx0RaxH7XwKj90C0fTbtvgEbNQCZpqOWDVRzpb18c+wJMQFgmTNXF5vZs1nOxMPzE/MgtujCeMp1iOm3yTcY+WkF8pQmOPDkgZspKnPrE22J1gu62z+bM9/8p7Kiwaq1sZNoU4uQu0FFWfnLX3vYdxF7WFM1RzT8i3ZXnPvlrKOAlSu3ZMYvD0Jzn1uUIwLJtwWe6Pg5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmQ6+PjaiP3UapzDj0+X4/s3FepbXdVRmHfofsSlEyI=;
 b=JKWsoZ6hvIfqLXqbc/WflLwQHKdtc/8wfbfeus5DiUOL+a38i8TXKH78FLU8CRlkqr3JrEBqpppbTwhi1ovBPlslb3Uh2yEB5mYnaccXd4CNpHQz/XBrVPzPiubkZxSL7SOnvHWpad+Ise2900mEelsyryZA/1FhNYlRU5cC+0U=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB2501.namprd12.prod.outlook.com (2603:10b6:903:d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 03:47:25 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 03:47:25 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: set default value of noretry to 1 for
 specified asic
Thread-Topic: [PATCH 1/1] drm/amdgpu: set default value of noretry to 1 for
 specified asic
Thread-Index: AQHWwZp6TKNFAy5rekOG1cDdJH8AeKnYN13Q
Date: Wed, 25 Nov 2020 03:47:24 +0000
Message-ID: <CY4PR12MB12873D2D87ED55EF438B7DE4F1FA0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201123131334.21704-1-Stanley.Yang@amd.com>
In-Reply-To: <20201123131334.21704-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Stanley.Yang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-25T03:47:07Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0c1943c7-4d67-426e-a2f7-0000db8605d9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-25T03:47:22Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 58d1f4dc-3016-4ebc-bd43-0000f7f74001
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.158.166.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: caa8c076-4598-40b1-0344-08d890f4d276
x-ms-traffictypediagnostic: CY4PR1201MB2501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB2501A017E146B8B1721F7D24F1FA0@CY4PR1201MB2501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZoiFyz6gn0bjIjLFbY2ItQvknavTPVFbMRpxmQaEB3nxE/wIekNJM58WzI9zN008Wp/K4tVG7rAwcLKVs/njRfxTbstYgRoSzr/xc0LKEhz9O5fAsfUO713XIoeAUBxP32B/eocDjG9HsIFVoiwnSWPUlRZ8vb8dOBRPgHnJKjZsYEQx5Mdq3i5elQJie4CgClD1+CW9EwidrZgJAy42VHvwg0hWwHPbUbbnE0L92MRIROog/EdbdLUNtXjns272pSWrOrZu+yKP4jT9QVzMrnyVLa5cJMNQ6aOOgegrUNBu5G+yKP5W33ph1N7mRS5ACDvtCUv8PsmcQehbdiyURchg8h5CmlxzYa0p0wJ9bes=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(316002)(8936002)(76116006)(8676002)(110136005)(52536014)(66946007)(2906002)(66476007)(5660300002)(66446008)(64756008)(66556008)(7696005)(478600001)(45080400002)(53546011)(83380400001)(26005)(33656002)(4326008)(186003)(966005)(86362001)(9686003)(55016002)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tuEXjIhc2C4dKG9Q2UiGAin6EX+jfU73VzSmQw3bYZTFi0pj+ZyM1rQXPy/m?=
 =?us-ascii?Q?eiBp5kcC75Y0hI3HaLYdI3rS3xkrrdaMf/UyX8VI8ne8pDm+tw7eGPoeEMC7?=
 =?us-ascii?Q?VTJyVMCZXnANpNvnXAKOb7TX8XBSSJdniLajSrlv0exgkmVaFd/4SJD8lwd0?=
 =?us-ascii?Q?NS9zAikyGoJ8DoBM49Khv8G8V2RpFfbSNX8KlNo3vQSYLt577YFLziamavxK?=
 =?us-ascii?Q?3MFFwCJOoNMDUTo74Pme1Olb3VcjpalEpWaznfzQV6F1MpWJA+KArr9OwYyX?=
 =?us-ascii?Q?biIEo4/tfaACx15Auw56OrLedRvBJLzX38MbQlKo7oPqDCqTNUdWaTqYwkuQ?=
 =?us-ascii?Q?Ux4xDeYi7dBEW2U6klOPhdkoG2sPoF/icfsjlhFpjZL4D4HsjcV0qYYn8lki?=
 =?us-ascii?Q?vGYIR44MZflMzIR/k7ZfoIwKoQneGFxezCGtHKn7iUOG1lYiXDK1pHbGdryI?=
 =?us-ascii?Q?2k+l/Mo+FHT9TYsOpxWOpLIlkgCusNubOtXMscgGyh+VfGp87Uw1DZ7WxAT9?=
 =?us-ascii?Q?bs+yEFONkj+GrDolCgALGExCsBYl+Aou0PoTHMY8QgT24X32DvqmTehl+SMq?=
 =?us-ascii?Q?K3XPuKMtPFot9rG9PMGDpE3x22godAwcXT4JIQb/u4bmtZ6dj779mmhM+K5X?=
 =?us-ascii?Q?BXXw9o+Sh89sj7iWOV+Nbh7kxAuId2FBVc6yEGE7+t73SU3MDcfi5f2okNxp?=
 =?us-ascii?Q?IU8sgdreS8+MA2a7fI45IeP7ySp4h/cNsyaQkscnsI1+GGGkmT4shACFTLMV?=
 =?us-ascii?Q?V2EUBFckqww7CEjfB/p9aFSG5k3s5MVs/2sbOyBe27IiHW7DbgQ88N7YGxxC?=
 =?us-ascii?Q?29+DBW5WublQjs/XhR2E0E299ezRdh26QJRbLEXhFtGKkXT7C3JDNUf7MOlL?=
 =?us-ascii?Q?6hRp4yF7k48bVW98mR0iGFTfXX294of957/EmlE2X7Dj5XEZJwE+tF7u2mt/?=
 =?us-ascii?Q?/eZdCO91W71dB26Gd8q3reWAmcIesYxySz0EQF3WwjM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa8c076-4598-40b1-0344-08d890f4d276
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 03:47:24.9534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIfxZX1QIZtaG0tdYbM2PkArE2SlOQU8XOy4iNhDNylYLAUmbpVXWrfHjSbFb6fuhBKPGk3pz1qaqwwGVeBUxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2501
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi @Stanley.Yang,

I assume we could not add such patch directly, as it may break the KFD test for Vega10 bare metal case.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.Yang
Sent: Monday, November 23, 2020 9:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: set default value of noretry to 1 for specified asic

noretry = 0 casue KFDGraphicsInterop test failed on SRIOV platform for vega10, so set noretry to 1 for vega10.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I241da5c20970ea889909997ff044d6e61642da81
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a3d4325718d8..7bb544224540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -425,6 +425,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	struct amdgpu_gmc *gmc = &adev->gmc;
 
 	switch (adev->asic_type) {
+	case CHIP_VEGA10:
 	case CHIP_VEGA20:
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C6c424996a1ec4400854a08d88fb19a4b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417340267761056%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=J44iMaigk%2BrCZ1m%2F%2FtQttrhDPrGfrBnyopA3w9sIP2o%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
