Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED79C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 13:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4AB10E5CF;
	Wed, 16 Mar 2022 13:52:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A0610E5CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 13:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cANSNCvqTYkAhNzVTlOr1pM3KpLBlWsoErsLoNm8kcKZ9UPE+0nWXpXR/6taGC6G1/O9pAhWKLD847qvitqjM1O+IJMVJFlVUEE0Fc9/EA/b6NG4x8Ru7TOvgR4yzFHfPUf/+RiPRR7EopuoQvZF+Ps4DZieedf2gk6DSlluHv3CDOgZ9xv+8pUuglFjZgTAEMXbF1uR9rwaDNBM6wfwtf3ioi4EGSTg9VF7fW6C4bhYbfPbPoTmlUd1ea79XfIJeEldhcGp73v5S2jPfGlG4dxFA/++McoDSk/mR4+lBimG6Yjx+ArhYmNhmSICd6xzLFIHuUkeP/kSiQF51z/3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJej225x+eAizKbq/FaTv32WuXen8AOHzHqa+i/pF4U=;
 b=lDqLU57UtKILr2muAoOhCE3T7CfAsc34PSb3BMULTBuVyuO0ZPXgd03Te6ZsxTMReJlyr0CxPzvzenHjD0vn5UiaCWOaXkhqbE1sBg3towvqmKloaUuNY5pHkvlMvJS+TkEr2x80HUP2sWHP1uGGBVGrgPIJV2cP0/DJir+a4ImnXDSbDaTOcw5q6s/fjB8//KDUt8zwbD2/ffl5ssRWYJOlqL3Xg6l6NMAetE+0UYLj69eGLFMZhk5pywgu2WtO77cWVJvTP/VIh1m8LCP+z9dNuklPwbDrkozEzVA5Plaj2HrepMsbQgOhac8/lsrEP6VMEeSMRI6bP7sBBem4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJej225x+eAizKbq/FaTv32WuXen8AOHzHqa+i/pF4U=;
 b=LaH7I3W7qF4SjHQBA6KpIczmENVnu6jaiksTBilTVOrjGS0K4ys1YQfWTGRaeP+GqK/IBBrXO8Ku/BlWvhMwOwZaxq8iFQfHVdLm8x44bygFY3EwLfcGIEoB6mqraye1c9hri4r6SvMCFBXemQfGD/2aQ8HmzY7vQAGzHnfxThI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 13:52:46 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 13:52:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/4] drm/amdkfd: replace source_id with client_id for RAS
 poison consumption
Thread-Topic: [PATCH 2/4] drm/amdkfd: replace source_id with client_id for RAS
 poison consumption
Thread-Index: AQHYORfzbb3uabrrTkGlT6RjdKduR6zCBvKQ
Date: Wed, 16 Mar 2022 13:52:46 +0000
Message-ID: <BN9PR12MB525750670296415F6907B746FC119@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220316092627.17359-1-tao.zhou1@amd.com>
 <20220316092627.17359-2-tao.zhou1@amd.com>
In-Reply-To: <20220316092627.17359-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=16a8508f-5a06-44e6-be02-cdab04a0d1fa;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-16T13:48:50Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce9d60a0-86a8-4101-c434-08da0754405d
x-ms-traffictypediagnostic: DM6PR12MB4300:EE_
x-microsoft-antispam-prvs: <DM6PR12MB430005D2F3A9C8A67392D77CFC119@DM6PR12MB4300.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LXDG+35jBu9eqhAhfCwaU7acKiLXr95gr6ATFJi/tejcz8+ghc6FkPmkCB1J/9YiK8a6aNL4y+fpTGLTSltBvfm95ML/hRshs/UzUokYfW475Dpl/bT2A3bWdqGgiRDt3PonezupfF+LaEvcWIt1hE3pN1Uzr/D+qQGQeBtkTov2O+hGuFEFVXj4C+PB4+fQNYIXF3TgDI8zWx/mo73CaTQ3k2iQFe//+dQf7wQXpSJZHCjneT8MYv9dZ25pjMCMJAa9aZ2L+vhRVowNwUfZRNI+xH9S/TwKNZIrKKeed4KtDZGjFFkEnvONa3eBQUmfrwjsxTQdy10A2viC9GBufSs7SOF1sm+M+zyUENV1byllwNPqjnOYB1OkrNtiikVeG7vv3+po8ijqYTAmCvOf6FWmfVPHPvBbn5LdCbcxLwOYqtzqOl0A1yBKljS/roVvD7SN1fgtU02aJ6ZTxIteK0T3JjXzQeyTMPGLRSOkr7MWthZzS3/j20scyD7oHkgTsgvRacVCHQZD5yBlhKgMevFvq08M2MyxGl1L5Aj9qiPzoZZ2PROPtTq8FzruokbxOBM3WGe/mpUA0ieEtbPi5rJXPJUsWqaqAuJaJbg689QWb5ow0cI7xLidryk+yTNigrnb67umj9pxR2YbY75uydQgFwGmNEUaj+ZbJfaV43GkiAd/zxAGpepEUOBesuTlMi2trrOkc2VpUng+Z0+5Ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(316002)(52536014)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(122000001)(86362001)(8676002)(26005)(186003)(110136005)(38100700002)(53546011)(7696005)(6506007)(9686003)(71200400001)(38070700005)(508600001)(83380400001)(2906002)(33656002)(5660300002)(8936002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jPka5CzHd/Cc4EM2dZsOR2FktO61aoajFeai9DPN/o/S32RA04cq/fLdHr/a?=
 =?us-ascii?Q?Mf6hUswESq+7s+M0xSf4R8t/Jy4RS2SRAIZ9QQGb2uzkIx66g/IgIPmJBNVg?=
 =?us-ascii?Q?aFIB4XhLIk8C/8GLDiP7twwHU6c5UImvKx6y+YgLFhheBrHeyVRKYlyBl+be?=
 =?us-ascii?Q?hMtMiNzu8xeHSdsCQ/nVri7pkw9qHCns9GKzWx3CsIn6mKBZUkE47dMio1gD?=
 =?us-ascii?Q?kXHXsaPhqhHXTbAHVG/+JVATl92eC4AcA3YIywBnEp0v4jkSs9obdJ1u4D9b?=
 =?us-ascii?Q?24o5EPRCsqeNJVl/l6ub0BrnCpuiXAOPbCT8NPaKUuoWEu5eSSfldfChyPVw?=
 =?us-ascii?Q?OE1hRBfahR9oJg9956d73TDMSxweRdiE3Di/OqaT115AjL8vqU/qu1/3CV0+?=
 =?us-ascii?Q?gBZHrB0pf0khwe2td90EPkPkVBJ4D3MMeFFFCLrcnOWhT+PTlW5yF9lSRRnn?=
 =?us-ascii?Q?HdMnPOrnGitBsjpDS0vHSaSJNjTw40SrNbPsPfuBLrQmpvS0e1OyA2+S6uqB?=
 =?us-ascii?Q?Md9MCPK9CpeYmFzasbl3RXmGtfxeBIZP6IFPjq7Pe1ocJbQqGuBaavMqx7GO?=
 =?us-ascii?Q?v/K0opihTaCCc+NJUq/SobRLQuYZ9j89lOUvcrT2+l6NETu4KLuVVODI2AzR?=
 =?us-ascii?Q?KT3oll+mhQvvzY4MJaMOOWyoRAfulO4gkNzmGC4iLq7zcQKfjxbQ7YV6rn4N?=
 =?us-ascii?Q?e09RR55lYfOTVY+3MwzXTOoISRQhF7CmoBYvBgTWWoi/PieW4gVCNc6t+9dq?=
 =?us-ascii?Q?7Mv8IC1JkgMs3po7uQcaUd/fW4wiMGsb/1WCUne2M1kNJ+kp3lm4r0+B0siT?=
 =?us-ascii?Q?npvBDoyyuemlNlhSkxDH4XxQvC3G36gDJPmRa4zNO1uK3KwSdv7WW0ocsZGQ?=
 =?us-ascii?Q?Dy397hBNi9tKsHhKLFcmrWSb8LHLKpHB6S2f3/2GM2M0yw7KUwYJVwgwJCCX?=
 =?us-ascii?Q?FBt/fEXe47kYy0vPvgdvkq5/wVh1TJyGNsesM/cMdLBgfvrBW3Uvd8Eera/p?=
 =?us-ascii?Q?YpIDAhfpjUux08bHIX7Wi/Og3jpHHMCvWoawFo8shEQKDMHPKxQHVQo2mUDU?=
 =?us-ascii?Q?86AyRzm0+v7GKDR9k/EbAfAL5itgh06u+NJqVizWXCWkmpDhXXLpZEXCnu6m?=
 =?us-ascii?Q?wSWeOQQyyG8u/d6DBrHZpbUe60PZz0PFzD8ygtLnBIOYgB4mj+6IFlUxzXm+?=
 =?us-ascii?Q?S6D42JkXlQ1mPa7FqU4h/k+xrfwEL8Mh1eB4E1Os8pCIZJJWAbgclXW3RA3S?=
 =?us-ascii?Q?1jTniAraEl2qQXxJqu1WhDM4zs0BeHwTXWmkrwJhMjqv1UHC0Nrh3w6GJKIb?=
 =?us-ascii?Q?C7CeCE/8xtOrSzffocFkTQlGC3QlJB8cyKTCKV/aVvknZ9NfuqM0pBLpgc11?=
 =?us-ascii?Q?v54LzQ5bMhl+oriDAXFJZx/isPEMkT7RVtjsuzh23He8dB46WsAjEqeT6NQE?=
 =?us-ascii?Q?K6kxjHmET33TkdG4Le9yb27aMn3OI/2v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9d60a0-86a8-4101-c434-08da0754405d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:52:46.2224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpyDgwrryGKDJFRKOY6JYBkCNCF1m5EcrxiyurpbavA+FakS3JCkbIkDPKsJCmZXqJ7yYukhJAUZXP1o5nB1bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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

[AMD Official Use Only]

+       case SOC15_IH_CLIENTID_SDMA5:
+       case SOC15_IH_CLIENTID_SDMA6:
+       case SOC15_IH_CLIENTID_SDMA7:

Please drop the unnecessary case here since the feature is not available on=
 all the ASICs.

+       case SOC15_IH_CLIENTID_GRBM_CP:
+       case SOC15_IH_CLIENTID_SE0SH:
+       case SOC15_IH_CLIENTID_SE1SH:
+       case SOC15_IH_CLIENTID_SE2SH:
+       case SOC15_IH_CLIENTID_SE3SH:

And I also think we can reduce the cases for SQ interrupt as well

With above addressed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, March 16, 2022 17:26
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Stanley <Stanley.Yang@amd.c=
om>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: replace source_id with client_id for RAS p=
oison consumption

client_id is more accruate here and we can deal with more different cases.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index a992798ff8b6..e5f03f79546f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -91,7 +91,7 @@ enum SQ_INTERRUPT_ERROR_TYPE {  #define KFD_SQ_INT_DATA__=
ERR_TYPE__SHIFT 20

 static void event_interrupt_poison_consumption(struct kfd_dev *dev,
-                               uint16_t pasid, uint16_t source_id)
+                               uint16_t pasid, uint16_t client_id)
 {
        int old_poison, ret =3D -EINVAL;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
@@ -107,11 +107,24 @@ static void event_interrupt_poison_consumption(struct=
 kfd_dev *dev,

        pr_warn("RAS poison consumption handling\n");

-       switch (source_id) {
-       case SOC15_INTSRC_SQ_INTERRUPT_MSG:
+       switch (client_id) {
+       case SOC15_IH_CLIENTID_GRBM_CP:
+       case SOC15_IH_CLIENTID_SE0SH:
+       case SOC15_IH_CLIENTID_SE1SH:
+       case SOC15_IH_CLIENTID_SE2SH:
+       case SOC15_IH_CLIENTID_SE3SH:
+       case SOC15_IH_CLIENTID_UTCL2:
                ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                break;
-       case SOC15_INTSRC_SDMA_ECC:
+       case SOC15_IH_CLIENTID_SDMA0:
+       case SOC15_IH_CLIENTID_SDMA1:
+       case SOC15_IH_CLIENTID_SDMA2:
+       case SOC15_IH_CLIENTID_SDMA3:
+       case SOC15_IH_CLIENTID_SDMA4:
+       case SOC15_IH_CLIENTID_SDMA5:
+       case SOC15_IH_CLIENTID_SDMA6:
+       case SOC15_IH_CLIENTID_SDMA7:
+               break;
        default:
                break;
        }
@@ -269,7 +282,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                                        sq_intr_err);
                                if (sq_intr_err !=3D SQ_INTERRUPT_ERROR_TYP=
E_ILLEGAL_INST &&
                                        sq_intr_err !=3D SQ_INTERRUPT_ERROR=
_TYPE_MEMVIOL) {
-                                       event_interrupt_poison_consumption(=
dev, pasid, source_id);
+                                       event_interrupt_poison_consumption(=
dev, pasid, client_id);
                                        return;
                                }
                                break;
@@ -290,7 +303,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                if (source_id =3D=3D SOC15_INTSRC_SDMA_TRAP) {
                        kfd_signal_event_interrupt(pasid, context_id0 & 0xf=
ffffff, 28);
                } else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {
-                       event_interrupt_poison_consumption(dev, pasid, sour=
ce_id);
+                       event_interrupt_poison_consumption(dev, pasid, clie=
nt_id);
                        return;
                }
        } else if (client_id =3D=3D SOC15_IH_CLIENTID_VMC ||
--
2.35.1

