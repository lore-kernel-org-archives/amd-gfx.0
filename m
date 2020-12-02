Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58E9C64E7A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDD221D7E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDD221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925E56E99B;
	Wed,  2 Dec 2020 02:09:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A106E99B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 02:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcfuyV7+F3QuztUz3v1jlu8EuJhDckttTaLAWs3c20koXBnu09VzhuX4s9Xymk590d4E4JQF6UxPYDVi8JbqmDMRRQdXJtiv/2ZKd/AnY6rWuSIq4GrGfyE4Xl/bQFPjwJvofity2yxMADg18S7+Gffgd2JwsCuLbjXrzzxu1+cXViV83wi0NELp+GvNfzcvsFCmJCXTwQwT3CkwFxE2jKp4iAcSI9s89zhsubgfOqvZ43to0EV1gDsowIR0Cu1BzzCiHY8SSYjijgNMOB8U2X4YafeU46NhkWSpDCwdenks3INhl1csCHjYCq7gCTp0as1euc/sD8f0Nwhm01Vgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9H8bRQGY0uXZX75Ie35EclwlaAdGSqGJmW5uWth6fA=;
 b=cctchr/cZy6qI6K1fpJchbSslWbhlse4uivQh1Yh3dufMSoXBYs1fChRygSl5H7yNyHJuooZnFFYCEYkSSzT3fxwOXWPlADFIM5j9OOLnpDQ2xl2VYQlwQzXbhKhThwYB4L1AS/IJUCxLWKq8ZL590iVLBYl9dpolI60VS+K0qI9BfqGMEUM79nqRm//9ySfv2Um7Wz130jcH/Paug7NBQg5vkUsb2UbTzAjDAe8dRm01oxfYssUYpncFjwzIk+gMW6U+xHKmQM320/RBy+VIToPueRXkzeJitH0npL2K5El2k+n/YIEMKiGrCJgvBYmEzWmnG18H2CmzMq8R9ysrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9H8bRQGY0uXZX75Ie35EclwlaAdGSqGJmW5uWth6fA=;
 b=p9txLdLtSoNizNX4/yX5FJiFQH8NNNC6a53YrNUTQ0ZfEA5VKDj1g28JXGQ/XONfrDSpKbiCnz63/tudEWFlFXqzQrpqJID9W2aiEmGZnruOFdyMZ0Z6LiFJlM4Znqfig6+s3K0OIjn4nbEE9Dqte7DtvXi+dTA10B30NcCcOpA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3275.namprd12.prod.outlook.com (2603:10b6:5:185::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Wed, 2 Dec 2020 02:09:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Wed, 2 Dec 2020
 02:09:18 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/5] drm/amdgpu/powerplay/psm: return an error in power
 state init
Thread-Topic: [PATCH 2/5] drm/amdgpu/powerplay/psm: return an error in power
 state init
Thread-Index: AQHWyAmeriSwcDfoiEGzzs/Ca4NmgqnjECyw
Date: Wed, 2 Dec 2020 02:09:18 +0000
Message-ID: <DM6PR12MB2619479FDBA574CFD563FB4EE4F30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201201174413.643254-1-alexander.deucher@amd.com>
 <20201201174413.643254-2-alexander.deucher@amd.com>
In-Reply-To: <20201201174413.643254-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cd7bfb2c-75a7-46c7-9201-e4b92f3a1f3a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-02T02:09:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81706b71-c185-4a87-437a-08d8966746da
x-ms-traffictypediagnostic: DM6PR12MB3275:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3275FC13938D629D4B7573DDE4F30@DM6PR12MB3275.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvM+5BPTM9KUjeGa4hIeuiH0212ZeuVHR4GUFq6dmR+lditIcjlzzi30uFRbDIdGJAKDGuI0Woh3uu5FQIKFVeuT7iv7KNaLi9OH4GkN3PLhnSNt1eF3fsrzJKdp9BQ1dWY9Bbnqp2u33ytW+ayn1tddlxZa+eZIcHPTOt1+AUjwGjHWd/iqk5IueQNMKKCT8pWT4HXkUkvwWFt4cTZo/IM5MYrbSDqbYmW535Yzsl9/C+3crzciFrQ+6YISxfvCnUseRFkZOj0bY1YdpXoxNmjkJL860RVq6DC60LgztYnBfELULbykYbYNDF4VoP/RGe83WSsaLzKlVWo7R8hRQWhcHqtz3f1Hf6WQCQYMU+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39850400004)(396003)(66556008)(66946007)(5660300002)(66476007)(9686003)(966005)(8676002)(8936002)(2906002)(4326008)(83380400001)(6506007)(53546011)(186003)(55016002)(110136005)(64756008)(26005)(76116006)(45080400002)(316002)(478600001)(33656002)(7696005)(52536014)(86362001)(71200400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sdppWy0P+3apg/LT0pnNhOTLmzqCNSpK/HPZ6GlYPkWKSt2Kqne9zyN+tabU?=
 =?us-ascii?Q?QjnJBKwjt9+md0DRR1SD9WLSocEorxBvN4iJDqlWd0A4n6PtKfxLWS8Wn63j?=
 =?us-ascii?Q?sqG7Hoy2ZqINEjZQH8uI5Y+1uoRy27Gr1gccNNwIWOEkJqTz4MLM3osuQXJb?=
 =?us-ascii?Q?rTI1DLlzEAMxvtYg7FGVUJjip+XkCOdKYL5QGhM3udGB9bEGRG2qCp+kuqPu?=
 =?us-ascii?Q?7VtzqfN0lkigd2Yzxlzw+I+3BTpjGBcHFP1qWG/2EvfgdiQ44QanAer2OYYg?=
 =?us-ascii?Q?zXLbaFWjz7yiNd/4jeNRQpKww8aMWd/qPg+rlAa6pKWf5WLMUb198zz6KdbV?=
 =?us-ascii?Q?ujFSqS80nsTX18g8dkqJX/VVpaniptu4DMv8w4N/LH0CNB1Poyj7U0JIv8bZ?=
 =?us-ascii?Q?3rXyDqDpRgr53EZHKJXqg1feitil2B6gdXQcI3v92NJIjv4056bZxk0uuLSZ?=
 =?us-ascii?Q?5OGqt7tRO4lSgUGymi96F4JZiVwzqEN9GxeVT0RswJsiiBzseOfU//1SCWSB?=
 =?us-ascii?Q?T04gVug4AEytRFDiyKMTmLjwqXgqFKfVYw09dwxiG9rHRbFMwjq3dzfE/u5G?=
 =?us-ascii?Q?EvWH9tl2DZIZOeilpC+4ogmpCENEEGizsWZ0iqyJ5FLg+pqX9i0YnZ9lBa7Z?=
 =?us-ascii?Q?XarTvntI7xriI5ASwX3eDH5FvH0p9iqAiCxQxC1dx30VYedtf6M2A5smc/6C?=
 =?us-ascii?Q?vfGh7jIi3FgeHELw09On8KR4yuPC9aPVXJLPy5VAGRSmSKfGNPsZPat+JPdI?=
 =?us-ascii?Q?SZTw7SQCMp4JwF0wBpRclF6UQ+czrIWu/DmRrm7inP+ftECLrhFsP3GBDW+5?=
 =?us-ascii?Q?gHL4vH4JwN86mbKChXQxm0vkKETmOG8lQit8Hkh/VUNyqEJTlBP4F8gkm5CH?=
 =?us-ascii?Q?lgRvWkRJPtRsYJuKmwWuD6uFreLzlHUMUcl16urqWez3rSxHAXccLbZlVV3+?=
 =?us-ascii?Q?aJ1ZiC9JiKYoeir7KeYvBctYiJsvL6f0l4nUoahp1Q8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81706b71-c185-4a87-437a-08d8966746da
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 02:09:18.5925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQdKRfzfXPV9Dspy19IV6QB/z0JJAWRzuCZ8WG3STrOPZF/FraUW3zNPbBnYbCRV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3275
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
Sent: Wednesday, December 2, 2020 1:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/powerplay/psm: return an error in power state init

Rather than just silently dropping it.  Also fixes a set but unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index 31a32a79cfc2..67d7da0b6fed 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -74,6 +74,13 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)

 for (i = 0; i < table_entries; i++) {
 result = hwmgr->hwmgr_func->get_pp_table_entry(hwmgr, i, state);
+if (result) {
+kfree(hwmgr->request_ps);
+kfree(hwmgr->ps);
+hwmgr->request_ps = NULL;
+hwmgr->ps = NULL;
+return -EINVAL;
+}

 if (state->classification.flags & PP_StateClassificationFlag_Boot) {
 hwmgr->boot_ps = state;
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C6b3c9c6f67554f33eeef08d89620bf47%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424414687587645%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=0P4V5TAf4ipNfI1NpMlKBNn%2BG9UQxE258Phfzso5XzY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
