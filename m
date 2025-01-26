Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A731EC0218D
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jan 2025 03:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BB810E031;
	Sun, 26 Jan 2025 03:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HQiwFYNu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A621910E031
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jan 2025 03:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDsN3mAH6mgrBQmvBnn+YLRirf9UYJPpczZTeHMdrzE2qUB+nByAY7RY+rYC/PbZtRR8y8w0UuaJWlISZae4HkpRVAe4+zu67e17k8UfQgADgQZ0xKJ5xohs3pNE6WcQk0aFp5FDXOV3uIgHIf7d2YH9aZzce8Hta8zvsDt2IQAdiRgmoeVfH2vXou5+QXJSWZKO04a9Y181+Qu5Rlu4Ek0bKLKGSEjb894s3oE8R8D2Ex1KxP9GMtgq4vg6Cc+0ogbWAxpJI+IuJ2whlJDLltB9rTx073v/1oLtWQY9Nq5ORv1QjBBJOZQHSiCwYwl1byBhdyQ5Q1bbPjU7KzVZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVdLXj5QknxbIds8qigDOyhTaRNYZqkHSM4wmrc98Rc=;
 b=XcriHd6v2NTipmaVacPXZxMTgWqjG2zNJPAuw5Irpkf9Oa406qqqtObtgyGxX6t0rEpaq3nYYOzS6bveSVpCSGYlMWbzKrF9rWTz8xptfnwM3Flw+IiTNjDuQujMWQSPILdNAZccfmT+IMI5jfDK9auD5aX21IwkrsnJL4hnXgdUN8ZwC7BPXwAjO730qk2yrVS6MuqIeChoTz8Ypaafzt43i/I2IjScLauK0+Cgdf4oPOlvHHcF6ROLX5b1uO51muGPAZAac49h6QwuRTkuo5yZmbj5r4ADJ5j272sgFkCvls/D3UAZyGIkYYdRykQFq+iKCd2lb4tyi+TOoRa3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVdLXj5QknxbIds8qigDOyhTaRNYZqkHSM4wmrc98Rc=;
 b=HQiwFYNupALmPfu2aIWDFmLkaRe3/HooY8KxX18sGI6Zm2/U47NJEa/CgITT0MVhrb4vH1DPCQRWGiczt6ura5Y0qTeKWh9iCBmEP4ZN1hsS9XJibE04xE1iBwIlK9aqOlV2ckaCBEPgXNi4juclKmoxMsBE4MwuTlVGqdDAm8k=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sun, 26 Jan
 2025 03:00:57 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 03:00:56 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: only flush the validate MES contex
Thread-Topic: [PATCH] drm/amdkfd: only flush the validate MES contex
Thread-Index: AQHbbK+wFfkAWUGpgE2jmkgksb60MLMke9wAgAPmp/A=
Date: Sun, 26 Jan 2025 03:00:56 +0000
Message-ID: <DS7PR12MB6005B360F0FB50D473AD5688FBED2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250122092559.3317767-1-Prike.Liang@amd.com>
 <CY8PR12MB743595D4CDB9D1F3634455E085E02@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB743595D4CDB9D1F3634455E085E02@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a73a489b-d0a5-4a11-bd3d-cda76c888c8d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-23T15:16:01Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW6PR12MB8734:EE_
x-ms-office365-filtering-correlation-id: 30c40fe5-1b7e-4a33-1cfe-08dd3db5a79c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bhrygMTSg2ocFNAnmf1cl7eH1scYko7ltYnWoSrrbuovGhy5ljGOqYP0Tp9S?=
 =?us-ascii?Q?hNM6W+5TKhK71pudKn36Z+45RtDQhVQRznre56LP0fSJjoVI+lMNyNuHGqGH?=
 =?us-ascii?Q?0seejl4a2EYzlxC/V1I0HT4NFbfzF/PRkyhXv5aTpTRaL9lR+g2G5Zx2P0gX?=
 =?us-ascii?Q?VbyeMPM1dQjcifkzDKuxYxxZ1RGjvAFLwUGWIGJdaF8UtiQwXKLIR0rlula4?=
 =?us-ascii?Q?iNcLuQ7ao1m2nA76AiW33QGZYaKK8MncN2d5GajdXmi/fu9LXyIvf6r9qNfa?=
 =?us-ascii?Q?n4rlxtI4Ixm0OHESUJtutxZoqLQ7XC8EI2bFWwACV08XJ+eijnQAyAE2Lsmh?=
 =?us-ascii?Q?uLxDLFGFUnSS92tjoru8ThwHukB95KNlpmXivfwYBxrcuyDleHUABAUR9iO0?=
 =?us-ascii?Q?4xQ6zxUSOzx2YfUkYSvDH0jsTeWDw9SkYavFBTw4p5YL0rv18fNE6xNuSpRs?=
 =?us-ascii?Q?iES3IhYvx1QLp1O8JJ9d3uzA9Ym8aICAi7N07XAMFz/ckQDt/covbTrsDOee?=
 =?us-ascii?Q?GSXdyHlGXNj1TneLiQVDKY75esahlXBvnGA2ytSDclzTK3xU4fXdN4/c+ODF?=
 =?us-ascii?Q?+ErtGpGTLppLHQ5cgEYNR77+lm4kZLuwZSxfcpWHYMe/sWAWa1wxqJ2aNRVY?=
 =?us-ascii?Q?5Q1y7GzSDdK+AGix3jZ9vvnzaGyJyvgQXRL/7OzeUB7S+J/SH8lJMP8WMDi0?=
 =?us-ascii?Q?vb7dFRcVMPwp9MH7stPlP5haT+M+1CkhvBmhlRs7jxM+48l1NCxIaf5A4FYI?=
 =?us-ascii?Q?5pe8jgLe3Y19XoRYj1kSSGlvjt0BTUHe6JeFP2wXgtDwrKtvUM3gl7CWzORI?=
 =?us-ascii?Q?cug+nVh/khMSqKF8q1fa6TXQkSVlpKbPEHQT3anXvQKwfl6rNr6vl3IVH0LR?=
 =?us-ascii?Q?VA8BHINuMsUL19w1El6J474p/vUyf7DW0gUasu3TYGDS4iAwQ0iLGUs042z2?=
 =?us-ascii?Q?pJq99BD1QiEAEKQ00qyIJn+DUD574+iV5/E7aJw9HqcplWtIGYoXHcPMJ9t7?=
 =?us-ascii?Q?Ly17tj0FtTVfaj9RsFNcvmUJbgvmK0sGRrX4T0XEJAO9egsQq9CR5Jah8FnQ?=
 =?us-ascii?Q?EkFmJeqNb/oLoHiZB5DiuCP8JrkDKgRUFMuBrRVqZQ0JMPozowCefjZX4M72?=
 =?us-ascii?Q?xNX4awoRCJqBBmTAEHULTMyapm/wSTcy/wiHDpazyk7SRDbz4NQOBZmbTcXe?=
 =?us-ascii?Q?DBsibgqNhcRBVviGEaI7gpHDm2oPMJ4VlEM/BTt7UQtLa5tyhHPQn1b3s75O?=
 =?us-ascii?Q?maeHmdiAsC1i4ynyKk4JeEV5xAl3/wNC4Np5fWabTCVqVbloAIWmQFGNE7eK?=
 =?us-ascii?Q?f7/ljDNE2blJwOy2eCHu+t+DDwfEO5k3WDL8j27Ffr3bzZys2/at7r+SeBWR?=
 =?us-ascii?Q?53MM8MvQUmP2tb8r+tAhstA0nffvdhLcqOETlv4JdaaYWT7NJP0boMnQ48kH?=
 =?us-ascii?Q?oYr95ZDP6ol2cYy7xUkPxFP+p1JiDqSF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fTKm9XZFZ4cExoDJOwQQcaew98zagJasVZPuK0ohmhGqVmIXdfdAjiDxyfpH?=
 =?us-ascii?Q?mr1aGwO48iWA5Bi+3y+lwMP6+xPHbr5vQa1NlDPF0y2RSubeGDkUz+8caTUX?=
 =?us-ascii?Q?kCpy82hZB+2gx5zV1e9P7okODs3jzJmJxmm6iK4FImZMiUzKAuqdqz9QpfDF?=
 =?us-ascii?Q?R+sbnxWUcT8z5ntfH6mvd9O+ePVit1UnB7Yg62W6+29KBMLxKIHvBgf44nPc?=
 =?us-ascii?Q?8eDdm3HfRnVqqQzSdOjykTyj6DYfgY5etCHwvIQnq+vmle6tNnCH/Bdaxsdi?=
 =?us-ascii?Q?uxhBpzk/DYfEV39Lk8GJnxkddCfAcrQB4t13o0tFecUKrdzWBq2uvWAkWnrl?=
 =?us-ascii?Q?cHGe9+WnpWsmd0Yv8woa+MC4zioloM1J0EuKQAXovsBJMz7Ct9Atr5IK35Az?=
 =?us-ascii?Q?vsKfEqDpHf250wgFJLjOoFRAUU9prYOCSBcQKKj3ImUJnvPDg9Sb8qwKoKYq?=
 =?us-ascii?Q?bAiyQuIs2EqNmS1lLxckfcc7fiDVHhzhbE4CCYwUmrQVx9G1nO3TIvvDEDJM?=
 =?us-ascii?Q?YYlwcj7ZW0T/ciAoIBKkgtKr6DeoIw9yUwchpnOe+tl7mxQtG8YLyhnHU+Ej?=
 =?us-ascii?Q?FAnWw1J8MW4A1sni8g6vs5U6PW5jw9ihfxx+8grLEHldB8RKrXxBcCefcy0B?=
 =?us-ascii?Q?q0By5Z7c00duyfBe2HJCP5/7K2rdpSG+p6mvJB6DK6o5I9O/KXcHwhuGOoIQ?=
 =?us-ascii?Q?lpVLD7xublsuEdAlk0Boc/Hui0ltFaRve79sGRWk6eHcLYhd+kPYKPhwVvFI?=
 =?us-ascii?Q?Y8CkDHLhmPvz3i9PEAUOfnrNnVPmNfXy0jDrjWlIvki74BmW6Wy9/v2J0YQy?=
 =?us-ascii?Q?dIGUMkDDg1DaEtkphwlbTqA9tMB02Lc0mCBaDF+LO+Yto6GqUwa/vuQPrvM4?=
 =?us-ascii?Q?qiFdGsOjYiygVq1dohXNVNJhtEF0m5BqaaTereTs66Xho9fcqKcDcIw3ZW9r?=
 =?us-ascii?Q?AnER0bLA8iy/9gYi0GgWQg3H5DGZiVJvjQKoFLvrmt8NgiaDf8vqn5yTfpSX?=
 =?us-ascii?Q?zZvuXUOtoYgsZ9mfbq7HJo+Q386SeTmpHjsexnjuoneaij7vGjQyekArhqIF?=
 =?us-ascii?Q?1VeBh32YuQzH1FI6JHGefgSCEWiQfx3nAfci5kPQ++0KQDXU82loUmFCwslp?=
 =?us-ascii?Q?2bnTzIsqlKI4CvBB7xkymccEYfXYy9zZw3EPMRpit8L4AlIwnSvak0JS7Muk?=
 =?us-ascii?Q?hTv77EcFn4B+fS13A01plHom2YHj/HfU6u+0gNtCHGW6qVuTbSziaOARQ28F?=
 =?us-ascii?Q?v353jK+h90dGtrxPAi01QMAJiwkRTGrKr5h5+8TzdNAdnogCX9Fiq6THJeJY?=
 =?us-ascii?Q?SHdmplJKPF5DcjwWDMtoDZNnl6UOGMp+utSel5jgiBnQXo1dl2GZ5Q1V6jYQ?=
 =?us-ascii?Q?ysHCuV/z/1pS4Oj647fd6rkJdLWR8EuxOn5WuOKrJmlN/nfEnw9B3z0nHizM?=
 =?us-ascii?Q?WMpbdroHUEoGGKiA4kWtBZokL6glb9UWnGyYR2I2lrWcoXfW6QNSgfSE5Oqz?=
 =?us-ascii?Q?S+uc5hi0luB5DQ5SblP+hYwXImKMZAg0hXYdWOBqlBfIxiAi7oR2NZ7MqUbn?=
 =?us-ascii?Q?KK0xgUZMxIkaJEoMsMk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c40fe5-1b7e-4a33-1cfe-08dd3db5a79c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2025 03:00:56.6665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJNkCW5SOMS7tKS8GiqPHdkIIsPKaa8ZpHDj2O6zormIKhgXq6cLzSsZ9qqzLBSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
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

[Public]

Thank you for the detailed review. I will incorporate this change in the li=
ne above before submitting the patch.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kim,
> Jonathan
> Sent: Thursday, January 23, 2025 11:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: only flush the validate MES contex
>
> [Public]
>
> [Public]
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Wednesday, January 22, 2025 4:26 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> > Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH] drm/amdkfd: only flush the validate MES contex
> >
> > The following page fault was observed duringthe KFD process release.
> > In this particular error case, the HIP test (./MemcpyPerformance -h)
> > does not require the queue. As a result, the process_context_addr was
> > not assigned when the KFD process was released, ultimately leading to
> > this page fault during the execution of kfd_process_dequeue_from_all_de=
vices().
> >
> > [345962.294891] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> > (src_id:0
> > ring:153 vmid:0 pasid:0)
> > [345962.295333] amdgpu 0000:03:00.0: amdgpu:   in page starting at addr=
ess
> > 0x0000000000000000 from client 10
> > [345962.295775] amdgpu 0000:03:00.0: amdgpu:
> > GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
> > [345962.296097] amdgpu 0000:03:00.0: amdgpu:     Faulty UTCL2 client ID=
:
> CPC
> > (0x5)
> > [345962.296394] amdgpu 0000:03:00.0: amdgpu:     MORE_FAULTS: 0x1
> > [345962.296633] amdgpu 0000:03:00.0: amdgpu:     WALKER_ERROR: 0x1
> > [345962.296876] amdgpu 0000:03:00.0: amdgpu:     PERMISSION_FAULTS:
> 0x3
> > [345962.297135] amdgpu 0000:03:00.0: amdgpu:     MAPPING_ERROR: 0x1
> > [345962.297377] amdgpu 0000:03:00.0: amdgpu:     RW: 0x0
> > [345962.297682] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> > (src_id:0
> > ring:169 vmid:0 pasid:0)
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > index 9c2d8393cd4c..c39cdff58418 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > @@ -86,9 +86,13 @@ void kfd_process_dequeue_from_device(struct
> > kfd_process_device *pdd)
> >
> >       if (pdd->already_dequeued)
> >               return;
> > -
> > +     /* The MES context flush needs to filter out the case which the
> > +      * KFD process is created without setting up the MES context and
> > +      * queue for creating a compute queue.
> > +      */
> >       dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
> >       if (dev->kfd->shared_resources.enable_mes &&
> > +                     !!pdd->proc_ctx_gpu_addr &&
>
>
> You can probably combine this check in the line above since doing that wo=
uld not
> exceed the recommended line limit of 100 characters.
> Otherwise, align the indentation of the new check under the previous line=
's check
> for legibility.
>
> With that fixed:
> Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
>
> >           down_read_trylock(&dev->adev->reset_domain->sem)) {
> >               amdgpu_mes_flush_shader_debugger(dev->adev,
> >
> > pdd->proc_ctx_gpu_addr);
> > --
> > 2.34.1

