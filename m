Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79618C64E90
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 02:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9EB207FF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 02:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vMM+YBqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9EB207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2131589E63;
	Tue,  1 Dec 2020 02:00:03 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680086.outbound.protection.outlook.com [40.107.68.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C4789E63
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 02:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxNd5IrirLvlZSS/Hu5vBbPb1/EmAM43wRe+tJLcZrRkHNtdWFMeWr+y1/7BsqSew/r93qTOfSKyS38yVwr426DavLm/82uFB97+V1VbFbk9ZCKQ3othC2eAzt0bFhKInoohWwfk3j/ItrTrEfnfzZSKElHD1MPqqur7gFnWawrwQZKinkcPqZ4R5YsBYB3IMMgoa+fA9HTCKCrLdxoPn7b4N50Kl4Q7won0bTVUH9Cd1DwnzmQVe59KaDO1nZTwZiIr5KV6ejhvL9e37/OQ55RwIUWgTEumQOGPyecRqesfJRYdXyNzpZFiV9AFpwIw6e+xqlsc2pbFUup423Xnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD+Z2UguvgvsK4CcleqVrLXXLqVdr0JZzSUGuwVGoQg=;
 b=j8jONqd7tLOWchgOSMLl7svK2am4xDsnOlbwcgvjgASjsjZqzrMD+ZkL/jlvqgs9ggFCXmQhsX3zsgEfpX/9B00PaFXoBJHoYg1/OH//8GB/tyLSIrrAY9JTtEC2jJwkkJ+zNqTUuUQcPuh55iMF3cq/a5Be33fcRQqEkR4qyM47jyJhjHxEC0E03bRs69iX1Pcy0/bCOK8EYnyKMxBlWZl6eUQNiIjUYEzo2kxkPfmJ0etIhbl+YVze2neF/2UZb0ZH+DFqmQCyKpO32RCTUEd0eTds7VFtjXmNjtdnxJ1Hmxt9kyihqThJjwHP+2OEJMoE9kxA5Znrhsaz//a2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD+Z2UguvgvsK4CcleqVrLXXLqVdr0JZzSUGuwVGoQg=;
 b=vMM+YBqRxZvk49GnSl4IXTB9BwLIWRPAnu4uF/9g5g+OztbXLDLMDzznExr7M++/uxvgnbjSegVpfJX3J4FJJBXjBKc7aHF35pfueVEnYE8QQvAjtP/ZA84OJu5qUAfpV5RWhsViCLZogzsyy5CpsluYeFkq8YAeBOp7mnSCtTc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.31; Tue, 1 Dec 2020 01:59:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 01:59:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: return an error of copying to smc
 fails
Thread-Topic: [PATCH] drm/amdgpu/powerplay: return an error of copying to smc
 fails
Thread-Index: AQHWx220ywmzV2t8rUK7Pf++NLNFCKnhfHNw
Date: Tue, 1 Dec 2020 01:59:59 +0000
Message-ID: <DM6PR12MB26196F98AA3A331C9F5CCDEAE4F40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201130230811.209647-1-alexander.deucher@amd.com>
In-Reply-To: <20201130230811.209647-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bd124890-1d22-4f5b-b083-06659ac47941;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-01T01:59:51Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3eb57501-4c96-47c7-242e-08d8959ccf51
x-ms-traffictypediagnostic: DM6PR12MB3466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB346665479C43668490456962E4F40@DM6PR12MB3466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:372;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pnXd127hm7NDwwZ9z0SH31xVfmmq7H2RvbXkO7kBOF24xzo9RzpE8vzVwDMq445morWSrBFQBODuCdnZASzNpkpJjEVl+omSd/UjViBz+lu8lqezRn2FxmdwF/MnCpPmB9qg1Dne91u+v1u0FxZplc4GWRn6tQM8czHUhyaKog/j+rwpSiUepmJdxazZ6nAUFQfWPER84jkwMgeMZpRoXQEWR57SBpVckS475QPClkGIgHPbDoRpWOY2yNdwIHjxm9EP9RhjrX9CSpyj37ZhqIQevAtkvWPGQn/6YR0AXe2iWmVhdO9d0j7u1SRIUwIijJv0NwM8PZjTGB//6jFqt5lpDhY2YsovUp8rg/itbE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(316002)(478600001)(110136005)(45080400002)(4326008)(55016002)(9686003)(71200400001)(83380400001)(33656002)(6506007)(66446008)(8936002)(186003)(66476007)(7696005)(26005)(64756008)(66946007)(66556008)(76116006)(86362001)(2906002)(8676002)(5660300002)(52536014)(966005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q6wB3ERsd/kVP/ZjJAEGeLC1QlCC3JQbhyU2jQUmJrAuC2ae9BbTW+BpJxvv?=
 =?us-ascii?Q?zxqFVxkXsBq9J7iDvg6eLBp5JL+t4Tnl4qOdpNxBFtO1EQAM96P3rZ5/2JC4?=
 =?us-ascii?Q?DOi9aHDNACtOz2M3uhPxkpFiVWiDoiA32x8Q1aM19HZEiEB9C043w1Uc9Uw/?=
 =?us-ascii?Q?XSDs85SH61kxjgpW4lDx6jpZhctRwvncU+kYXkklTTSrXLttxyKUguzQAT+H?=
 =?us-ascii?Q?HTdZHyAN5O2GKMQ1WE6afeAwfLWryNyUG2q/d322FmxctU5MNC7rZNOFCRzY?=
 =?us-ascii?Q?2Mio1Vz8amzGI26r3JqETtoQgtRjcyETlTpKYrB2YfvoFHleAw2c/C3Pgb+a?=
 =?us-ascii?Q?PfSDEPldmaT3tnpi8SYn60UbwraRDGclmP8OHJetmr1iTIta79Bw+ZvapS+o?=
 =?us-ascii?Q?fj2kFvJx+0dsua7elbkMT5CjTHOARU2Y9rSfliGTuKV40D+UWfPwEcYfW2eZ?=
 =?us-ascii?Q?FTco3O0aw2oKU/ZSyarGPqu3S1IeVLLSjPtj75nTFaFY96M4KXFeRjzDl9qH?=
 =?us-ascii?Q?887pmpjlHtmGtkw+ILNamuMAG4+fGsQszchKjEzQzdDv4CEUsTEW+e2+StpS?=
 =?us-ascii?Q?g89Jgkj09b3SwKEHYc3CH8U/bhrBusi8eQ1uBOeDuJJIFLadxte3Ux2ChXC7?=
 =?us-ascii?Q?hUCbe3yb9Pj6oUi6FMcgKG6chrvFqrn4iDSB41sp4PSY9feXykpblKAyvx5T?=
 =?us-ascii?Q?Q9yodkfG2t40GgeC2JGSjd63KYrNq2nCP0/OX1Do3zNryRJUfvx0LeF/F3wg?=
 =?us-ascii?Q?X0XCDiLgLnHYeh3YuLSVXj4Kbp2rAdwpA6oaO4mw8mNN7NlTxWPCw+fgDlK/?=
 =?us-ascii?Q?IQhGerMjOIFkWFvrRftE2GOiti9W0abTuKrC8t/dO4p3SGVe9m9L+6a5wFvU?=
 =?us-ascii?Q?/yiysvDOhQBxfca8DsjSPdblJCLgrnaGafe8iH/Ld8QIpjIiO3+eevlYUKQn?=
 =?us-ascii?Q?WOLLSEwX4WDxbQXCKTKxDGD/Hxxt7eIINBZyrSJ46/I=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb57501-4c96-47c7-242e-08d8959ccf51
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 01:59:59.7305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rm/ThUtmm+yZ9xO+jzHKHQKiJ1uWgSHgl+zdDV7uryxI3etOUCiy2cERx9hP4sYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, December 1, 2020 7:08 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: return an error of copying to smc fails

Rather than just silently dropping it.  Also fixes a set but unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
index 4bfadb49521b..04b561f5d932 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
@@ -2545,7 +2545,7 @@ static int tonga_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 (uint32_t)sizeof(fan_table),
 SMC_RAM_END);

-return 0;
+return res;
 }


--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cfad16e545f7f4a972c0408d89584d5b3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637423745042671997%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=w%2F%2BbLqxPwkWsxW%2BfY12102WZzKZtKsYWFwMC3GbLDNM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
