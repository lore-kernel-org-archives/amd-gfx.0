Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9537D232E2
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 06:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA28D10E173;
	Fri,  9 Jan 2026 06:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iMbXSfZl";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F17510E173
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 06:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9J4Ag0+UOqJlq30V4TNlCP4CMN54NvSbT4355xA9Zy93SHw/Dw3x4MUfliZYZyssz0dKSaiBWjSyFOP7gvIwHPXV/1UfhATkagjhRDQo7N7K57bMBJu7P8fwu3wm44tV/VZhJ+eSugSswHD+uIuR7k8L+e1PkzWngXk6CKh1LoV0tpavcWpwGbxmYihd06UR0I0RLj2rFRkj0q5n+GyGF4YgiXZ2A+pDGOJ0wASe5M9NirlEWclwJJM+k4Y85F9dhzqnqy/Mxt1VBgRm3wnleD+/r0XRE9nV0CNYf8BoK39R6z0SpfLTBvfUjBZ70ur2a6r/2kiWIOkqQ5DnZ0feQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgWnGAoS/iGCnXhSo2gIu5iMp7JRJECsERCP7LYQImA=;
 b=xwHxXlDm2SPauXL8SrIEZjE5HucAj0Kkr9uDC/qzXn6ZbUfHKF1aq2VRIoPytLxsgN5fyIvMmqmtJCo0zR3brGB+aFUoxiv0z/trlgIocMHSR62MCphAC7MFUfmdTwqsBO3tK9K0wzaGrlXu3AnxIGXemTZLbmaowS9cS3K5YzvWtkO5KgTztdAkFbebjoFEExzoE6K86ESI1CZrN+ROD3FJre/h2b3VstQnYi4w/geaqcG/WP/phx2DOyMzBxLNSZ7XYMeYCq5LpoJay2GOdACS0RxNGnFce27k3ImWZupUAhNLDBKj7CZjVZK7VnHHToQKrp8f3eX/u0RLbIrycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgWnGAoS/iGCnXhSo2gIu5iMp7JRJECsERCP7LYQImA=;
 b=iMbXSfZlasS9+DT3FRZHV5GIw81hRoJFhH/OgKuTzeckD2FZF5IpOYFaNQSPuVDcpTb7OZTP9IqSqG0qaGoTSXUXOouqAodxr6Rh6TUWVSeFroo9dwSO7m4jybRuXzhM2vYyBYF97YBhFpdUUH0v8zw6rPz4wMITrFVPbtP5ut8=
Received: from CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 06:16:51 +0000
Received: from CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37]) by CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 06:16:51 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v3 24/24] drm/amd/pm: Use message control for debug mailbox
Thread-Topic: [PATCH v3 24/24] drm/amd/pm: Use message control for debug
 mailbox
Thread-Index: AQHcgFpM6WMgWWxCGEuiG8XTrFEDT7VJXklw
Date: Fri, 9 Jan 2026 06:16:51 +0000
Message-ID: <CY5PR12MB608172E29F558FF844AE85AF8E82A@CY5PR12MB6081.namprd12.prod.outlook.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
 <20260108044839.4084279-25-lijo.lazar@amd.com>
In-Reply-To: <20260108044839.4084279-25-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-09T06:16:31.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6081:EE_|DS7PR12MB9475:EE_
x-ms-office365-filtering-correlation-id: 99f95c63-1d2c-4be8-013f-08de4f46add8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?50ql/9ARQstjN94ZfxtydGL0c8Jc3DUtXx7XGt1oek3Xd+EoG1BqyErKiPlO?=
 =?us-ascii?Q?fosHQ0Oet+aDwE3U3EBj0M/Il+K9d2xdQVXw5U87kXTkKPxU1wEwKKC+0kf/?=
 =?us-ascii?Q?8c3hiDxIASF6D1dVIW9q2S3JCNwIWUAG5FgfnFpUFtem7N78FFqs9eV91SUj?=
 =?us-ascii?Q?qe2qQommBCL4LhTyRGwIj0GCUggOPFw+M0ShKRNHjUJV6n+7ZL2WlUc0GuXZ?=
 =?us-ascii?Q?24lNZzZSLyT9P14eRzDu59nubrSABg0ovih3Fl1XN8LCTI2Io5a57FXWNoos?=
 =?us-ascii?Q?Nqxthwu2vYjQa2TU8i1yorZR0oLSq1GJSm6oneCgNf9OQDl9IdPM1aOs8uLr?=
 =?us-ascii?Q?qz/1rHiLLoWAaC+nq78N90L0Ovmg3uEDXIgfqr9E4vFi18IgH/izudAskFHh?=
 =?us-ascii?Q?8ioG5xfycgbfu7pNC2fiZFsr9tKXRdxEkLwktbXyZQWgBQMsVU2YSB3/qF59?=
 =?us-ascii?Q?ytjPa3h8IvqmVx523KS1nSfA/9lHxs5voVfRDXyhtZCV77nNNS20rziKxt+1?=
 =?us-ascii?Q?lEo1Yf+0R8+pS63AnZTykDYxwtzA+0ut6YZ6hea1LQJ7FJYBP5GStDhoeQR/?=
 =?us-ascii?Q?7JwtobROPxU2ABI5Ax3E+YzipX11kCEES95t73zN/iM6Sdj0RBxzLPasYMC/?=
 =?us-ascii?Q?U6D0EHhr6d4xpB8DTrFWfDghRPvqS3sJnl0GBXdE74hLIZXEk1zn9v6FcGEh?=
 =?us-ascii?Q?PeuI9uSPi2T84PzwYHKS9Qihr52RrIRklRFze8pegFBCP9Mh8QSuVMQdyPp0?=
 =?us-ascii?Q?yrxzf1IKbP6Hhve5rWgRWddLJfBb/rYhDeU+8hc4gziE2W0F9lK48s/ROHST?=
 =?us-ascii?Q?rbACpuaXh9hctht1qm03f9XszRLgVA5TXX4/umCdk2SMYcj7Q5c+bPOmgaGN?=
 =?us-ascii?Q?866myEhNtApiqnUzAjXdUwbJfNZtMdRTvWMY/60hKXyrEeIjQ9M8Lf5Fc7JY?=
 =?us-ascii?Q?B+vnudlp8MTqJoXHJfohVslKAKOIjnrRmVB1gpWY3nFxZrmGALmIeEE5I5rS?=
 =?us-ascii?Q?otrp9t/dz5hVTDH5yPFGjvOw/f40YOzLl1eYBO2HDd331Yjcv695f/1FWfwC?=
 =?us-ascii?Q?ok3PIrRRXITOvZ7a5dXSuAV45tvgD5r6RZdCM77Nj2j4aUChA2qDLNAWyVf8?=
 =?us-ascii?Q?CkFa4dZ6s3F/2MLtMg4DCJFLuOHaTLFZw05AnPEydqNquHmCQ3gon+lrjMcG?=
 =?us-ascii?Q?yHP2X3I931pXJ2C7vWznYSjpvgCg7IMsQjbHhi3mBzFVDpncgPw0o+l70fWK?=
 =?us-ascii?Q?Bv0EcgtgzahkY/rZfE0O81pOW2V/1WfwY0ia9Jyuf8+/lToHOOo+Op6QvHDS?=
 =?us-ascii?Q?Ymmitd0nYxVCcrYA+l3r94DIDPrcrRLQTj2SSVYtBaKkNKZXL8Y3+/0jWynU?=
 =?us-ascii?Q?Rzgv8mUnOYLeD1xNLNLXwVnj37nZ+YLGl5e2mT4rsv5u+y1moydOmByJxaTg?=
 =?us-ascii?Q?dHTyRyCLR1/dU3TF8et035A4Pc91LP8iIpXqXxHPIRjv0HD66Zk6W2+YnSdc?=
 =?us-ascii?Q?O1vFpfAEw9DjT06sUYLvKB4g1ix6KwMAFhVP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6081.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lP8k2bJ6Ol+1n0OtPkkMEraVFIC+nqyWNY5aIwuZiQhiv9iwdgGYvEyrQlJp?=
 =?us-ascii?Q?1pOo8MAJmXNghnCdpca+vcJBmvKpFlbmPCZIc0tN7Rt8K39pMA/KkOhFJag3?=
 =?us-ascii?Q?hwlzPxlo+6bMtXlmnz4d7lKJ7mX4deRmre4RNpdSsF8kbBl+BXkLIzOtAqQ4?=
 =?us-ascii?Q?75HXbtXwsf0n4wuqHkZ+W+FMde1RPs5bvTzyvo/6XDLEccV6yxbJgKFhAAed?=
 =?us-ascii?Q?FcsHtBzvUZU5vOCFDWa6WXonwFZqcil2duRjIbW1wAfnapUM8bxKy8U9Fo98?=
 =?us-ascii?Q?uE8+Y/OX6LwAfYFRjacV93KNl+dfmNXo78yN1otPN3hwf13WWhWuxtvhDBVD?=
 =?us-ascii?Q?WtgwpuhKzHmH3ZWTlxTUmPIZy7C/EJCnM65U97hpcYZQLCUT+ICtqzmO3RYh?=
 =?us-ascii?Q?uvzmXOOLmxYu9kq3HBvaXNsQLZ6vLacX/wQ2ccOJH1SLHtgyOmA3VEpNg03F?=
 =?us-ascii?Q?5rK6YQZl8e8DukMJgh7XbYY0g/YDjJPWGzkxYvEFzQW9V43nPzbT0aNVwvB+?=
 =?us-ascii?Q?kPz6roRuY9BcR5tQ4wKoIf/j18yTFC3Y3GDub+aM3AshXWVtgnc4OdZWxYnS?=
 =?us-ascii?Q?Vt1/9cHslog3JFy4I/1vISt91JDVgDISaYnu+j86DQQbflP9OY+wvVn8T2BH?=
 =?us-ascii?Q?NUTV03hgVC8KIuwtoFNbzjDs9cvJ2MUONWCu7Z4lqFXVcdfZTECAr60BKiR3?=
 =?us-ascii?Q?vJmq5eX9I5pFd/dvtS39OgwPrz8PSdPPGincfEv+ne01oiErpdCS0f146Coc?=
 =?us-ascii?Q?P85st1sek1MDWkjL1cjYJxCW+BBuUeRyIqG7bESHhWtxG4fDcBfQUDOVfTjQ?=
 =?us-ascii?Q?NR2qwOEE4y9k0fch259rieYLc50082H1i8fAunPbpE5xh0j8f2ogtUsfaLSs?=
 =?us-ascii?Q?JSx3ATKGouSKJgpR43kUeNu7CgR04XzxLFp0fdFEpsqYAdVR9cTHI9+7UdCw?=
 =?us-ascii?Q?NaNokWDaPg65+WH7yTk6LYkudtfBBg++4OvvEjCJDOzP0BRsggZe1jeUsi4f?=
 =?us-ascii?Q?PmlJ8m9lOKYvbLWj2ADczVdtQhfYiNfpScCDymi6q9TfFH2MCsiAA52p7TML?=
 =?us-ascii?Q?uf45kORMivcDeRWFpovRVJAZ126qB+sXTxi04MsRxvQ6XHQ0ng+pcv47Vdtg?=
 =?us-ascii?Q?owPfZGaMh+E0SbEbvnq2yEJHwr26FS9YYNlquQcNphnsbJJHg8Odbrm6g49d?=
 =?us-ascii?Q?x4xn9Na+h7jJ3zY1Hj6Ph+dLyU0DaPOu35nJDW3le8YF0eF4pigd0yCeB0o0?=
 =?us-ascii?Q?m/AJtvBxdh9PeUX1qhdmAQzZ/xmZzH025JAdVpUbLI2E029M0uyzEtW+7vCY?=
 =?us-ascii?Q?+1pCjcOjTZCp4J5PuZbjSQVH9MVco7kmVzHXRXzqatyAuKhaGkcb35hVbvkM?=
 =?us-ascii?Q?K9ViHiK+/jCAg33Nc4u2Nvj/Y6YB/xi+49ZyNWgdWqgi6QjjB9dQcmjIlHlC?=
 =?us-ascii?Q?Y+DWcLjtZXikaRsuOFCXwUGOFH5IYdW8INae3UUssCuShAKyJHV7wOiZXgAW?=
 =?us-ascii?Q?go7eCuihGdynFLKIKCqKCioxMGxmIRVs0KdRHZdXaSfGjN34RYhlXIYBOfGO?=
 =?us-ascii?Q?V234zxKQz426HU2pnVF0J5WUb1EBP6iUetJH1gFPqED1fF3i7LX+i+HDCOF2?=
 =?us-ascii?Q?CL7OcyJ++yeGkKY0Xnbfwu5iUNd0/44TWm5wCv9QkUU7vg4ntwB78MH57Vm4?=
 =?us-ascii?Q?2RERGZH1PKkPnA793R9JmvPL/hrX9ANCpJeB9OevISbg23At?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6081.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f95c63-1d2c-4be8-013f-08de4f46add8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 06:16:51.5787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNeGZbbfF1v8XZozg+Wt5fE+hh8FKyac3hHhpJIEPydf+nrw15bfE48Or8Lzn3uCUzdz8Zv+RWBo6rxlxSIlIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, January 8, 2026 10:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v3 24/24] drm/amd/pm: Use message control for debug mailbox

Migrate existing debug message mechanism so that it uses debug message call=
backs in message control block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 ----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 16 ++++++++++------  .../d=
rm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 17 +++++++----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 19 ++++++++-----------
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 84b50820a613..3efd5cca3d09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -755,10 +755,6 @@ struct smu_context {

        struct firmware pptable_firmware;

-       u32 debug_param_reg;
-       u32 debug_msg_reg;
-       u32 debug_resp_reg;
-
        struct delayed_work             swctf_delayed_work;

        /* data structures for wbrf feature support */ diff --git a/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu1=
3/smu_v13_0.c
index 34ff4c35baff..51f96fdcec24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2366,6 +2366,7 @@ void smu_v13_0_init_msg_ctl(struct smu_context *smu,
        ctl->ops =3D &smu_msg_v1_ops;
        ctl->default_timeout =3D adev->usec_timeout * 20;
        ctl->message_map =3D message_map;
+       ctl->flags =3D 0;
 }

 int smu_v13_0_mode1_reset(struct smu_context *smu) diff --git a/drivers/gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/s=
mu13/smu_v13_0_0_ppt.c
index 37941b6c2831..ce52b616b935 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2882,13 +2882,18 @@ static int smu_v13_0_0_enable_gfx_features(struct s=
mu_context *smu)
                return -EOPNOTSUPP;
 }

-static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)
+static void smu_v13_0_0_init_msg_ctl(struct smu_context *smu)
 {
        struct amdgpu_device *adev =3D smu->adev;
+       struct smu_msg_ctl *ctl =3D &smu->msg_ctl;

-       smu->debug_param_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_=
53);
-       smu->debug_msg_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_75=
);
-       smu->debug_resp_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_5=
4);
+       smu_v13_0_init_msg_ctl(smu, smu_v13_0_0_message_map);
+
+       /* Set up debug mailbox registers */
+       ctl->config.debug_param_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_=
C2PMSG_53);
+       ctl->config.debug_msg_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2=
PMSG_75);
+       ctl->config.debug_resp_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C=
2PMSG_54);
+       ctl->flags |=3D SMU_MSG_CTL_DEBUG_MAILBOX;
 }

 static int smu_v13_0_0_smu_send_bad_mem_page_num(struct smu_context *smu, =
@@ -3216,8 +3221,7 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *sm=
u)
        smu->pwr_src_map =3D smu_v13_0_0_pwr_src_map;
        smu->workload_map =3D smu_v13_0_0_workload_map;
        smu->smc_driver_if_version =3D SMU13_0_0_DRIVER_IF_VERSION;
-       smu_v13_0_0_set_smu_mailbox_registers(smu);
-       smu_v13_0_init_msg_ctl(smu, smu_v13_0_0_message_map);
+       smu_v13_0_0_init_msg_ctl(smu);

        if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
                IP_VERSION(13, 0, 10) &&
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e414dfd6f644..03c26d8248a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2107,15 +2107,6 @@ static int smu_v14_0_2_enable_gfx_features(struct sm=
u_context *smu)
                return -EOPNOTSUPP;
 }

-static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)=
 -{
-       struct amdgpu_device *adev =3D smu->adev;
-
-       smu->debug_param_reg =3D SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG=
_53);
-       smu->debug_msg_reg =3D SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_7=
5);
-       smu->debug_resp_reg =3D SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_=
54);
-}
-
 static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev; @@ -2130,6 +2121,13 @@ st=
atic void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
        ctl->ops =3D &smu_msg_v1_ops;
        ctl->default_timeout =3D adev->usec_timeout * 20;
        ctl->message_map =3D smu_v14_0_2_message_map;
+       ctl->flags =3D 0;
+
+       /* Set up debug mailbox registers */
+       ctl->config.debug_param_reg =3D SOC15_REG_OFFSET(MP1, 0, regMP1_SMN=
_C2PMSG_53);
+       ctl->config.debug_msg_reg =3D SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C=
2PMSG_75);
+       ctl->config.debug_resp_reg =3D SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_=
C2PMSG_54);
+       ctl->flags |=3D SMU_MSG_CTL_DEBUG_MAILBOX;
 }

 static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu, @@ -28=
76,6 +2874,5 @@ void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
        smu->table_map =3D smu_v14_0_2_table_map;
        smu->pwr_src_map =3D smu_v14_0_2_pwr_src_map;
        smu->workload_map =3D smu_v14_0_2_workload_map;
-       smu_v14_0_2_set_smu_mailbox_registers(smu);
        smu_v14_0_2_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index f639d3636d30..5b1f059105d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -102,17 +102,14 @@ static int smu_msg_v1_send_debug_msg(struct smu_msg_c=
tl *ctl, u32 msg, u32 param
        return 0;
 }

-static int __smu_cmn_send_debug_msg(struct smu_context *smu,
-                              u32 msg,
-                              u32 param)
+static int __smu_cmn_send_debug_msg(struct smu_msg_ctl *ctl,
+                                   u32 msg,
+                                   u32 param)
 {
-       struct amdgpu_device *adev =3D smu->adev;
-
-       WREG32(smu->debug_param_reg, param);
-       WREG32(smu->debug_msg_reg, msg);
-       WREG32(smu->debug_resp_reg, 0);
+       if (!ctl->ops || !ctl->ops->send_debug_msg)
+               return -EOPNOTSUPP;

-       return 0;
+       return ctl->ops->send_debug_msg(ctl, msg, param);
 }

 /**
@@ -199,13 +196,13 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,  in=
t smu_cmn_send_debug_smc_msg(struct smu_context *smu,
                         uint32_t msg)
 {
-       return __smu_cmn_send_debug_msg(smu, msg, 0);
+       return __smu_cmn_send_debug_msg(&smu->msg_ctl, msg, 0);
 }

 int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
                         uint32_t msg, uint32_t param)
 {
-       return __smu_cmn_send_debug_msg(smu, msg, param);
+       return __smu_cmn_send_debug_msg(&smu->msg_ctl, msg, param);
 }

 static int smu_msg_v1_decode_response(u32 resp)
--
2.49.0

