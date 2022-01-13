Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E87C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 06:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58E610ED38;
	Thu, 13 Jan 2022 06:12:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9A110ED41
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 06:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMWaOmDdjzCBWjs9AQ3GFDqZ5Ji/u5LM5Xkf/PjBfiM+UufxHDnsl7UKcCHUkS5h7ptA3h4WFh5gVTTRZwouEo4S0FufrqPbyLOiGPs79AsOvWq2YG9Q/4MchmYmiOg5jrlGoO3PcVRpfJGTCe0Q058DFR4NFYl9aAm/CfJ6tBx+R45862Bm9uLqKKVOQwqucTYdVH9FazB6zXjgtQzQjXrP9b0UICL7+73T4+I1/D41R/upFaygj/wyW4jFd8LwPqOpwwlzf/m7DbWc3LJTIxwbP3Ayvf6fr512C1G7DWRWH3neKyqTxZZ145ku86AvevyhxYJ3p6wRb9QS+BvC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ+JtrMCpio1wVR8ZPBXUyyvkPpzMr4OPJOEcj0aa3Y=;
 b=FKZ3eFnSoe+Ch4bDWBzkcsQluJ7dqXw9u3aPqemJzJKhMh2LE34v7DGu4Fe65T/u8aY5zn5qrfAA4naW1ULtNTokGm5iTLfdInVBrRSdC7+gKh3RgVPS707Y2QKm85GLrw31tWy5ZD+f+CABSN1zCwt/taECN/ubQrD7t8cmCXxAjlEpZBGC7yffPS5eHVzrbthXavOgl/N2F7NCYFJ6ITcpGSK3al0c4nb4cUaofKwZKV+3Yd/O833mYG1lSOIkVkXexGntX4B0izOZYIJ6yMT1eatbTiB2h+vT1AS8yBDsYPQap/0M+Pn8p77+M6lb3ULKhLVwrrPRWZtf/DzzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ+JtrMCpio1wVR8ZPBXUyyvkPpzMr4OPJOEcj0aa3Y=;
 b=i3gFJ1WPYVJCl9ynYpmTLXb+xAoPvGTBk+bRLNFvJK/Tot4nRQO7oRLWfkW3DPkqhM8J1XXIFssqVxZvCqhwXnM+OXt6kX0lQFZEiLXE99cFsQ6GnzDzI0DC4DkmuvXszrb4ifJwRYDxm3HqoIkF+RzdQ1TgjPfBmE66EgIUZOQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Thu, 13 Jan 2022 06:12:01 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 06:12:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: don't do resets on APUs which don't support it
Thread-Topic: [PATCH] drm/amdgpu: don't do resets on APUs which don't support
 it
Thread-Index: AQHYCDI9zKbfnf7m1kCKNRMRB2bogKxgaZJw
Date: Thu, 13 Jan 2022 06:12:00 +0000
Message-ID: <DM5PR12MB24691BC1D64D5277B4FEC02FF1539@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220113040103.311160-1-alexander.deucher@amd.com>
In-Reply-To: <20220113040103.311160-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f88fa60-95b1-4036-8fd1-08d9d65b9caf
x-ms-traffictypediagnostic: BYAPR12MB2840:EE_
x-microsoft-antispam-prvs: <BYAPR12MB28404B0F165D2BC40E36B1B1F1539@BYAPR12MB2840.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6cP9ds5o3y9Il6xfTYv+JkdETjy1OHtmiQp2jiEHrp1TAkLjJoF/EHTrPjBPYiBONWVbttCXsmCNpya4Ceh8b7iYUJ1oe9MTz9Bj1nRkTPSpb2q2BuJAwRLl2Jce1nC6/VqBWInUfOlZ2y28vZUCyrbjxuSN1PQE1OZRzmpnxy12bG9l4MoZy2IjWHxU4G2/SIixAO2oICUujwg4/bRxUvgG3kDB1qHt9+FUK3QzVIj9Y8rJe2cahZGsVzmXRwDRKEX7lpH2L/FxyD5w5/nMh6DytghEArhHRVeJIhaEA76ejHOwiCesBdg6o2O/QDJE0uRrZq/bmxZxsws0ml157osMVcPikpKcGF77V9mtlb24KzIAs1Gw15AnFUfyLZUKBKy9NihFNPMLGKKlaD3+Ii0iaduCiD8YjeqX47VEIqEsbOg2yc0SaMw279E+K3iTam7/uEYEhNMHgjZIMJimXZYbUZ8YCUBei6xOgJ++gZmoCS56IWDp53U0nlpqbQO0nAa/rOSDaIjSFZJBKGBRuEzT2ncJhT5ZZi24Qsa6gwyj491w+2RZy7a0IXrj2N+MoG1hUXsmIr7/ltlhD+ioD80z9x15EIdruiPrzaxg+EjHsc6hiYAplheGD1fxL6ZES1pZ+Pd6N0EwgfA5Oko7QLRA2LktDcHeNU9H/s1aLmo33hGD2wHa2EgDG2rHTFbLdhy6ItwWjWrIrvTkqJzyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(122000001)(86362001)(8676002)(186003)(5660300002)(8936002)(508600001)(38100700002)(66476007)(966005)(53546011)(110136005)(64756008)(66556008)(2906002)(54906003)(45080400002)(7696005)(4326008)(6506007)(26005)(33656002)(52536014)(9686003)(71200400001)(66946007)(55016003)(83380400001)(316002)(76116006)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YBdYpCRUrmffUyn+NlbHNf/oSg52DTVU0AEpyD1rxx5tmchwhAsp/mRk4tVL?=
 =?us-ascii?Q?vv0cALHQuNuM2/bUWC2riGOStO7B8Ubpq0X0zbA/RkJDFnlcuEiXIwFbq0/b?=
 =?us-ascii?Q?B1cGsymliwLL8fSiWNtfYQdktlVQMuAfK3hEAKh9QwTfK1FLhSYeFDhdQSor?=
 =?us-ascii?Q?h5+vyleMRjx+BxEGVyMwajYeJ4emyyVrPxi1U5zmhb8fViksVipqWTB4Nwsv?=
 =?us-ascii?Q?Gm2xpmTrbod/LpmonmRA44GwoWxT9GOw1pdeUDVF3+RYa7Zf7XNl/Adbqequ?=
 =?us-ascii?Q?0UrL6MuXoSaH2SepYeWgFItFK/N2wta+fJiJSXAbDUtWFrqMv1KAmWUEZ0cR?=
 =?us-ascii?Q?xJUFtVTj8QuDEUgjd/dCh/NvPlR6dPZMO2YMwfIKbpyWJ6X+NRw0oCZ3j3gh?=
 =?us-ascii?Q?3Qs8X/Z7Iq4mZ8EqU9HXU5NcbsqY4wrH9knluclLS3MKFs6jTwG9G4jJeskm?=
 =?us-ascii?Q?eDALRhPzyaJp7W8J/FlYiVmiDi8nNEQSSbPIQfTyM7YFt8Z2aGOQAvzF/JBd?=
 =?us-ascii?Q?0BeZs8Aaeil50SilL20LcScCA6KpdwTWeAHEXn+MXtW2Nvwbfk35ApFPDuFz?=
 =?us-ascii?Q?OxHW/ADZef2YsUQe5oiMYesjwM9720tMAKILd/XBnDh+YWrGUAKaYqJmmxLO?=
 =?us-ascii?Q?0gaHPguCl8OguMwochPeK6MqPqeQ3Rx/KS5UvxRQsC3VA9N3wqU1xOKu87HP?=
 =?us-ascii?Q?60LUEYXA34nL+O0EX8WuSUpKgzKSr/yoYU1fiy3IWVSOaYZP619kTR6jjQXA?=
 =?us-ascii?Q?C9EWFBKO1sdkmlo3+CKHCh7VkV5smXBQXlTGI3aP7Mixor08xksaDW4B/3GP?=
 =?us-ascii?Q?bstJ64rQysa7elgQkLWTDbF18Xu4KtAayR63LXTBWjBHE3ER6x40wu1ZPh/p?=
 =?us-ascii?Q?Mk9f26+TKbDDD0+7mKempCnIglgueyfuVOWS94+hBP6u5wKMDFMebVrKMRqp?=
 =?us-ascii?Q?X/ih/favBaK2rPR+YVwGhAfrsT+GhsxAIQfi6qkuHgHONjz3JxHBv9sHdQEh?=
 =?us-ascii?Q?oGIl2914+TaszfsHsjOd9H0LFUckzG9UDoB2L9krlEvGhfSvmpE4zohm2wly?=
 =?us-ascii?Q?ijGuC1g+CKLjeZWjIPweyf1G29zh+BKxhwXIdXz7uWdWuYJVPZZPZ3Tls+B/?=
 =?us-ascii?Q?U9NUbuXHrXlRpil8fvR9sOoyROXJ/43x258DRTS1AIRpJaKisPPgq3yhMFWB?=
 =?us-ascii?Q?s+PEq5hb9VJ64osffLD/G1L8ZZvnOA3dS/f0b3XngNP1zq9PuZn7pT5gYOzs?=
 =?us-ascii?Q?9e9YcOXEOrbAiPIBA+8MXU6B1+o8Eyd5Faq7bQCvXUK6zeGDU57kKIvlz2WX?=
 =?us-ascii?Q?j0u/MLPdX+3cDbVIRTvARaNBrgLWGQ7ayfsdjryrn3zhA1FrQZhk6qqs9Aih?=
 =?us-ascii?Q?2BleUSdgia7ywUWKopIr/jgbRSikswsrl0CbqEx8MIxXgmQp9dzU62AtMjCC?=
 =?us-ascii?Q?C5TbE0HA0nWMtfXpUXkvBpwEZc6B7EDyXCXfxZNCXB5GOZ1LSPc+cXx1fk9+?=
 =?us-ascii?Q?DZQu6KWRQKMhL8sQyHFqLFMgW+sfSQZYcEqriisUfC6HGhBQ+9AezF8RRisO?=
 =?us-ascii?Q?HTP67nhj0l0oVacIc9ozdkxxDk0kNV3adh/9yjHhU/8Zt6UYlnptaL8NZDF6?=
 =?us-ascii?Q?3Q1RHI4P4MXbupw0/9xK6Aw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f88fa60-95b1-4036-8fd1-08d9d65b9caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 06:12:00.7036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+RK+ZxFPVanuv3CWk9cH9dMrVwmpvd/krO7tbZyRYWbO72V4Ib5t8toJj8gphh9wbZLf/uPstO1aiVdKJBMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, January 13, 2022 12:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: don't do resets on APUs which don't support it

It can cause a hang.  This is normally not enabled for GPU hangs on these a=
sics, but was recently enabled for handling aborted suspends.  This causes =
hangs on some platforms on suspend.

Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
Cc: stable@vger.kernel.org
Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1858&amp;data=3D04%7C01%7Cg=
uchun.chen%40amd.com%7C2462de07d629440dbe5d08d9d6495d8a%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637776432879987023%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sda=
ta=3DWrqnZKTZCDx729gO5TXEr6IOhBFa%2FkGqMa5VDjbSx%2Bk%3D&amp;reserved=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 4 ++++  drivers/gpu/drm/amd/amdgpu/vi.c=
  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/=
cik.c
index 54f28c075f21..f10ce740a29c 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1428,6 +1428,10 @@ static int cik_asic_reset(struct amdgpu_device *adev=
)  {
 	int r;
=20
+	/* APUs don't have full asic reset */
+	if (adev->flags & AMD_IS_APU)
+		return 0;
+
 	if (cik_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_BACO) {
 		dev_info(adev->dev, "BACO reset\n");
 		r =3D amdgpu_dpm_baco_reset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c index fe9a7cc8d9eb..6645ebbd2696 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -956,6 +956,10 @@ static int vi_asic_reset(struct amdgpu_device *adev)  =
{
 	int r;
=20
+	/* APUs don't have full asic reset */
+	if (adev->flags & AMD_IS_APU)
+		return 0;
+
 	if (vi_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_BACO) {
 		dev_info(adev->dev, "BACO reset\n");
 		r =3D amdgpu_dpm_baco_reset(adev);
--
2.34.1

