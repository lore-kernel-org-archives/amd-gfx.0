Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BFFCD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B99112815;
	Thu,  4 Jun 2026 14:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IZwEcqJ1";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A690E112810
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lz6vwL6Z98sm6FvixcroH5WKqpp7X0Daei1zXK6ozsHr1/psQgtOlh3USGk49K5gegGKPLlOMZ1+H4HvNuxj04NlaKJop1VshrLvnSPnWD35adlb3m3Tusm3Th4yNScfpgSF9A9aL/hYa679KWec2eSuF2TmlZJ0XWmiQcqJlkFcr0jynGiBZp+bEYfGIC/ciRmHvtqkdDdm6RZxD7QbEPRmo/ezO9XWPUPU2Wk+u/VLbiQqsx5ePZ2dC9nf0mPlBxcOk45oMXyV0/wHvDTLq7yH4sjPWR+aC1c0venLobqaQhQ5RzUBMiSR/N1TEcTT05lip0yWTw2bnAWTlObCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXMcIXiyzem7mZdtEqOWqm008N0XfzzZeulrWVkaU4U=;
 b=RNaaU1Bs+FGdXW6d4yljl7/DgGfKBQmk8q4lIp6nn00roj1b7d1lgI5YIa1zSEbBc49dpl36Oz10q8dsEeGVfDur39jxSs5vgVnGV3SrrWFz/R7wVVu5feYgh+5XrGK/GuWOsSrkyDZXZtFTCwsfbQhZgUlyICVFM8e7B+Y8bosRa+5qsmMpNF7nccxuI/OLkrEMIvRM04s/U/+tKzR7ymzkqfxuv2peUkw4yMojgbA96fgcyuSXEVJ52peGL5n0auwzRcoJMwledgxLE9ebbiH7ud6BmSURukFAUBZNFaUlGpxcqvjSsF+6nvxDxhTP6SIpZ4Jbd7TOxGsQjiVP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXMcIXiyzem7mZdtEqOWqm008N0XfzzZeulrWVkaU4U=;
 b=IZwEcqJ1qeTXmrwYbwbfq1eVNksVB76U/H5vw7OZA8K1oU9n6AoHxJc9VRAH1ENF0i9yi6g8lFPkJHUTxS8yl/04qZEgaeWoTsBiBQIXid9veHMXiFu7tFnLJ3UOtswnAbA6yyr0Olu4EWy0iDw49bZW0tLvwv4iczhfdnM9mdk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:45:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 14:45:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable ras_check_bad_page_status on VFs
Thread-Topic: [PATCH] drm/amdgpu: Disable ras_check_bad_page_status on VFs
Thread-Index: AQHc9Cyc2J6p0uCIW0+/Xfu02K5U47YueS9Q
Date: Thu, 4 Jun 2026 14:45:38 +0000
Message-ID: <BN9PR12MB52577CEA10B991986A03DC52FC102@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260604141450.372045-1-victor.skvortsov@amd.com>
In-Reply-To: <20260604141450.372045-1-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-04T14:45:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9217:EE_
x-ms-office365-filtering-correlation-id: 2f4e824a-bb7a-41cc-5c86-08dec247f17f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|38070700021|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info: 9b9pNdJyjIM1bHhHu0u4N/Sebp20F+sVH7QcjSpmR1GJ4nfCLWTBrF7pY/iqzjP4vWiibtng+YELbW/R+teEb/WfSRqC/VDjN54pBmnn/TstspcV7P9hqsitk4Mp3vV3NKbQnCmMaaICwxgvLay5yYeZ2YuucnDR264Um399JiaWYqeJdRTm4YY1CWhCZRH8QumkSZUf8mK3/PZfJojvQtNRBt1VvOoRRh5m18H+LaRAQ5MMPcbp5YWavwClOvt5N6Q+nuIeCrbOQ4R3BOqkKv/yunQlcUJmRXRluUtyllpc/i/+mO0dGY/1afEzSBP8QS93tP23vIxuDG0kjpHkYj0Pt7QBTvoOs0jlIi0MuVWr0zINrcO6Bl+GieRwsNNxZleJBzehzNWaJ7XnsACIRAKYTJZ9eB0ZKRD+YyHlOICfRVD69poRw51baxhTeRIIBY4eYl9yzrR6Ypk1A9dxZeJbiTaKB4IkiAYlfw/7HUaj6iFjeES1SWPPAbEkWEBI/S9azmgfvUuFcT9grQMCz/kcTOcRlhOdkEa5zD1GVZKWx9lHtjvlUDA/V+RLKZ9c6XUW1IurN7xyHZD6ivQPhA7eoqLTMiuNxjgHu4j6Dd0L4IKoo+ZNFJL4K2sq4EKTELPn47Mb4zvtJM106+w4qdjs8CadeCWY4amUV8AD81w8PNrSDxrwKd1Dc9rDxGKHR1Wqa6k4t/DzSXaQmYTVWU7gDHK5tqE3HgmeRWEby3irtuuEqihnwdsyUEO3zwOK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?86hG04oG5+C2MXQpHlAxZ3Mdh2sn1jyfo4o5lBSG9Ik01ujm9GyyhVCcA2Fz?=
 =?us-ascii?Q?bWnqJIXCeoRWBBVJm3r3wLRCh35H1nkJeoYzA5g8rH98fbhrxxKSfgtq0tmJ?=
 =?us-ascii?Q?jopuwJKx3pgLhEZAWxrLD3gnH+N+jFNx8KRV0MEHJ24GFaawwNYA3bqShF/T?=
 =?us-ascii?Q?eHuXeaCb1FDmiX28fiDQ1RvsVXp0+kIkhAEfdLcX0syVQTC+fCOdhHDtnQzb?=
 =?us-ascii?Q?oDJDhcUNYMti6uXKCflMfETnBqNglaiixbfgp+WE9DK4VYvYD6HP0dlF3jGc?=
 =?us-ascii?Q?erODImzp0V4IZEkKPP+/h2XEuIkx1aKaRJzW2TB6wSj5YfWn6BbOxYdnvOzo?=
 =?us-ascii?Q?k3cf9uI33QkE+VjwS9Qz424FydaSjxe0kde+QjbnGsHgdd2ut+wGyZUaL2yQ?=
 =?us-ascii?Q?GJRJND1NdVYURbP2Uk3w4TXivhIAToHFX1ko3i6nWUfEWQ3QMT7QgIFjcjZe?=
 =?us-ascii?Q?9IZeVyl/hdubHrvO9srs2nIPQ3vgdpNDWL9X7F8TzMyHih4mdZevbVGpgNPR?=
 =?us-ascii?Q?HzdbEywOc+x0K96mmbzfhNiEljmfZCotBf6XZ++mKIJaWZzIhA85IL/DpE52?=
 =?us-ascii?Q?PXAunxHkV8HRL03PAELrus9AIh4mWMx0PH6eU8u2L7EXh7YjVpdA3mi7NWgX?=
 =?us-ascii?Q?I9kDD+c0NvNFE+pzl99I5SjLomhXfmS7y4ZeKUCVmzZSj52WImtFz3gqASrO?=
 =?us-ascii?Q?3SxZhujSrhiEL9GFDEl5Z9K1n/fVmnBVh8u4GxojPKIHPH39NheiIq77F8Pj?=
 =?us-ascii?Q?jXyloEN5fN3fx+LqeCzWaEGknGa0Z2yiGjCgqkIr7u0R0sT48tWuBsfRM9Cw?=
 =?us-ascii?Q?rAl4pKaK9BZDc9ynE6Ld248XkUYEmKDjkq1zyeWNpzjHU5n2QOorZwwYY8BG?=
 =?us-ascii?Q?RYLzG7/cuqbMGGY9qdOC1GFkRDUi/gybIX5D8FIIAR6QlbnNg80BNdfl7vMo?=
 =?us-ascii?Q?YomfDwdE+8C3O+vmqNgOazfXccMvc33ocm1sjosKFgAskke4yrPFXVf1sLpp?=
 =?us-ascii?Q?mHOapT9pfI+cLw0dWI5EbbcgAzqKbEI4eqYDxOBwMPgbyaW6YWOit14L85ll?=
 =?us-ascii?Q?e+lKEJD9fQ+o6LZAc5l+XAbXGjdLGqhf2JU9EQLuzLpZTbPZb5PUx5HwIdyb?=
 =?us-ascii?Q?Igvpv1bl7/TQr2JiqLm3uMKLR0Cllb0BZwEeyfK4zNIfEEIuzLIUeSofzvFU?=
 =?us-ascii?Q?xMO5vFE3lZXyvMAftYHAtIWrQp2AA7uyhJqbeILUn9To2huw2n8RP8Ao4Ri8?=
 =?us-ascii?Q?obK66fp6H/1ZdEVs6M6ei34JSiSwGQC1nQsGYj13dfWyoFsL1BM8TJCFUlTN?=
 =?us-ascii?Q?poiTmyRwyf5m3YnFJJEenZ8/R1zpp9AUPcDllegH7MNqoo+yv5Bi0uTnOoDx?=
 =?us-ascii?Q?jtChaz29r+tk2aL79IXnW+HeBJjd7+ert4tvYxgyoYSYDZdSMFdrvWZI/Fbh?=
 =?us-ascii?Q?5MF2KWUpor5nXkw76iJJk2BVr5lE7dzT98CwTbvqWUAgLoV9FdZruzjxEt2R?=
 =?us-ascii?Q?WC6+qxBI23kW05CPx43sn0x9xAeZhN87mFuNKioahXsTpC7XBlPRPUpmip93?=
 =?us-ascii?Q?bmdJnzFiVjlZpLo7FqiCHdYZa3qWM13JX9DfWqSnvt7wSd9OHaaUqYAhl92Z?=
 =?us-ascii?Q?SD5MRpNF3FWnaT0nOxLFvkhXCSjEDSGtSV690FVClXq8doB/q6/dGY106kTT?=
 =?us-ascii?Q?y+sHor5CmcsYWL8yJBbivrC8P3UIvmO9M2aIhO37w265fwvH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4e824a-bb7a-41cc-5c86-08dec247f17f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 14:45:38.3160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXpoeXBJ7krFUREkKMGA1OwqaEahP1Rb9pw7oIIdoq71QMKz3i+0YXK1MvLYw0l+/Wdyld0K4DODjcTGgWLqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Thursday, June 4, 2026 10:15 PM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Chan, Hi=
ng Pong <Jeffrey.Chan@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Disable ras_check_bad_page_status on VFs

Host driver determines the bad_page_status, not VF.
VFs do not have access to the EEPROM, and eeprom_init is skipped. However, =
check_bad_page_status is called outside of the eeprom_init sequence without=
 any is_vf checks.

Add a return false in __is_ras_eeprom_supported for VFs, and use that guard=
 in amdgpu_ras_check_bad_page_status to prevent incorrect access to un-init=
ialized eeprom_control object.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index b265b4d9053f..fca2b49bc13b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -159,6 +159,9 @@

 static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)  {
+       if (amdgpu_sriov_vf(adev))
+               return false;
+
        switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(11, 0, 2): /* VEGA20 and ARCTURUS */
        case IP_VERSION(11, 0, 7): /* Sienna cichlid */ @@ -1973,7 +1976,7 =
@@ void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
        struct amdgpu_ras_eeprom_control *control =3D ras ? &ras->eeprom_co=
ntrol : NULL;

-       if (!control || amdgpu_bad_page_threshold =3D=3D 0)
+       if (!__is_ras_eeprom_supported(adev) || !control ||
+amdgpu_bad_page_threshold =3D=3D 0)
                return;

        if (control->ras_num_bad_pages > ras->bad_page_cnt_threshold) {
--
2.34.1

