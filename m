Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC12EB8FA5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 10:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD2C10E5F2;
	Wed,  6 Sep 2023 10:22:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730B910E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 10:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2r0XPdjOxZ2ewsQf6uC5GSfdaITh46a6TKVIV7pvxXrbiLtYJ9bhwe0ngluRqolCH+1rl7OZUgkuEIDmmW8Wr8kNpAZJdNRHSBSPZskfv5BnuNq/5A2WdO0vmafC5I+tgAg/djv2Uj4ZSU4s1/N1LDt8oShVOekl8zl1R70/OY8TCxASJqYtgw68uYLF8z/fBvPLDno67tjmwEDzF7CQKyiK3pKV2DzQyfInQRjMyfZZ9hnPsq+ABrRy/mtkKVV4uAhCptdODncwhTLPoVxZubhKd1zqTIedF8SQU+2aGlZVTyIgXzLUBOOkY72NSb4ecilBrVy1ainlMxbl5+54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/U/XEnbLWuRUDp77fNKiKXzytbI66CSG03YAWYXYpw=;
 b=JbkxcmKGRs5bXrSzgBuzbHoh9bumlwfDEGaBZvo6KzZaHkDYV0xGNyIDP0cVPJegADrvN/g3X0jJ0e2BECenF0wYHB6jf/BZYb+gjjMOXDmManeOs5M+Rxv3veni7ed0vyNStW8BlgQYqVuKdFmUaX+kHh1DMrNzXhhGSToXNBwaYaH8MbIgmyvd2lJGQMTtp5ajtUxw4hS77u5xgNYH8h9HW3nn8qGKWV+AM29ekkRr3Wiby3/sbYPJ748b7YmhA0q3lXjUsC87aL8Uk3WHhI2jjwnaUE/DjtE3drd+QvYlPKL1vvQy+5mm+tHGo5aXR5hdgA3SNFnK8qczdwRtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/U/XEnbLWuRUDp77fNKiKXzytbI66CSG03YAWYXYpw=;
 b=dE79H1iV+c2FI4n+VTPjtD1ztzg6SLHkO8Ug1ZKKy2OrmL3copHfewLkDECV1TZCL/sXb/sE8MWbYjjuP13yulfr9KgywWnPdx0dPYNCVzTDyG+WYaSZ3866MnIZUt9XQHqHYB+iez7FiIidYwiB5JKv3UVyPCP7vYKzbnemSNE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 10:22:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 10:22:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li, 
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: print more address info of UMC bad page
Thread-Topic: [PATCH 3/3] drm/amdgpu: print more address info of UMC bad page
Thread-Index: AQHZ4KpuRz8EM2Vi402/VjmYpNM/z7ANlpbg
Date: Wed, 6 Sep 2023 10:22:20 +0000
Message-ID: <BN9PR12MB5257968992D48D941417DD64FCEFA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230906101016.22726-1-tao.zhou1@amd.com>
 <20230906101016.22726-3-tao.zhou1@amd.com>
In-Reply-To: <20230906101016.22726-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b6df7286-6e52-4a98-90ae-8b1aa8538686;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-06T10:21:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4968:EE_
x-ms-office365-filtering-correlation-id: e39a4422-b229-49a3-3e61-08dbaec3276b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: glA4gZXGxgbv5MxX/8JbFrRC5xsM4kIyVuWeti1LGRuUuyyhnVZ3fEgF6NlD2Z00zdwo9i6e8M49Fays4AUDhnSyRfd1do0TwTrdZiRkZmsDpbeRlws6FZzfjzbL2ccArEmnqQ15L0G4LrpiV90nqHkC2q9/0y5ctA8vw2WKK3GeV/rbRMasZPkbnh0/5N2M6ILbYSXqqo6uhiBB78vJpPYEfcTJmPoE/08kqqA4AeuU+5twoAEdBljAZcFSlE0lkgyTgRFQzKm1U3ug2uuVaqv0nxY3cVb9mRafJMCFcSelkkV3TBw4x34O7lVunZrqx3IwOW1bt6HJBoyVPrp3dr2agr0y/B+qk7wEKWc/DVas5WIfIiJQtOJmQretugqL96r7Tt+S/nXRjMmUkaayiGwdxmsxwbW6N0uKFOPbi6fFI5JtOgY6QcjF1+dt+wdqippuT38rqzHHQhmifU2/uMMk2ZiNEnBXojLpOPrssRypwPYPoXxqWlZRIw81mVkC4ZQLq9M8GgENVtEbD8EqMw91+EGIT85nut5FaAdOYUToIQrDFhfUDZiLwBRJ3og9mSpSBtrsu10PrjjEQxUnTKnS8ShFk6x9a3VIBM2wsl/rCXMug8voFXRxblR+U/tx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(186009)(1800799009)(451199024)(55016003)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(6636002)(478600001)(316002)(110136005)(122000001)(38070700005)(38100700002)(2906002)(86362001)(8936002)(8676002)(41300700001)(5660300002)(52536014)(83380400001)(53546011)(9686003)(71200400001)(7696005)(6506007)(26005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tFWj4vFfShH5cBK0bs3tLSCHAWEtRKgDYTiK0lLoQShPhiRwIP/d20+LlODE?=
 =?us-ascii?Q?W6Ya7HEQs2j0b9gqIaHk5xhsBhyOTW1dajSCQ9r2+5+FkNXEc0y46ij6vBcW?=
 =?us-ascii?Q?WFvsoQO10fu8i94O4q0AXjRL8XuIsNsC2IvBhYxjo6GPUtkSkwll6mf95ut0?=
 =?us-ascii?Q?Gfj8DksRcJbS6WjLp2Z2BBjmt42fuWpbNmcMRVpgFVVySRgnu36rSZ+s2SQG?=
 =?us-ascii?Q?isSp/LiFmjNOeaafn2OHwNSZ6RFNSvSxzkSozt/PpwjNbylkb7abc89KodUf?=
 =?us-ascii?Q?mjU0mwZhX5gIG28zV8bnmsKq9Wtl2bMqcMzlB1AlrbFdlbUN5sj1+pqeeI6n?=
 =?us-ascii?Q?9GFpjnuDWCVJXS8uR1qWHzTY9ASuIY2NBUZDfONufluf8IW3y30kJQCk98bh?=
 =?us-ascii?Q?2NCBoJTfOBbNMKHWWCCVwO/xYv9BP0hYh/jht6jnIVv1mOOySAXIJpKHyleW?=
 =?us-ascii?Q?WBgex14kCLT43B9qh0IS4zXXzEeFdOeU/DJxROfNC8Mt+LCRKBgD0UTeZf6X?=
 =?us-ascii?Q?Zx+mrY0T+Z8OSnuI6rn13VY3N5iHrE4w8qpag45qHVpaKEWwgk2xZNqWBMPg?=
 =?us-ascii?Q?aYjjpDJdYe4+hL8g28I/5SePakggEkfpDR+FhuITzm6bYiIY93TK7zSdDZLz?=
 =?us-ascii?Q?sa7bKDHKFZVMqmWlq0AJJmVVYnTH3R3ruMdYIS37m9AB2lJKjs4YBfmPkRNT?=
 =?us-ascii?Q?gCycKPyZwtKdkoPVs2aqFMvayu9UsEk0EtX5lu+rWtdvdgs9tHmrb0AskZ++?=
 =?us-ascii?Q?BaBb0Z9hp/O6DhirVzBojpIHYsfC04aQhuXBD+KRg1MFfvlNK8otRZ+OZRZ+?=
 =?us-ascii?Q?YqiC6V+sXtiphkwVlbz5KzirX7ECo2+QW6PUlG6v1GW0HPIl+9kNSooEjSUE?=
 =?us-ascii?Q?65d8jauqkSujAJ8WviqsJrNyzimRVf1ARhEovNOqPndcj8+42Vngpji44h0u?=
 =?us-ascii?Q?mtCTTX3ToKrdxw1DairjsWVvB0n9zIAlbn8nIFjikQSEGvJvIJBtJRnL8TJv?=
 =?us-ascii?Q?6T4uCC5ZI7QRyor60E5s5LBvDLyHPdmsIapAtUYQj67+kfcTvc+SkLHiVc8t?=
 =?us-ascii?Q?GRooMQjjH3/4x20+Wk9OBZuJO8kUYfVL05HsQv47NukXoc/S7IT4rnEnp8hX?=
 =?us-ascii?Q?GUOiXpiPhuRF9uPN1ZIK/EOn9BsBcDKeqm3Hb+QqO1RVI4EtyMhIDQZ0ReX7?=
 =?us-ascii?Q?bXHyaRlYs86tKCy6nc8f27TNftKbKh1TCDqlgVZN2JfWtkaCKSVezvXYsAVb?=
 =?us-ascii?Q?kpiuAlZis38s4mZFeBO+aGpVFqwqBemJsXKIfpiq0qA+Z57PtfeyIo5dyL3V?=
 =?us-ascii?Q?VF8IAv4snDMdc5CN09lnaNMmKMC5fCFO2MaHc/QDIhXDsavglH1wC9rZzLY+?=
 =?us-ascii?Q?8SopHd7Tt3SUw0GWjQxZh1MOFFnlrJCRHpTHjHyCiz9eGSDOHNlg1chuIXYz?=
 =?us-ascii?Q?HIKjER4HHk8KTQCpgpyd+7XkFhHvxBprN+CPCukJNAbh8Q37nQqVF41niz9+?=
 =?us-ascii?Q?n8oj3I7O2KTrDFipZUuigf+0KUdIXNHxhmGpYuOI8iLI2eGe9/cFElCDgGdq?=
 =?us-ascii?Q?cVK6sWrPtcxEeEf6XgznuPUDylfqvddX+TxyctU+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39a4422-b229-49a3-3e61-08dbaec3276b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 10:22:20.5988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3ksmfkYTKJonTXrUtHwc3WxkiNPE5nwtC8gTdy5+PvKduyTmNaHIHuuEH9oL0x5dXui/XQXNuolc1cJGFJD7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, September 6, 2023 18:10
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: print more address info of UMC bad page

Print out row, column and bank value of UMC error address for UMC v12.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 5f056dd7691e..6fde85367272 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -173,7 +173,7 @@ static void umc_v12_0_convert_error_address(struct amdg=
pu_device *adev,  {
        uint32_t channel_index, i;
        uint64_t soc_pa, na, retired_page, column;
-       uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row;
+       uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row,
+row_xor;
        uint32_t bank0, bank1, bank2, bank3, bank;

        bank_hash0 =3D (err_addr >> UMC_V12_0_MCA_B0_BIT) & 0x1ULL; @@ -228=
,17 +228,23 @@ static void umc_v12_0_convert_error_address(struct amdgpu_de=
vice *adev,
        /* clear [C4] in soc physical address */
        soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);

+       row_xor =3D row ^ (0x1ULL << 13);
        /* loop for all possibilities of [C4 C3 C2] */
        for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
                retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
-               dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_=
page);
+               /* include column bit 0 and 1 */
+               col &=3D 0x3;
+               col |=3D (column << 2);
+               dev_info(adev->dev, "Error Address(PA):0x%llx Row:0x%x Col:=
0x%x Bank:0x%x\n",
+                       retired_page, row, col, bank);
                amdgpu_umc_fill_error_record(err_data, err_addr,
                        retired_page, channel_index, umc_inst);

                /* shift R13 bit */
                retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
-               dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_=
page);
+               dev_info(adev->dev, "Error Address(PA):0x%llx Row:0x%x Col:=
0x%x Bank:0x%x\n",
+                       retired_page, row_xor, col, bank);
                amdgpu_umc_fill_error_record(err_data, err_addr,
                        retired_page, channel_index, umc_inst);
        }
--
2.35.1

