Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B1DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011FB10F360;
	Fri, 28 Jan 2022 14:58:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E0F10F360
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEtxng+evt1X35IhY73axvEbnv02CefQoT+Tq909jSPldfxLJsuWl4Pp2Wbse0dGmj7pOZZZ38tXACKR0GbH8OrS4hCcoqSInBjJYKxT1GyWjo5rWUuvi3yhIbT+dQp/tOtjE1r5Yvabjez6BBTr3vH3bOPQhLkwvziPyKXOU6dPhx2HFX8yrd73nyC1ooWriST09mR0H5uhdHzuv8x5HbTt2+zxgTgBnBuLr+vwo5cLotO3wZtXw/JHk2XQZAT1nFI9AcTwlZqaBCSL2NyRcc5iN5X4y23zP/wAAK16Lr5LV3GVK5OLUGL4m1M6sEvOX7bkk2g8R1yUxIgcCEr2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv+qpTatS1Zz88MnPXgdV1we1RO+fy+S7edlPp1Zz1M=;
 b=b/CgEgmwM9tpKACMNuk9XV++WRMxB0em9GNdjW4c2tIO0xenR0k5cVtTzTvmmZCQ4cfqxsXNTqBk9A87HroE8eRKytdrpWrTFyjTwQiLG0fJepLXkBjopAf0b3w6WZNrqnMl5E+Qb3KvzoolXuhBE7yNhORtgPADNzqx5steQqdynPw4ByWu3oL+LpQ9iGTbyB1whj9JMnCMT0n8gKDgYI3MrELrgXsZbDGTIe5V3mCEjWIP8Zw8hdhwadf+/Ji0uRWwT0YTuOWmTga6BfmoI+12Vrn9TteHG+yHwL0l7GK+CnmnnPJ/VK4a6BJE3tTE/RodcQaHW+4NaJeG1MxhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv+qpTatS1Zz88MnPXgdV1we1RO+fy+S7edlPp1Zz1M=;
 b=R8/Q4lSAXYCtN0v8dPAgdVr2+urPjehLabrPy/ayEyuf0mIH9y+bNs39vhohoguPJ/RFxM3WOHLWV2Ui9H9mtzxQ7EmMi48rnfZ/MODZWIUQyXaAyIJVSnpUPWabNH0E9h9caDrhzdAjOQF2mqhzO6tbku49PQveExczdp3DmrE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN7PR12MB2689.namprd12.prod.outlook.com (2603:10b6:408:29::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 14:58:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 14:58:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V3 7/7] drm/amd/pm: revise the implementation of
 smu_cmn_disable_all_features_with_exception
Thread-Topic: [PATCH V3 7/7] drm/amd/pm: revise the implementation of
 smu_cmn_disable_all_features_with_exception
Thread-Index: AQHYFBV1TQryOs9mWkOOdRbfUke7Gax4htth
Date: Fri, 28 Jan 2022 14:58:37 +0000
Message-ID: <BL1PR12MB51448A2733327EA728FDB9D6F7229@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220128070455.202014-1-evan.quan@amd.com>
 <20220128070455.202014-7-evan.quan@amd.com>
In-Reply-To: <20220128070455.202014-7-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-28T14:58:36.733Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: cb956bf6-c8bf-2992-e146-37f35737eec9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8785e66e-c519-4793-55db-08d9e26ea9e0
x-ms-traffictypediagnostic: BN7PR12MB2689:EE_
x-microsoft-antispam-prvs: <BN7PR12MB2689E1B0D683A57F1BD63444F7229@BN7PR12MB2689.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHuvHEV09fBkN0++SMJcCvOlsu6vUFLzJX3LEYOiguLo1+ZevxNLRlQahX8zofMMsH0Jc3V8pATqME2RdjZfr1GlbBT0kKGgQ93fZquEGU4gHtufi+LchHit9vjqB3j3LZeABhjKZZezXJoOibtbmFEFzMcv9hgKQzi0MLJ9+IEKWOfCn/10HdHfcBwd+PbrqK9WwsVGqT/uT9A1unrxTyuQ0oT6kE6zuj7Jp8PpKoK1ojEsY/LGLg5VhW8CSsKQqbX7WrqMmnUNuRszIyNeuG3t2r0jyDTcOYFbJzASUMx457tcD3RK+PE2XI4Qz+fau4qAgNeF/X8gq8WrHjARXq4qPyWGy6SnkFwnHA+QzYqJ19Gxsl2EIlQzLx72Ur2YrYr3r9K8DSBMgjtBedOkhGwMVGxvPVXyw4m+CdLFCccKh6eMqBHlU0PCEq4mkWHPq6N+HsoE+XPrJD0WbpJnzETjZLE2D4mzUvdiqS6V9zPMFuZ9Lz/X2VquKBaKQzXDF2/wKixOOOkHPDSpdVqwVOFR7zwPOCREWtGe2BT1JuhyYN830Jt1IB2LJaSFJbQbfsjQtm1yd+dzZbxIuSnX0xDdpjCKqs9n6eqqbRupvk9LIJpiNzBrCPwBdM5GnMcygeRhDgIxZnGKCzta27urhFOA0mHdUMfswPZsM2pq3AZkDRnvRCfP1aczXALKZbysZ5oeEYRVLCcz1b/lHLjhOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66446008)(66556008)(66476007)(8936002)(52536014)(64756008)(66946007)(38100700002)(76116006)(19627405001)(110136005)(316002)(4326008)(71200400001)(122000001)(5660300002)(33656002)(6506007)(53546011)(7696005)(2906002)(9686003)(508600001)(83380400001)(86362001)(55016003)(38070700005)(26005)(186003)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aytrCKquXVDuQMPwkcU4aro0aZs6Zdk2Ac1THJ+OXNuXDVCYrKg3swvwqmMH?=
 =?us-ascii?Q?UdQGIq+vbmrQK/oXUo5gGsdelrJWolRttdj1R7VW+kJdRct/wq7RNr2KMRZt?=
 =?us-ascii?Q?KSl6+THA8eQxMT3M3McXuxEc2xjQgre2H3AiP6zUPFb+xJG/wnly9XhVN93z?=
 =?us-ascii?Q?wphhKBOZ6jDly64gzP3YS0w1G2btTNnWSmo90S+k7bTgVh55enItRADnNSIg?=
 =?us-ascii?Q?i9mP1vQRmaIrZDUfcLiyvlha10DTph2gwVnN4QxMJ1+nN05M/Lu6P1+V/Z2U?=
 =?us-ascii?Q?2UFbqrcaWn5Gcd3lwNwr0QM9tFKh+gTZvfl0wH6+VWPHkHH4PrW1k0+wh8Sf?=
 =?us-ascii?Q?gi6nRsle4WTYmdp+OC1JenYvAuw0SbeDvrp+zgRoHyB7+d0g4z/0Z07tLtlI?=
 =?us-ascii?Q?iotronI4IQYRvhmjlFwNLaVVOH5A+xnvoCBKXYlPrhFQWM5tFOt5IdCDecmP?=
 =?us-ascii?Q?X56c4hWQKUXDeDHUJj+qDnis6w0xFi8maHgzoWJRJVBvIBehMO79SGz8Xr2o?=
 =?us-ascii?Q?a9EMx/l3Ktn6e0lR09ylBnugkAcMcDrKvLH6JhrrBf46PdDdlbTIH9K4Npqz?=
 =?us-ascii?Q?5JbDeYV/RWfAOrOOB5shuUeg/bDl77NU9erHMJxqi6omH/wquDBZ19d967a1?=
 =?us-ascii?Q?hiN3CO3RXGD2fhXJi7zaKjHzZD0zXD4H9hRCnqNbCz/NWfa/ZdMGgk7TU8E1?=
 =?us-ascii?Q?6o7VQWdXuPzCeFD+M1rBN+KQjEe+QHCcDUnXDEXbDkHSZQRcGI+rCibya2tC?=
 =?us-ascii?Q?sJRLWHbctKRUAKKrRad+4F4xbl1QCWQRX3Z8fkC0EVATmFpQVvDlcSsakqYW?=
 =?us-ascii?Q?w002EA0PSNcVqo5gVw+GsqrUg4+YdQqnbo3skiXk8nEJOlEu/DiNer1Gg2Ip?=
 =?us-ascii?Q?YjgFvTm9wRzw1ZRpVEdOYkxeAjhFkInd62ddq6IPXf+ua4BfQ4lIpYaW8VWB?=
 =?us-ascii?Q?ACtXocRAyIGoYNLQvwDitDGXRELzv4HOhChuz/b3KSQink/ha5hiY8oXPhh1?=
 =?us-ascii?Q?/yWHASQRsNn4RwaE/FD/L0AaPaF5TnDQCxuf0Fj1TA3hib4Di9lrCS8sKTGS?=
 =?us-ascii?Q?Y1YQepvpsftRcoDUvDxZjJ+dumB3r7qYroNbnKJal+j4u5azadVZRP6Y8ibZ?=
 =?us-ascii?Q?99FVrcHIUum1Ifxp6FqpUwPJ7UZ7oia5vPt+ErmUnTpLSc8MgCCBGudMvJYi?=
 =?us-ascii?Q?Pze+Ndk45v8Zw+yvgwJ739Ijxmce7mGrhZWn/Ke8h0xTv6RDE8+rH9Az1CWh?=
 =?us-ascii?Q?M2xF8UKCnKez4murt3g++ItuHqCgXu33bhJXPpeWJMyXySgci/YQ1poFno9A?=
 =?us-ascii?Q?Z2/VKp+jXi/uNpjZQYUx5+7ubNBArhi1Apgda8rdH5pTOBpRS4y8qwC4csei?=
 =?us-ascii?Q?hwzt07dccE+NJm/mFy//BD37Ge5ST8tJ4PKW1DQvAlYfqwjZP+nZXY49Ub6n?=
 =?us-ascii?Q?DmStCYAb/Y3gpLbzjtKOkv9MMpYf5ooqAp+wBoBybY3K3l4iSVAVE10fy1ni?=
 =?us-ascii?Q?igg+E8NwE7QUcg6AX/v4wgfhbISptnBOT3nnD+8I4otJSMtH3/aJSQRIDt80?=
 =?us-ascii?Q?ozDqkh9y/3IgDsHvgiM/11TiuXFjMiK52PjpryyHCZbw7/waSG6i2Dqrs1xX?=
 =?us-ascii?Q?APXzaqLz7UMpaYE8Tp3NxM4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448A2733327EA728FDB9D6F7229BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8785e66e-c519-4793-55db-08d9e26ea9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:58:37.2885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqXeYEcuQZ5TaEolwQ0lXgm5OnSe1jO05f+ipe1U8GyFut7yxcNdV4DDrifclzqM1GzQY/C17EgJIrKCyRtKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2689
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51448A2733327EA728FDB9D6F7229BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, January 28, 2022 2:04 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH V3 7/7] drm/amd/pm: revise the implementation of smu_cmn_di=
sable_all_features_with_exception

As there is no internal cache for enabled ppfeatures now. Thus the 2nd
parameter will be not needed any more.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I0c1811f216c55d6ddfabdc9e099dc214c21bdf2e
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 9 ++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 7 -------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   | 2 +-
 5 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 59be1c822b2c..1c9c11a92d42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1360,9 +1360,7 @@ static int smu_disable_dpms(struct smu_context *smu)
                 case IP_VERSION(11, 5, 0):
                 case IP_VERSION(11, 0, 12):
                 case IP_VERSION(11, 0, 13):
-                       return smu_disable_all_features_with_exception(smu,
-                                                                      true=
,
-                                                                      SMU_=
FEATURE_COUNT);
+                       return 0;
                 default:
                         break;
                 }
@@ -1378,9 +1376,7 @@ static int smu_disable_dpms(struct smu_context *smu)
                 case IP_VERSION(11, 0, 0):
                 case IP_VERSION(11, 0, 5):
                 case IP_VERSION(11, 0, 9):
-                       return smu_disable_all_features_with_exception(smu,
-                                                                      true=
,
-                                                                      SMU_=
FEATURE_BACO_BIT);
+                       return 0;
                 default:
                         break;
                 }
@@ -1392,7 +1388,6 @@ static int smu_disable_dpms(struct smu_context *smu)
          */
         if (use_baco && smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))=
 {
                 ret =3D smu_disable_all_features_with_exception(smu,
-                                                             false,
                                                               SMU_FEATURE_=
BACO_BIT);
                 if (ret)
                         dev_err(adev->dev, "Failed to disable smu features=
 except BACO.\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 721b4080d3e6..55b24988455d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -990,7 +990,6 @@ struct pptable_funcs {
          *                                       exception to those in &ma=
sk.
          */
         int (*disable_all_features_with_exception)(struct smu_context *smu=
,
-                                                  bool no_hw_disablement,
                                                    enum smu_feature_mask m=
ask);

         /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index acb9f0ca191b..2a6b752a6996 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -767,9 +767,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu=
,
  *                                               @mask
  *
  * @smu:               smu_context pointer
- * @no_hw_disablement: whether real dpm disablement should be performed
- *                     true: update the cache(about dpm enablement state) =
only
- *                     false: real dpm disablement plus cache update
  * @mask:              the dpm feature which should not be disabled
  *                     SMU_FEATURE_COUNT: no exception, all dpm features
  *                     to disable
@@ -778,7 +775,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu=
,
  * 0 on success or a negative error code on failure.
  */
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
-                                               bool no_hw_disablement,
                                                 enum smu_feature_mask mask=
)
 {
         uint64_t features_to_disable =3D U64_MAX;
@@ -794,9 +790,6 @@ int smu_cmn_disable_all_features_with_exception(struct =
smu_context *smu,
                 features_to_disable &=3D ~(1ULL << skipped_feature_id);
         }

-       if (no_hw_disablement)
-               return 0;
-
         return smu_cmn_feature_update_enable_state(smu,
                                                    features_to_disable,
                                                    0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index bfe3430829c7..a4c593ed8b03 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -79,7 +79,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
                                 uint64_t new_mask);

 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
-                                               bool no_hw_disablement,
                                                 enum smu_feature_mask mask=
);

 int smu_cmn_get_smc_version(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_internal.h
index 0063346ed163..530be44e00ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -57,7 +57,7 @@
 #define smu_feature_set_allowed_mask(smu)                               sm=
u_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask)                         sm=
u_ppt_funcs(get_enabled_mask, 0, smu, mask)
 #define smu_feature_is_enabled(smu, mask)                               sm=
u_ppt_funcs(feature_is_enabled, 0, smu, mask)
-#define smu_disable_all_features_with_exception(smu, no_hw_disablement, ma=
sk)          smu_ppt_funcs(disable_all_features_with_exception, 0, smu, no_=
hw_disablement, mask)
+#define smu_disable_all_features_with_exception(smu, mask)             smu=
_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
 #define smu_is_dpm_running(smu)                                         sm=
u_ppt_funcs(is_dpm_running, 0 , smu)
 #define smu_notify_display_change(smu)                                  sm=
u_ppt_funcs(notify_display_change, 0, smu)
 #define smu_populate_umd_state_clk(smu)                                 sm=
u_ppt_funcs(populate_umd_state_clk, 0, smu)
--
2.29.0


--_000_BL1PR12MB51448A2733327EA728FDB9D6F7229BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, January 28, 2022 2:04 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lazar, Lij=
o &lt;Lijo.Lazar@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH V3 7/7] drm/amd/pm: revise the implementation of smu=
_cmn_disable_all_features_with_exception</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">As there is no internal cache for enabled ppfeatur=
es now. Thus the 2nd<br>
parameter will be not needed any more.<br>
<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Change-Id: I0c1811f216c55d6ddfabdc9e099dc214c21bdf2e<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | 9=
 ++-------<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 1 -<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 7 -------<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_internal.h&nbsp;&nbsp; | 2 +-<br>
&nbsp;5 files changed, 3 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 59be1c822b2c..1c9c11a92d42 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1360,9 +1360,7 @@ static int smu_disable_dpms(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 12):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 13):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_disab=
le_all_features_with_exception(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_FEATURE_COUNT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1378,9 +1376,7 @@ static int smu_disable_dpms(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_disab=
le_all_features_with_exception(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_FEATURE_BACO_BIT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1392,7 +1388,6 @@ static int smu_disable_dpms(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_baco &amp;&amp; sm=
u_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_disable_all_features_with_exception(smu,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SM=
U_FEATURE_BACO_BIT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev, &quot;Failed to disable smu features except BACO.\n&quot;)=
;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index 721b4080d3e6..55b24988455d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -990,7 +990,6 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exception to th=
ose in &amp;mask.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*disable_all_features=
_with_exception)(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
 no_hw_disablement,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; enum smu_feature_mask mask);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index acb9f0ca191b..2a6b752a6996 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -767,9 +767,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu=
,<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @mask<br>
&nbsp; *<br>
&nbsp; * @smu:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; smu_context pointer<br>
- * @no_hw_disablement: whether real dpm disablement should be performed<br=
>
- *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true: update the cache(abo=
ut dpm enablement state) only<br>
- *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false: real dpm disablemen=
t plus cache update<br>
&nbsp; * @mask:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; the dpm feature which should not be disabled<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_FEATURE_COUNT: no=
 exception, all dpm features<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to disable<br>
@@ -778,7 +775,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu=
,<br>
&nbsp; * 0 on success or a negative error code on failure.<br>
&nbsp; */<br>
&nbsp;int smu_cmn_disable_all_features_with_exception(struct smu_context *s=
mu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool no_hw_disablement=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_fe=
ature_mask mask)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_to_disab=
le =3D U64_MAX;<br>
@@ -794,9 +790,6 @@ int smu_cmn_disable_all_features_with_exception(struct =
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; features_to_disable &amp;=3D ~(1ULL &lt;&lt; skipped_=
feature_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (no_hw_disablement)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_feature_upd=
ate_enable_state(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; features_to_disable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 0);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h<br>
index bfe3430829c7..a4c593ed8b03 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
@@ -79,7 +79,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t new_mask);<br>
&nbsp;<br>
&nbsp;int smu_cmn_disable_all_features_with_exception(struct smu_context *s=
mu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool no_hw_disablement=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_fe=
ature_mask mask);<br>
&nbsp;<br>
&nbsp;int smu_cmn_get_smc_version(struct smu_context *smu,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_internal.h<br>
index 0063346ed163..530be44e00ec 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
@@ -57,7 +57,7 @@<br>
&nbsp;#define smu_feature_set_allowed_mask(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; smu_ppt_funcs(set_allowed_mask, 0, smu)<br>
&nbsp;#define smu_feature_get_enabled_mask(smu, mask)&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(get_enabled_m=
ask, 0, smu, mask)<br>
&nbsp;#define smu_feature_is_enabled(smu, mask)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; smu_ppt_funcs(feature_is_enabled, 0, smu, mask)<br>
-#define smu_disable_all_features_with_exception(smu, no_hw_disablement, ma=
sk)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(dis=
able_all_features_with_exception, 0, smu, no_hw_disablement, mask)<br>
+#define smu_disable_all_features_with_exception(smu, mask)&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(disa=
ble_all_features_with_exception, 0, smu, mask)<br>
&nbsp;#define smu_is_dpm_running(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(is_dpm_r=
unning, 0 , smu)<br>
&nbsp;#define smu_notify_display_change(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; smu_ppt_funcs(notify_display_change, 0, smu)<br>
&nbsp;#define smu_populate_umd_state_clk(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; smu_ppt_funcs(populate_umd_state_clk, 0, smu)<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51448A2733327EA728FDB9D6F7229BL1PR12MB5144namp_--
