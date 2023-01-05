Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0C0C53210
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 01:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162A710E48C;
	Thu,  5 Jan 2023 01:38:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179E410E48C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 01:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtV5wc2OyiI8GVRhp8DSW9/JglfpFhc5UHVKnNh6y6Fq1Y55VvMpsr3s3YChAdC3lAs19GY7KIZHYFk8a/rU6rjmB8mtvPhakuukDY6zcfR/zW/mCn3HHCW+IpSfcGK0y+9ufmoDeIVpJQnvUvhM8Wc2LoAtoZ2Kp8VyEHcsh5fXHaxG/sPzcm+m2acntrBlXFXCA1QUIy5LXibVhLM88KdD1iogZQ7iZqdrM0ibSowYaDotAQmKim2A4JL7EaFdY7XgWOGbvaRhoOyq2HPrsbS9xpOI9LHT8irP6Jc68/ezteRVxT/WwhNJx+/bqLcPmtjH/Ln+yCVdPSUxIruFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z92glvl42Xwf7NmG6bUvga/aBtCKiFxUq15ZbPm5rk=;
 b=HH8Xsx2HmUGT8EL8jNzbXMtoJv+UyQ5haBtbr+pi1jd0x5I3hTPYZw9ccWLkWjwr7LWe+ENxuQIuZsu3CudsZAtHuKZkxvRX2MfZgePWYZDOAQQvh0VfirLsSNYulaPf2zDFmDsb651xfXn74/rYZl2/CvKhp8GDe+zgB99avy8a7KAsmZ9+UWuM6uzjvfgigzQC3L0sIKPMjT/ntMPJ8d85ib3NiNAJi1MjpGdiot3k8/1lKDmP7fdqWgcy2E1F/4NJHmAhMYXbFbEp4K+Vy8oVUrB4vdXaxq+aT+RC+x85DQ8/1iWlDZvW7FDOwXiSQacl0noBjfyZmuZe1bSrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z92glvl42Xwf7NmG6bUvga/aBtCKiFxUq15ZbPm5rk=;
 b=UtuC/Y10JPLDQ0z9S+sgCjuJvQF2RHFR8MP0XvibAd9Qc58/psnLBAcw0E6JQ6ESZQIgX+nWCYNMk0USawsuvgaWBXG+uxVM63MpKCczPLm54VNNEOK7XCD95t3jtTFwbOzaE+32CevKWZHkiyKVPTltvCtTx+ao+PUi2Q4bdVE=
Received: from SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 01:38:33 +0000
Received: from SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::9f5d:df0:ee52:8ef1]) by SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::9f5d:df0:ee52:8ef1%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 01:38:33 +0000
From: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: update ta_secureDisplay_if.h to
 v27.00.00.08
Thread-Topic: [PATCH 1/2] drm/amdgpu: update ta_secureDisplay_if.h to
 v27.00.00.08
Thread-Index: AQHZIKGta7ZQwv+UCUWtLpG17JCc8q6PCxYg
Date: Thu, 5 Jan 2023 01:38:33 +0000
Message-ID: <SN1PR12MB24454EBB70DA8C881C5CFB1AF5FA9@SN1PR12MB2445.namprd12.prod.outlook.com>
References: <20230105010401.2216819-1-aaron.liu@amd.com>
In-Reply-To: <20230105010401.2216819-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T01:38:31Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=275e5be4-b73b-4c97-b274-b7788712ecbc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T01:38:31Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 275cfc15-97b6-46ed-bce0-17ed08c6c86c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2445:EE_|MW4PR12MB7213:EE_
x-ms-office365-filtering-correlation-id: 83e9be7d-d018-4081-3e18-08daeebd8ed0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bR+Jr4UB15d+FDrPIC800ItHG3rDvgVCbPbq/g5GTTPTe5GCTQ3uDSov0J7AN4ZxtlJjhXl/XlKYWqCC3rjEcQL+a9yEoajUiCjqZmzNttNbkCwMDxsvOCIK2STVla5PT38IdGLOFz3NDStbHVmgvL6GbQ7ld+q5tes/xo9SroYbThlJA0CwiQLvJfYP0pAtGc6cUmS5eUiCO2GggzXjyfNMl7DFFkIMNe+3g0Lm8olOUoawDGBg7slpTbXWiSNkilzyVzC1vwJreTg1JLXWsu6c1cmu2JVJ7pzxB99KSUULSo+Gdxr5JBti5o0cq4kuCJczNRMnHsUaJ91QRKaYjNhnDXScPXwTFlZpx9SLfqvaxweEJCTFpQbno6NSKtMj3rUidJriUzVcUYbK+Tqdq6dymdwPbIqfWDKNrMd+D7qFESeFl+iMjxm2c5q8+IK8Z5SJky1CyeihS0d8K3ejUBy3CJc+1Y6ii/A3J7KKPt1zx7E1k42NtkktZPvy8JdyhWpXLEQ9u/I2OvhvP32DFI2MclhWDiQtZoHJn6ND3XcUy2+LvS20mInwF3Dd9YueR6HurIClza1OfYxN97+vA4kJnuMSSKrjFNtEsNMCIYftRVy4XSzceWDV89ngbPpxjhS9VJ8etU0Qc1rokJ9n3ROaCJ3snaXCRqWMRwoWqqWtWJcDlNxu9Nw0Pp9rVt0USJEqlFxOyxSTONbLBBoiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(38100700002)(33656002)(86362001)(2906002)(5660300002)(15650500001)(41300700001)(52536014)(8936002)(83380400001)(122000001)(110136005)(54906003)(71200400001)(66556008)(66946007)(76116006)(38070700005)(7696005)(4326008)(6506007)(53546011)(66476007)(55016003)(66446008)(26005)(64756008)(478600001)(9686003)(186003)(316002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSR1COL/trcp3YXd5cwUde1XjbmO/FRaLXyhEC6cJPKGWBZXBWhPNVmNRAKI?=
 =?us-ascii?Q?LuG9PA6L8VQqVlGCSKslm41y0lE0QwLTsRK865fmQLy2xs6Eoe4bnhpKsWgU?=
 =?us-ascii?Q?PiOiylzWty39ZB0IujQ/H5ABGgNo3MydPQKQf1c6KCycDdR9alwbUqtMZhQS?=
 =?us-ascii?Q?v5SAYxKX2LYTYKyw1mvGYa5t2os4mW4KCOAQ+EjtkAUsFp1+7B5ADs5b+k1A?=
 =?us-ascii?Q?V/k/3de2USJTRdUIzEELm+bxnweWRRmfGeJWJfbcJY4vuP/UjMa6kempR/h7?=
 =?us-ascii?Q?qFczYp6rSG2k2jSY/gEOmvvMFwD7v3ec2yYEa0DJ7/fAkRBnarOm6gJTLjSU?=
 =?us-ascii?Q?6ojhK1td+Nqr7LKvDx4EYeASyVgL2gg1pkZAFXezE7aCbldZ/5dHXbKFcibK?=
 =?us-ascii?Q?sipehoo6anocptqGBEqK6qYV7kh+a/wT4h8RItorMZaKauiTXLgSOGcKzElJ?=
 =?us-ascii?Q?tRxL8Y+VaaVFd/5NJjHniWm3FpT7Z2snEmEy342lSFzKJzYyUergMe1ANOzE?=
 =?us-ascii?Q?KNS2LpX8t179DYEz/TrZnue10tHOYZC5vqe1EXN8ML2XPSIAO2rcO4CdYHL+?=
 =?us-ascii?Q?VBqZ8VymxyN+NJ/f82NxinEZgzlcokpIw7kU5dqZDf2cz63TlkyhaHUAbIVJ?=
 =?us-ascii?Q?SrmGNJL7zEkkN84DBL6ihaalqORkYcGopfjLeLeNEJ7OdkSe0BYsIO+oaNrR?=
 =?us-ascii?Q?n5k6F2waW6E930bNeLov8P1ZmHva3O+PZmrJpogAsZHHAwv7CLrSH8wxAvRK?=
 =?us-ascii?Q?4b/fXOLNB8OBANnRGHbZmkzvAv97124TX18Aht3YTyHtqKyP8HAEbGN9v1r6?=
 =?us-ascii?Q?B+RPP6zOY5JuYclaxqjz1NZmgbmivpWd6iEH984LrxIPTYDk1Kr+bA+6PnDc?=
 =?us-ascii?Q?idsIh3YRCfIz/PImkcEtPnQn5FuX+LHPPn73iSrUjfxkks0XJQc1CgQMG5ne?=
 =?us-ascii?Q?pZerc/5UKTer40IL+OyaaVuoAUNhL9ZVq6EYI5l5OlK2VzLcGuSCCkSEeZ/e?=
 =?us-ascii?Q?ytMw/RwU65EYePjrwo3EnEBGTpuxLkvz8H/0q62AMak/TZ2wJdvifOtr3bVJ?=
 =?us-ascii?Q?LMsMJ1VDFruAI/aRF+4U1hT77wFsCUmbbJ4nkpg0XAYxgm0ljkO2hz7crgE8?=
 =?us-ascii?Q?NHKhn4PjTO8MVHNWp1+42L0mWJ8s5JtSEM2Tnmq5iFPmZ0coujez3jeJ9aF3?=
 =?us-ascii?Q?/eJ0ZL/8bH6Z1SSFMQyb1m2kOHN3MAAAPdjIu8PXwBPCecIjfqcmsZa/mWYK?=
 =?us-ascii?Q?5wIHncX+3wOLmMygSHdo78iYcQqjQPNEvu75YtAVNzx80iGg+iPBnHSmwDEY?=
 =?us-ascii?Q?jFhAWJD5HQAtRRZHQFnyPRu1ISPonqE9bhuRKwktRN9ASUkvbWjKAAV4OLXm?=
 =?us-ascii?Q?eDHhV2iH9aSTQBhA47pUxRnW+Jk5SdpvniAX4IqhQcxpl3oxg5qT95W/RxEd?=
 =?us-ascii?Q?afBfmHaB3TQl8PCy/Wc898nO+RZcc6MIWJHbXsMqkhDjIbwmB8l/GnyEubC3?=
 =?us-ascii?Q?TJiUu+LT/CGYNqxNNtykJab/8nk1dfAZMVLq3whWuJocmgSUbuvA7c0AszlX?=
 =?us-ascii?Q?llSv1UNXpRBlILb3v9TwvPbeDNrKnOXSinqxC3Xy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e9be7d-d018-4081-3e18-08daeebd8ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 01:38:33.7963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuftgGd9Ddibe6bGemFdTNBn0I8S9DjRhjnOKii3ypw1qktArQFoPhmwu0IA+v33UBaXfvwdaQETwrN1FvPDNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xiao,
 Shane" <shane.xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Alan Liu <HaoPing.Liu@amd.com>

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com>=20
Sent: Thursday, January 5, 2023 9:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; Deucher, Alexander <Alexande=
r.Deucher@amd.com>; Xiao, Shane <shane.xiao@amd.com>; Liu, Aaron <Aaron.Liu=
@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update ta_secureDisplay_if.h to v27.00.00.=
08

1. Rename securedisplay_cmd to ta_securedisplay_cmd.
2. Rename ta_securedisplay_max_phy to ta_securedisplay_phy_ID.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 .../gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h b/drivers/gpu=
/drm/amd/amdgpu/ta_secureDisplay_if.h
index cf8ff064dc72..00d8bdb8254f 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
@@ -55,10 +55,10 @@ enum ta_securedisplay_status {
 	TA_SECUREDISPLAY_STATUS__MAX                     =3D 0x7FFFFFFF,/* Maximu=
m Value for status*/
 };
=20
-/** @enum ta_securedisplay_max_phy
+/** @enum ta_securedisplay_phy_ID
  *    Physical ID number to use for reading corresponding DIO Scratch regi=
ster for ROI
  */
-enum  ta_securedisplay_max_phy {
+enum  ta_securedisplay_phy_ID {
 	TA_SECUREDISPLAY_PHY0                           =3D 0,
 	TA_SECUREDISPLAY_PHY1                           =3D 1,
 	TA_SECUREDISPLAY_PHY2                           =3D 2,
@@ -139,16 +139,16 @@ union ta_securedisplay_cmd_output {
 	uint32_t                                           reserved[4];
 };
=20
-/** @struct securedisplay_cmd
- *    Secure Display Command which is shared buffer memory
- */
-struct securedisplay_cmd {
-	uint32_t                             cmd_id;                    /* +0  By=
tes Command ID */
-	enum ta_securedisplay_status         status;     /* +4  Bytes Status of S=
ecure Display TA */
-	uint32_t                             reserved[2];               /* +8  By=
tes Reserved */
-	union ta_securedisplay_cmd_input     securedisplay_in_message;  /* +16 By=
tes Input Buffer */
-	union ta_securedisplay_cmd_output    securedisplay_out_message;/* +32 Byt=
es Output Buffer */
-	/**@note Total 48 Bytes */
+/** @struct ta_securedisplay_cmd
+*    Secure display command which is shared buffer memory
+*/
+struct ta_securedisplay_cmd {
+    uint32_t                                           cmd_id;            =
             /**< +0  Bytes Command ID */
+    enum ta_securedisplay_status                       status;            =
             /**< +4  Bytes Status code returned by the secure display TA *=
/
+    uint32_t                                           reserved[2];       =
             /**< +8  Bytes Reserved */
+    union ta_securedisplay_cmd_input                   securedisplay_in_me=
ssage;       /**< +16 Bytes Command input buffer */
+    union ta_securedisplay_cmd_output                  securedisplay_out_m=
essage;      /**< +32 Bytes Command output buffer */
+    /**@note Total 48 Bytes */
 };
=20
 #endif   //_TA_SECUREDISPLAY_IF_H
--=20
2.39.0
