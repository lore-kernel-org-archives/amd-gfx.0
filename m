Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31FFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 18:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C40589E5A;
	Thu, 17 Mar 2022 18:19:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845A589DFF
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 18:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCTxlSGcweA/sqd9Jk9vuSUIu3Qfhd71ia2LyOI0Fn8EPr/rZrgxVUXS62CECzArU5BTHLT/sR3x8ZpnbeQ/CRJCfNYvFohSvPJ118yQPvVYsAkbJ/CIYAF1tNTM5N0NM6Apj9flGNEOrXY3HyyYXzzsznytk2Lzb4qpGfM5c+ciwEjWRvBnQ4mNpf9SWzv7ZXF3CTycl/M+DxaxHiRgY0L3UyrF4iIbvkhNtGhrJLC4J5/ggAGxDkppDmySQbiGbramOOwhWegrxJmZBI/1DhHILVwBPA9zX7PjGLi7dzsQUzNV51vWVHD8t6A9tXhpF+4LDh9FvnOSQFrIwEdd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfB+i8U5tkMkax9+45sBw0GjHO07qU3QC6n2cZPy8vg=;
 b=GINtnWcE12GMRiiIcO5OO+dXf0CiedAiNNnzqlVfebKzYx7xPosV78sk+/9Ay1rGhimKc7yL5LEaGvCqmm5KeqeJEQFxFM0zL//WMBX+vYlb5+jjOTdP0PwWEYyKU9tkNjGpMQaAHR/Qhv58f0m71N20gaqQvfaDVJmBtj+8HKBgpBKvHneRzq/0w6So3ZSKymrOGBmzNlLIBDxdn/XbejuItQbxFyjfJgi+FKwXSe8hcIxb6gMPgW3dv6OmLs1uo0vcp1Z10/03QzFjzHqp4dnqIvIEX4Ytavt0kZ9rkGXVTj/lg5TI/IAoimeGg9tnm4IETrieU5dDMON0O5aOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfB+i8U5tkMkax9+45sBw0GjHO07qU3QC6n2cZPy8vg=;
 b=xTZGQxA/TAy8V1av8+Bk/QTF3SgrhDB6lh7OBqPqViu7N1MYYizlpB4S+eXlecZRe16HTyMbj3GckcZ5+ie8lgIJlNFN0V3KNrs2VMD+E+R4DvyyJnL8yP2I3EKCAgINmeCjFXQ2I7+LJ1IkB/kZkHcKq3EzmzIYrUT53IMDEDo=
Received: from DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) by
 BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Thu, 17 Mar 2022 18:19:17 +0000
Received: from DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::39af:792f:29e6:f69f]) by DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::39af:792f:29e6:f69f%5]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 18:19:17 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Sakhnovitch, Elena (Elen)" <Elena.Sakhnovitch@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: Disable fan control if not supported
Thread-Topic: [PATCH v2] drm/amd/pm: Disable fan control if not supported
Thread-Index: AQHYOh5jsaIMwsFjwE6opn3xBTdlWqzD4IUQ
Date: Thu, 17 Mar 2022 18:19:17 +0000
Message-ID: <DM5PR12MB13232DCD032BF03189A3C64A8C129@DM5PR12MB1323.namprd12.prod.outlook.com>
References: <20220317164458.1365967-1-elena.sakhnovitch@amd.com>
In-Reply-To: <20220317164458.1365967-1-elena.sakhnovitch@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-17T18:19:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=580e3971-4640-4011-86e6-91ed6ff85033;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12de77ce-8c4f-4fe8-726b-08da0842a5f2
x-ms-traffictypediagnostic: BL0PR12MB4996:EE_
x-microsoft-antispam-prvs: <BL0PR12MB49968346B7A534BE21A704568C129@BL0PR12MB4996.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p1qPx6WP/lDNYh3Nm1igvNSQaZjYLftcFw7Gmpl1QWtqh8NVoWmWOzZQohJArHUnlOzob6pBGBPp7anYT2FH1olXkmWu0+1jhCvHZ1+FKsKsyveeBLcZ2DpKlAeEFHSW8UwSlKP/3W/mSMmcl/loVrUmm8Hx9UopzHSEDp2kX6FJ4SiyZ6vtn2TFC11B3ckP9MB84nBtiC5HS6MUMy/m1bb3YGW/b7KnLgP3JVaeDQvzd0ORhr5MGv4XXAqu3N/2kljIdtBHa37gyTGaZ59mJ26+6Q1GAXN1gK0yoO5/DRZG0J3QKyLJK8+XkclvNfIWVm5lb6GSrFwcunHqoISJ040U4Q7riJLjIN/M/H7VgiyjCIQOfL6FFLFwmfv/fM1WbNaHtBw1rAYReEKQYDAUogZ1/y1mscu8Ll2cxzJJDAVVbJIYAZ27FVMMaatFup37Kq2OUvBh8mT40O7DfiwqLVl9vleiZkUu4n5VTE5qPijWQulNZVC7T46H2cl05ByNjY7F2oWlux0aiIflZ3GVlySUyGuhMWAZwUa2rj4VSAa6fOjaNhdq6r9mrHY8lCBsMC6Iabw2Ik1QtllkFR9s3gyLsQ3RWaZ0pstXHc2Wtl2P/KyD2AWWN6Hw+aBNp6Up92ldncoj4Weh02Vn+6HEAYDzvEE24G75/pbaBRgjFHJIZx6D8GlyiJYe2X3OBB4H1C7Eyq0S+ZM5/LtQOe84/Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(64756008)(55016003)(7696005)(6506007)(110136005)(66946007)(76116006)(508600001)(4326008)(66556008)(8676002)(53546011)(66446008)(71200400001)(316002)(5660300002)(52536014)(8936002)(9686003)(33656002)(83380400001)(38070700005)(86362001)(38100700002)(2906002)(186003)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kxZ9MqFWK8Fix6gpr6AlcwICD3nWB0pxYPwrgF/9o+JXtUPcKmLSjktnAuEj?=
 =?us-ascii?Q?oVNkQHTkvFE/nwmA3M+TBWUm4trXVa7CAKssqr8VfyPdgoZqEeLNZXugP8Ym?=
 =?us-ascii?Q?0QrMntBt7Eu3B1VDRpsAd/sWxxMDOVmpj1M7O0M6bV5KOiaLgDSRGzFrRoKP?=
 =?us-ascii?Q?uMkrmGECHWUiAKKWP1ibPX5jxU7fjrnXatZGdqWbEQR8YBcSBXYmBLoHpOtw?=
 =?us-ascii?Q?bdHSHD6zHrbKNJXgpp+TLBEhGQRTVt/PgstK+8ul4sZ1X7GcfpKbAwB1BOqU?=
 =?us-ascii?Q?6i240IvsZl5q1OUzk9xwm03YDDQn1RVZPlhkiiyRLWuGlCttoaP4qAadogLX?=
 =?us-ascii?Q?Lqe+nfGdDpoAOaT72vbWX9fLelCN+Vt+62+gFhDXbjRZGTf0ZyhYlCESRGqI?=
 =?us-ascii?Q?pAQpQ/M0+iD+Z5i4wLxtoNwpo5ic5YSO3aMwMMcPS4JUktsbQ1hyOLdOET2T?=
 =?us-ascii?Q?R/A2nHjh0sDkweeTUTdZBCqj4h9ZpaiEgFHV8H/QU1iEuuCp+16fSbkJnWzS?=
 =?us-ascii?Q?gO1yX10vaRODJpPykNpIVSI2kobMWpoxG87BfYMB5ymnGY7o90YfiFdX0Eg9?=
 =?us-ascii?Q?FCxGLUgCrlENkVN06PzJFNmo8gkRaYr7DRzU73zOlut/+cwZeUCPqbemn/w+?=
 =?us-ascii?Q?zOc/8ALCFUiH9XPMJZH1gFGSRsPxMEFmq+kV6Z08UcpnHZjPhMTzLjsos7iB?=
 =?us-ascii?Q?2b2g9k2W2kKvufY4KRra3dGIsTLfLJ3IC5zVOB2j8gGNSWkQG84R0opNqL0x?=
 =?us-ascii?Q?HxkMuVwHIAzKfBBmw93CQmrzbPvl+g+Sarfq6vQGNbm0a1iWpUupZZtl3itW?=
 =?us-ascii?Q?sKmp4GtzM2laC7mGP7ChnkC2Jb/JWIqupz0l457mS5nbou1zSNBCvTHpW/6U?=
 =?us-ascii?Q?78RV3e+ssu4J0LrxeNXFAv/4HeI5O3gUJR1LZ3xfdPzW4iim0soDVfZe6xaC?=
 =?us-ascii?Q?l4MIu/p7rfb5YJuf6CnF3/R3mUJGysRMK5syHVfTjmxmDqbRooqkfAcH3pGQ?=
 =?us-ascii?Q?3Pgyhy+9gi10eihEJ/876xfPXpQVB97WDfQqXLp0fBzUGTGsPfkorYr+vTmr?=
 =?us-ascii?Q?QCzQR9q/N0eUhTPV5VzumdKP32ooXm7Vs4vw/0NzUaHtt3nRE+5i8jO7StZ/?=
 =?us-ascii?Q?ky60TIyH+KD/lhbJ95fE9bZy3THYM1RlHMitYXiwlNXwv269CGYMNeyhDaU6?=
 =?us-ascii?Q?ijZ7CRVZdCN9F8gwRHcBdC/5ZyseY2HZFVpvrTGZJgtjU+meAO7qpfUb9i6/?=
 =?us-ascii?Q?eDppBAmXCstcYQO3J8TWIYkTnQBZVmoCiRmRd9zw3bvEvE9EcEUM0+b4R/Gg?=
 =?us-ascii?Q?vLThZlJw/XhIVj3aUQDwBl0MCC/5s+usofICdoeT5IVjsN0XJDZZbV3gbL3r?=
 =?us-ascii?Q?GmmPNIsAJo7WTfpUodyo/YNhJuv+D1k3E2bixdti8PODTpO5FplKic7vJvQE?=
 =?us-ascii?Q?Zep6Or9/kLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12de77ce-8c4f-4fe8-726b-08da0842a5f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 18:19:17.0714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTOs9I+LQIlz8G3GLfcHpII6Cik+mdHibFxXQH1kqos1k+2gH0aggmum1UQUvqbPpi6oiqcVoGsNfCVCRY/Seg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
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
Cc: "Sakhnovitch, Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Few comments inline.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Elena Sa=
khnovitch
Sent: Thursday, March 17, 2022 12:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: [PATCH v2] drm/amd/pm: Disable fan control if not supported

On Sienna Cichild, not all platforms use PMFW based fan control. On such
ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
knobs for fan control also as it is not possible to report or control
fan speed on such platforms through driver.
v2: FEATURE_FAN_CONTROL_MASK is replaced with FEATURE_FAN_CONTROL_BIT

Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 38f04836c82f..c4fd70376481 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -371,6 +371,18 @@ static void sienna_cichlid_check_bxco_support(struct s=
mu_context *smu)
 	}
 }
=20
+static void sienna_cichlid_check_fan_support(struct smu_context *smu)
+{
+	struct smu_table_context *table_context =3D &smu->smu_table;
+	PPTable_t *pptable =3D table_context->driver_pptable;
+	/* No sort of fan control possible if PPTable has it disabled */
+	smu->adev->pm.no_fan =3D
+		!(pptable->FeaturesToRun[0] & ( 1U << FEATURE_FAN_CONTROL_BIT));

[HK]: FEATURE_FAN_CONTROL_BIT (for sienna_cichlid) =3D=3D 32. This means yo=
u would have to use FeaturesToRun[1].=20
[HK]: ( 1U << FEATURE_FAN_CONTROL_BIT)); There is an extra space which chec=
kcommit will complain.

ERROR: space prohibited after that open parenthesis '('
#29: FILE: drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:380:
+               !(pptable->FeaturesToRun[0] & ( 1U << FEATURE_FAN_CONTROL_B=
IT));


+	if (smu->adev->pm.no_fan)
+		dev_info_once(smu->adev->dev,
+			      "PMFW based fan control disabled");
+}
+
 static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 {
 	struct smu_table_context *table_context =3D &smu->smu_table;
@@ -381,6 +393,7 @@ static int sienna_cichlid_check_powerplay_table(struct =
smu_context *smu)
 		smu->dc_controlled_by_gpio =3D true;
=20
 	sienna_cichlid_check_bxco_support(smu);
+	sienna_cichlid_check_fan_support(smu);
=20
 	table_context->thermal_controller_type =3D
 		powerplay_table->thermal_controller_type;
@@ -410,7 +423,7 @@ static int sienna_cichlid_append_powerplay_table(struct=
 smu_context *smu)
 	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
 	memcpy(table_member, smc_dpm_table->I2cControllers,
 			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
-=09
+

[HK]: unnecessary change

 	return 0;
 }
=20
--=20
2.25.1
