Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF05C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 02:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD7910E14F;
	Mon,  7 Nov 2022 02:59:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B2910E14F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 02:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m34Oj5CgFw5W+13tNsuBwx21SGegSBUiOT2qEsnE3tBZUTzKnSrablXM42gsAaJUkyHKD9/DVnriDTUqtRw3ztGfurJk2tDA5pe3DgHzJN70kw23GWJbbysz/+hJOLKzQN2zm/iLjv1A8O9x/jIeGLWrmXGvkgpcGOnL1SCQkJi7TGsnLCl6E0GuOdYH9/D/H6t2TIzivop0lfhSu18JI7npi7DU6xO+s28ftKYj0NjrjxeUVqSWMvGL0O2Hd3gRCwrM6EBPswJ4cpp8jciEAErTSPyJMP0NwyqCk+5r3IAyiUASu5zHcpeGRnLSgyijwWJb4l3tFOXHAXdZRL0aiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHkwHt8uCMA1R6+7K3S2nR6fp7VEUhO//DOO3YiJmCE=;
 b=NNC2wEQ0ZyQNAOG0lKGZgKz+zmUEdSFFiBc6/Gwnt+k1VO+Yc+2TE4oW1Stnbw91egvfm32inSNP7rhhMiqLe9xWMGQ43FZCILOvZ6l5z02BQvPAHkU3/e5pgGgF7guTSLWiHBPXGE8uGn5sTIlESeM+qUMiv8wsq4Fh3YWxXjki9VOP2SuRk+AsTbaHm2CoZOxLnMrLD9w/pigLHi8rHBDW1H6ewUxhz/UmEfXkvxPi+EY+MzzU/e7n5SxWMcb7PJHIISSmZkbB1XILjMuqVhyRFcmpwXvevV51rmRdPGsMr7Lo5hNIJ4x85QwoLq2WFD2DFCS7DARfpNFAi7Y6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHkwHt8uCMA1R6+7K3S2nR6fp7VEUhO//DOO3YiJmCE=;
 b=b+zgvAog09LBHsxWv2qXq2TVs2chHRPOM/27ySodZoAfstLRYC1mDUiVntSUWbmXm9oQraTk2AaclMBYEQ2d0XFG8UPmQ8Uak4fe+E2d9XWHEy1z5f2LsS4tgyNe2uRr4Ka4j36Xm4lYsvpSk816LJqudIRISh/kMUhfOCy3TY0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Mon, 7 Nov 2022 02:59:26 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::aa23:a85e:de27:6520]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::aa23:a85e:de27:6520%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 02:59:26 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Make kfd_fill_cache_non_crat_info() as static
Thread-Topic: [PATCH] drm/amdkfd: Make kfd_fill_cache_non_crat_info() as static
Thread-Index: AQHY8lSXfNvSCDRByEuNtPedqZUH2q4yxRIA
Date: Mon, 7 Nov 2022 02:59:25 +0000
Message-ID: <DM5PR12MB2469AC5CA95148A788A0F9B0F13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221107025614.1168989-1-Jun.Ma2@amd.com>
In-Reply-To: <20221107025614.1168989-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MN2PR12MB4342:EE_
x-ms-office365-filtering-correlation-id: 58018955-b330-4365-0445-08dac06c147a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tfir5Obcwl0AS19JKaxExhp6pPz538otKdcewrxZlA+hnSMlW+6kObRQJroN6PVLUs37272tBSKq1l+3wh7GXWFKJbFIrpTro09LGjOiU73FqvTqPbdE2z0lFwfmk0xVlvsU05P26QFAUF/ssYXim4mpc2puPemXPF9InapU217Awc+VeLEuRx8ZfiZM6NyX+/nQNMf0vAn3IohJV5BAIEtdOeYtfOv0Or8cGmvTGWyEEa9HTvjVOQEi7VP979xzfrZD9guW5Q4HzIL7p3jNUleITLE12e421ClMz7QX34FRhDcoRovEWuvtoxk+imA4DnL64i+v3Hick+OiVCUIP2LvbiXkGGyvIm4hfNCHOJmFm43Y+W27Mfc2d6YG5zkebxLXpysAQ0Dgz6FTsUY7ei0Llkl5dB/8/Bvjw3DkPi1Qg6OvYKVfhhHgkqjpKEHsCYPcCNkLYg4539AlLc1xat2Tk/OXnZ/Uqme2gkEhFu6e9sRvvXQ52vvmb5Sy27JNu2rxonXjhr+XJhtRnIoNZsqaoaPYqIgnwLAjQ96Yd+AXbvzrEe7Fw98GOq9S8UpmgM5j77bL9OZp7wlj/+4Jjek8pn4MUSUP3KNtMPwsydvia8vIFHTstgAh8NcK/12EglrGlilThHmkO44KWwZdBA8GCZgKMdswGvPPHVfFTZ1eYkyDjl0xAyh9h1Btnv825uHW6pCff0RaYyWXLUaVdSUOYmS1oh4NcyJwuqT+2seqYXXDqDokoMIxmukNZGppb1cvMx0kinCGs41Vs/X62g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(86362001)(5660300002)(66446008)(41300700001)(2906002)(8936002)(52536014)(71200400001)(33656002)(478600001)(6636002)(76116006)(66946007)(64756008)(8676002)(26005)(66556008)(9686003)(66476007)(316002)(110136005)(6506007)(53546011)(7696005)(186003)(83380400001)(55016003)(38070700005)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qKW79EBcMxBz+mlhFoi/JgN/N4DGjkX//C1+8vc7ehWcuT3Qu4J62d4Jc77L?=
 =?us-ascii?Q?7lsQRRMZWNqzhYrUsVPkUQhq2EaG2PawvNnVxjHt/cUNXXT4ftbSE1QwZLJc?=
 =?us-ascii?Q?cRBnj5oDdxtjT2grj3qVfGyCVxHDuQf+qoiFwj285fzQg/PvX8KoROdxISMf?=
 =?us-ascii?Q?Y2Td7TUtA1//+6ZXZbt703bbVxVDvuJhXhk2Gk041l/eycB/+eS8sJpEusef?=
 =?us-ascii?Q?u+G8D57Vs32LqlmUXcxxWhPWHbRlUyI+TESJrOayuX5mR0kUfCbxsnYr120H?=
 =?us-ascii?Q?Bn3LKevFSTBLYBZjfRCVXSl2BdbzriVvoMjzegRamnOZnkIn2LQZAboXFqqx?=
 =?us-ascii?Q?ZVcgTgKFw0EvoMauO6su5mIkh6IM9qBaYj4YUPw1LHo+SP4d80y3s9B+HVWs?=
 =?us-ascii?Q?DrplFl+PxgDXNJouO4h585Ciz7CNoWGqwSJl+U+3gA3joXn1IuZMcJZTmJZr?=
 =?us-ascii?Q?Th0kQrRvsSZerFN76L09EJBAIJGl6/t1nu+nXAtfRtFQ8SR6i6iFJmjCbQtT?=
 =?us-ascii?Q?qKQKMOJpIcRbfN6WOOgILhwA/5h0qWP5KiZlcwYPbKLbgYn1Otxkf14NKf4C?=
 =?us-ascii?Q?+9y/SNaWlpnavsyYhGMWt8MvL0aXgXCejwkYxYqIvjpN/wdS+E7Q5juhPJJ1?=
 =?us-ascii?Q?UaLt8QGduvRLabJBsW2vaDX+a4SUr4sZH8eqUYVvb+vx2MSYU2HRVfQSSWVo?=
 =?us-ascii?Q?s8sK9uf8RFyPNkleTjjM7HMNmzA1A9i+jdpY9d4sxaHsMQuo/Ku6jkd0x+c5?=
 =?us-ascii?Q?7trV56mPVLrI3NX0IQI0JgjSKzOeMzch3/HU/0A7fzcUUUYmAzZ5FZOglVtk?=
 =?us-ascii?Q?ERS6uZO0mUKjRsA9PCN+wKjTfKIwZGU4Ac3OTuKL3VxJWkplPE6BxCSt+/q8?=
 =?us-ascii?Q?sOsYS6Pza2RVFV0TrBcjcnwZhHZfDHhHVvxHZO9kBd37MIi6GduAxduES0SM?=
 =?us-ascii?Q?PL2Na3NQeQjUrHn2G4S1Vea5Qp+T0W2ZWK/10V3ORCZuKhECGQluT7SDOgut?=
 =?us-ascii?Q?foopI7TIfXL2y8kpFyortAP798TLVZ3/diehL+WStbwMhmeoE1qliQsFmJy2?=
 =?us-ascii?Q?hX7J33N8W2mqQS0lVOP7QGJihi7FBrD8Ce1cpJQJi5ovKNVE613Z4rJR+KF0?=
 =?us-ascii?Q?D7M6c3pYGNbl4l5xJ40s2RQXekGTMbULpVupZqGvk+mRfaHrFWh2WttrbR+n?=
 =?us-ascii?Q?/C9R0XZBynP6tgczbt8QeRei16hddtLtsTgk2aXMAPiKM/QnU4IApaA/89eb?=
 =?us-ascii?Q?Dcaz1ZZGtfO6A826CLp8CpY/k44aoLiSeKracIqn6otKAaxW/Uq07COZ8j1F?=
 =?us-ascii?Q?03R7oaOfVVTf1tfnzO/FxnZtLoyA1yqgq32RPh13XIPcWR2x6Yoc4GHJ2Nom?=
 =?us-ascii?Q?GEHe7W/Mmcss7vM4lasxbyjAdtEWKwFiZrgNylDxC9kV1DOE9cmHjQ4qNI8B?=
 =?us-ascii?Q?eaRXUQmosvgnA15OR+NaPJOEED04Hc1PM9y7izhl1XVy8FTkQHZsySHoX3Ei?=
 =?us-ascii?Q?kn781kLI6o7opjSz/ubKIm0CgMy4F01TRUbtVzk7nSSOmTn9roptwlh5QviU?=
 =?us-ascii?Q?LaV0br9znLXTD789+GZ0OXrKi9ywadHGdBVeSNKU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58018955-b330-4365-0445-08dac06c147a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 02:59:25.8732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WbGw+CnlOiL3D/3DKpVRC/r9uUvIZZvcAvebPXSgAJNJHzIZ63iTcFY1/MWLAAwAR+psi1/QSMQIrA8cxNXEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>=20
Sent: Monday, November 7, 2022 10:56 AM
To: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>=
; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: Make kfd_fill_cache_non_crat_info() as static

kfd_fill_cache_non_crat_info() is only used in kfd_topology.c, so make it a=
s static.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 1d9b90d979c4..ef9c6fdfb88d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1723,7 +1723,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_prop=
erties **props_ext,
 /* kfd_fill_cache_non_crat_info - Fill GPU cache info using kfd_gpu_cache_=
info
  * tables
  */
-void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct =
kfd_dev *kdev)
+static void kfd_fill_cache_non_crat_info(struct kfd_topology_device=20
+*dev, struct kfd_dev *kdev)
 {
 	struct kfd_gpu_cache_info *pcache_info =3D NULL;
 	int i, j, k;
--
2.25.1

