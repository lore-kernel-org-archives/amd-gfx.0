Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB7ED1714F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 00:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F406E10E5CB;
	Tue, 22 Oct 2024 00:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vc7r8p8X";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83ED710E5CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 00:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP56qmuTi7a0pnlisbexgQLa9fbh7vLm2RctDM4VQvze1FQEsqz7Os+8dQ3YGYYV8JkkN4q3Xc2FRdekeXcgOFSgv2a+xKLnvDQXv5krGjxXxxE+8Vr/Yx6fuY2SABX4RFPK91Y5p1tr1PuNmzZKyz+vOLiOqQR08UZZa+FZYyN3st2ift/FW/MMtFkS/oM0tcbLMSsdzT2oQW9LGNLqTPciFrNh3QyU1BRhpWXfAW2pFLOH8vaSBO9+M4w/4kneZ9h6U28Wby4krQF0Uv40vbmje1Gi3YXyeghrcd8ggXa0LgBKjNAkivKHpR4fU90zAUDNW3JHjk64kUlf0DZVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmvijAoaqeHVZBi8gm6v4oJORhl0T3skzqprRkEllpA=;
 b=h/MY/FgGPI8fekGyhqQLxUk3XUs0jiT+4/9rIK37V9z1CnVRTJ4gmtc9+gly8BJjy8OdvVR0uuTnnNF7J/q4Q0IXHsCyL2Rw43mgW2r5iKyg88n5z0eccrPZg6/3P/7gYVzThIHntYCij3jakEy8B5J2j7hGZuaK5EnUA4bnW9sWM/YDUG+tlwZQY9Z16jvYvdpzscy0feK66z66UDT0GcvzvVhfYNoc0M2MULRzoA43ITpEOd9XtTYVKb+LXnHr6/hX88KeynHqHX21aU+NdOpIoehbGg8Ux+iJF8zXp8y7SsdQmh63br0FwSv0fF7uRkLXeyXk2l/KJqEWzb5zrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmvijAoaqeHVZBi8gm6v4oJORhl0T3skzqprRkEllpA=;
 b=Vc7r8p8Xu5O8Sx6H1YP3/exYZqNqh0C4dNLL5k06N5Uy7pk7/7jlTz7pZDq/WuXlGCbVvBoLo6n0Vw53uSjtZxnwOOfXbFiOLbSDOrS+HbjCV4NI0ZAxqeauDgMq6NqK7aEAbHvIpWg/R5/1wfCBL3l8TKam7XuuugWgkzdcxZI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 00:51:51 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 00:51:51 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1
Thread-Topic: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1
Thread-Index: AQHbIZLdakRLjRpPeESC02aLV+ROQrKRrkaAgABD9TA=
Date: Tue, 22 Oct 2024 00:51:51 +0000
Message-ID: <DM4PR12MB516537577F16430D69C219BA8E4C2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20241018192027.622300-1-alexander.deucher@amd.com>
 <BL1PR12MB514479BC04F9CE88390562A9F7432@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514479BC04F9CE88390562A9F7432@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-21T20:35:05.019Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|PH7PR12MB5734:EE_
x-ms-office365-filtering-correlation-id: 1b7ec45d-c5cb-4353-0155-08dcf233b78c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Z+DGW72z/1KJ6SbalGNDI0YEGuCkNNy+bmp0+IhNQXm3Wff4c76vEvHvYZ5a?=
 =?us-ascii?Q?kwjFDmRh3W0423JnWGzmgixd5pQ/PKS95oHEsZO/jTekkiiRR3RUNTeJl2md?=
 =?us-ascii?Q?C77xc57v2f53UqzyWqin7DM1nOMmD/XfSpIGztmAQE0X0ShEP8S9gZIGGbhn?=
 =?us-ascii?Q?/mmp/pn7oWyBvsi/cj267udgnqsVCrAPZr7KxKzV9MlX8uW7WlZgO3GxABgi?=
 =?us-ascii?Q?ujgsE8zTL8J4S9KYiWqvuHYPQ/wZXxvs3aT1tcplJ0ze/+AQ4ZJpQ68c9wPx?=
 =?us-ascii?Q?Vvxicop8O5+S5Jyux5koXIe5TGInQW+xrookq9EHDb8N/DOaertWOlBx7BCF?=
 =?us-ascii?Q?KxUgD3rrWxAdKCMlp4HSm7dcAiaFZlE9PlKLynEVElvM89iuC3doV/YAJye7?=
 =?us-ascii?Q?U+5bIAFkBT+gKkeMEzzyNMZFuZcLW7li4XB2cKOBZlyj8z4j3TzdULaDR3qs?=
 =?us-ascii?Q?2/uK2gmOLCnmzzO9EFwlesgdHtzXNUx36h0pMb5VzekA1vbt/2ol6bOs73XG?=
 =?us-ascii?Q?z3u7RJvZAl+vt4sCdj6I5JOtAV4/xcGe38CL0zTOVmb6JW0kZ1UNaLwHGzCj?=
 =?us-ascii?Q?n+xbauss9yYQndHODIHMovPNMHmb6roIjkSS+KGDDEj/okweysnen9S18CKj?=
 =?us-ascii?Q?JkDVf9d3+sd+mDV0Plw1RJMEpvtrN1gOvzy6Xb0uo3oKj87cDxCaBZ8bfHPK?=
 =?us-ascii?Q?wNTk4hWYZw+bInlwdcptaKuX6aL83UHc8el62ae6B8uraX8jxjVXunIIqSXy?=
 =?us-ascii?Q?Ffuu4ZYj5vw2JwuFQnyEx/WaNZITWYIAk2EmU9HROO1dHgIJQ+xQ/ZjwidAr?=
 =?us-ascii?Q?UwTAPgGeq1sNxZonoCUcjAvgonEMXVux1cuxUCysIKWCw+GRfaWDY0Qcdpps?=
 =?us-ascii?Q?4fV29+FpDwWRz6iRPx7MUqYMblsX9hVaPT/kULAS89o7ibtGiocD7JBgtkwX?=
 =?us-ascii?Q?3Oum09D3Run61m7ojFzTXJEkCC0Fti37B2IGH+YU75tdeD53tV5WAICOpfXE?=
 =?us-ascii?Q?/M9jmbhEJnVn0gDll4L27gP5zJ7tiE/pC2LSZY/pwOu/vTe/1rK4ZlgX8XbY?=
 =?us-ascii?Q?zqaEn+1XNmHP0hFZsJrbB8dcePV+MW00LdNAhY2jnHWu57Lzr8ZmmwJVUS2p?=
 =?us-ascii?Q?tD2W0CXsjQO9t3HaHnnKvWkleSKciqGp+dPhWGDHEn4N22RL6FYMz144yK4H?=
 =?us-ascii?Q?lu3ebOQRT3xCEZjEdX8iFryqCREcIK2tGOVqdS5Yc8o548PhwKQmKYR1RPQI?=
 =?us-ascii?Q?GG3jsbadyKwRqxLfccBxdLbCwUwD0yih3ewsRxF0frOOByCGXlrK9m/rl/YP?=
 =?us-ascii?Q?z7bCSa+FfE0ALjzUhkRWpxeNS3Z8ZtG095bdQylJqSxCJpiLUl439zeqkDt+?=
 =?us-ascii?Q?AenQsB0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DYGPiTTY4r2rQFb/6QILvwSBv5I3xgNtKNlt+iEpQ5foOOqebB41mWmBp7Ow?=
 =?us-ascii?Q?R9od6hlMw5OVWnnpU4ovp57AnHIINPGNzVUlzDzpYdj0/+B90LVYV1OplfH8?=
 =?us-ascii?Q?cC7ufZo6EJcIasurq8Flx+acA3xB+VsOgOygfMom8ocm1zE1sTHJqTDglCeA?=
 =?us-ascii?Q?ciZGpmw4WE39dKGy+O6VTRJnNqSuttCRQctL3Pr3DCjGJMhEYjNGTpjPhgzc?=
 =?us-ascii?Q?ZGSiomVFCf9b3HDKRlQwaotkzS1botCj3moYkOJY6s7PlUQF6t2oG3W06gKQ?=
 =?us-ascii?Q?wOWA+pfhUeaXGuJTYy4hP7Zs8lJKE5OELkQqsVNYk9MHwb+4nkj9FYvcbJ13?=
 =?us-ascii?Q?9icajosrQkU5PScFOLllup4W1lU9rTzaXaQLAGdx7wMndaFa0P3QA0Zz2J5h?=
 =?us-ascii?Q?WrNAiWghU9dMDIHh0lFlxyCplRr74JVZUiJBrQnZs59kWJYEGf7cNAa5AKiF?=
 =?us-ascii?Q?fSxhYKtsdeyYsCn/Mkf5hmRoZysBZhoKbi/os665Z3POnL0UTvSwAjIBhRPz?=
 =?us-ascii?Q?X36oEvX0Ouw3m4b9GjJWAMfgfevj+7l9Xv91XHvGD8JcmXP+f+YwvwHqFsgl?=
 =?us-ascii?Q?U8C9I9T4skmETroUmY/7X63iBcfozvwewEXFakbypb/imsWK0E9bYoDgX8jq?=
 =?us-ascii?Q?6AJYCLnEHUcCZbmS9zgwt5lhzw+fIkXGOP/kK0DaFXXBoCsDveabNLn69ldL?=
 =?us-ascii?Q?iv974eTE47W2wtAFuJYuPbl6UHj+9WO2ATcu8EmzxYiaoQi1x0LR/flD2i7r?=
 =?us-ascii?Q?SPwFR1bhHSdzLjDKXKWA0pUS2KPVXJ75MHSqTV6mBq9KOzuirsZzQJEDuO4S?=
 =?us-ascii?Q?uMMDkLFGLn1QjvPRNh0f3HAK97/8DJrCLhph762KBnIk8WUTQZ0rIVwhBdYW?=
 =?us-ascii?Q?9+X9zZ+CEmhKTgXMQaKyrqQAhG+zlHQvZfZTWrJyMxLviSY/6bE7DmLFxfd9?=
 =?us-ascii?Q?epvDdEmD26Ih1PWC+e0Zvpe8Qk3M4r478kXEHRCGm1QruXfuGITZVdTup4HA?=
 =?us-ascii?Q?6PJwP3NsG/0b42j409cy5KyY3guWUqLEV4tw6Lx7KBPBZfibIkf7JDEjsfGS?=
 =?us-ascii?Q?FrDIwoyM7FN89+42nwB984hdG9dyFCxSq2I4dSF+epAoK/+05wGNH1nMGWOW?=
 =?us-ascii?Q?n/4p7i+UMoJZB79Z2EFDCPxk3Jx0UE6Kc6be/9oeuGHpcFFcXI0MKMXqibBZ?=
 =?us-ascii?Q?tfGapFcIWRSa4zoDrPpiNwoMclyeZIotARCJOGOmXd+iv7wk4sY9PPSVnTq1?=
 =?us-ascii?Q?omMaDGGyrXsGVREfCyz+ajKqEoBx1ZH4uOMkg6+ADl07FDjoBbYPa1lyZJgz?=
 =?us-ascii?Q?4OI6YmBuofoyn2Sb56My1t0ZFzUYp9wmjJ8kJStSdX5WTsdM0TOV3OGeZEr8?=
 =?us-ascii?Q?HD4vIEXWbS9a1xsefZWjWlzZ3pDRDo9kU8QIFoWzK/joXug+vBhPWhAuHwOG?=
 =?us-ascii?Q?bfaNsvKEteyu73oQQMm6sY7FOeoOP0KRB3IdqjhVU9sDHFG1SOp3YZIGXDqs?=
 =?us-ascii?Q?h4NRD3ecw0K/CVL00im+DJxokW+UqAUA0pgQVbzaIo79UuyHa0qV2blxDpJz?=
 =?us-ascii?Q?eRQ4T3F9Sm4dYCi5MAc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB516537577F16430D69C219BA8E4C2DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7ec45d-c5cb-4353-0155-08dcf233b78c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 00:51:51.5811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9w+3UxufScCuceyjdDU13xopIw+Uc5lSfMh5lwiJ0iUA+FSBOCM9TOZ9Q/7Nv8rQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
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

--_000_DM4PR12MB516537577F16430D69C219BA8E4C2DM4PR12MB5165namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Alex,
I have found another problem with the current code based on the default wor=
kload setting to 3D fullscreen.
For example, the default workload is set to 3D fullscreen first, but in boo=
t, it's not applied yet.
Then a vcn ring test comes in, sets the workload mask to vcn workload + 3D =
fullscreen. After the setting,
Actually the workload mask is updated to vcn workload only. Then after the =
vcn ring test, the workload doesn't go
to 3D fullscreen workload. It goes to bootup workload(PP_SMC_POWER_PROFILE_=
BOOTUP_DEFAULT).
Let me try to fix it by today and get back to you.
For this patch itself, it's ok.
Reviewed-by: Kenneth Feng kenneth.feng@amd.com<mailto:kenneth.feng@amd.com>



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Tuesday, October 22, 2024 4:35 AM
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1


[AMD Official Use Only - AMD Internal Distribution Only]

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


[AMD Official Use Only - AMD Internal Distribution Only]

Ping?
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Friday, October 18, 2024 3:20 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1

It does not support fullscreen 3D.

Fixes: 336568de918e ("drm/amdgpu/swsmu: default to fullscreen 3D profile fo=
r dGPUs")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index accc96a03bd9..4b816c7e94fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1267,7 +1267,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)
         smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
         smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;

-       if (smu->is_apu)
+       if (smu->is_apu ||
+           (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1)=
))
                 smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_P=
OWER_PROFILE_BOOTUP_DEFAULT];
         else
                 smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_P=
OWER_PROFILE_FULLSCREEN3D];
--
2.46.2

--_000_DM4PR12MB516537577F16430D69C219BA8E4C2DM4PR12MB5165namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Hi Alex,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">I have found another problem with the current code ba=
sed on the default workload setting to 3D fullscreen.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">For example, the default workload is set to 3D fullsc=
reen first, but in boot, it&#8217;s not applied yet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Then a vcn ring test comes in, sets the workload mask=
 to vcn workload + 3D fullscreen. After the setting,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Actually the workload mask is updated to vcn workload=
 only. Then after the vcn ring test, the workload doesn&#8217;t go<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">to 3D fullscreen workload. It goes to bootup workload=
(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Let me try to fix it by today and get back to you.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">For this patch itself, it&#8217;s ok.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Reviewed-by: Kenneth Feng
<a href=3D"mailto:kenneth.feng@amd.com">kenneth.feng@amd.com</a><o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> amd-gfx &lt;amd-gfx-bounces@li=
sts.freedesktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Tuesday, October 22, 2024 4:35 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1<=
o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" align=3D"left" width=3D"100%" style=3D"width:100.0%">
<tbody>
<tr>
<td style=3D"background:#FFB900;padding:5.0pt 2.0pt 5.0pt 2.0pt"></td>
<td width=3D"100%" style=3D"width:100.0%;background:#FFF8E5;padding:5.0pt 4=
.0pt 5.0pt 12.0pt">
<div>
<p class=3D"MsoNormal" style=3D"mso-element:frame;mso-element-frame-hspace:=
2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-el=
ement-anchor-horizontal:column;mso-height-rule:exactly">
<b><span style=3D"color:#222222">Caution:</span></b><span style=3D"color:#2=
22222"> This message originated from an External Source. Use proper caution=
 when opening attachments, clicking links, or responding.
<o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Ping?<o:p></o:p></span><=
/p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Deuche=
r, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deu=
cher@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, October 18, 2024 3:20 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: handle default profile on GC 9.4.1</spa=
n> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">It does not support fullscreen 3D.<br>
<br>
Fixes: 336568de918e (&quot;drm/amdgpu/swsmu: default to fullscreen 3D profi=
le for dGPUs&quot;)<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index accc96a03bd9..4b816c7e94fe 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1267,7 +1267,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_prority[P=
P_SMC_POWER_PROFILE_COMPUTE] =3D 5;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_prority[P=
P_SMC_POWER_PROFILE_CUSTOM] =3D 6;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_mask =3D 1 &lt;&lt; smu-&gt;workload=
_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_mask =3D 1 &lt;&lt; smu-&gt;workload=
_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];<br>
-- <br>
2.46.2<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB516537577F16430D69C219BA8E4C2DM4PR12MB5165namp_--
