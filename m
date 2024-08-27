Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A020DC54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 18:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FEC910E403;
	Tue, 27 Aug 2024 18:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gqX5g/eJ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803FE10E403
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 18:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsnazL36y2DwT6JOTAO2VOeYvnraP7JoSaiQ7ui/F9oJFytG23VeTryfbJkXVqjvjRVlESrtkPl5FcrhRlVqL5LcFeHkjUDOM3A6iYnGbFvR+HIneltLyVAsJxlEuerfn+asuttc94by3kWMUrSfn5hKj08rfmE/tGdOlkqerhQA8taYDxFVNcSRmNCeTQ6gKjg8FxlBYIpGp5rpyCdOTAZa+Ky+iFTRlQCMwI386q9k9tZ9ldkeS+PRt/uJbROhfEtQxDVUinorzAeEXns4jZCcWpn4xpoxmahEw6nnDm3GDgXZhV6/7lf4WoyRb1a2nMgqUPKk5K4T1YsvmYrnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUL64wTde1J8/1sjme3M4Yj3qjbQofUmrrA0LFaima0=;
 b=v2uyR58aBG3+stmfPq5FWvmGBFyALJ2BDcyw4xx7D5qJ4WiwSR5PW4OwoR4n+OYFVHiUzi9RlVLEObIxAHW/ue7Qpv1zDQDynO6T9ShJeftzSK5OoWDy0TxPY9o2vjIbpX0px2R1jddyc03zP5QcE82uE0D3rC7CYC6ECtrZGP1dxAztKmem0puvKOPWak0pvSSOBvZjlaPeaoZtCM9wQpYkQEBcw/94qZRZ3t68QG/3eG1yw3dn6LuRkQY0xYvmF2PGfKLpbd1pKaIXaTJJLGyaCtiMWXZ3d9K4goZKaubPL6fqSlobC4QvVfeJSf52NMT0xb5m+i/0c5LVi5+wOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUL64wTde1J8/1sjme3M4Yj3qjbQofUmrrA0LFaima0=;
 b=gqX5g/eJg5jvClNL7HTzMU+LkQpCpMjZsnJ9+U1a3spQkT9VA6zXObseNZ190LXsXJgQk+vsAbdQ0smZUqqG+y3HapfO7PhFDCySIq0uY3QC7sbYIqmsz6Ehavo+ZMgFPXYb/SdQTi02RInVZEfwfPwpvcQ8fHGg0FXITlh2JY8=
Received: from IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 18:53:02 +0000
Received: from IA1PR12MB6305.namprd12.prod.outlook.com
 ([fe80::6787:bd0d:885b:5a83]) by IA1PR12MB6305.namprd12.prod.outlook.com
 ([fe80::6787:bd0d:885b:5a83%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 18:53:02 +0000
From: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
To: "Belanger, David" <David.Belanger@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Add cache line size info
Thread-Topic: [PATCH] drm/amdkfd: Add cache line size info
Thread-Index: AQHa9bhu8BZ0Ufn/8EaJrZlQwFEQ2LI7eOtD
Date: Tue, 27 Aug 2024 18:53:02 +0000
Message-ID: <IA1PR12MB63054CD01BD8566177678D92FB942@IA1PR12MB6305.namprd12.prod.outlook.com>
References: <20240823235835.2190295-1-david.belanger@amd.com>
In-Reply-To: <20240823235835.2190295-1-david.belanger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-27T18:53:01.719Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6305:EE_|DS0PR12MB8272:EE_
x-ms-office365-filtering-correlation-id: f771eac1-1473-4c48-9fdf-08dcc6c97a87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yBlOeLUT6J++GAaIa1XHm+gjWWJHZMppQMKp04/XdP/iwBYM/VVqScq3F4oB?=
 =?us-ascii?Q?3IkNb0GadO28A9OROsmZpAjwOuYiVf+A/lsEZswJgxSEj11agS8SYay1nmUh?=
 =?us-ascii?Q?2L7TrPjw2ktd/wSEG1UYWhTqAuDiFOkuoYxpFvXVxZFcf89wn5nFfMmtm/q8?=
 =?us-ascii?Q?LsMI4CRFWCcethO4mkp7ekSFU6kix3d0FC8wBUgjYkUVriwbgCusOP8SVcls?=
 =?us-ascii?Q?VZ4UbgIvh2hq1uajbuT7l5YU4uG1VnjACHC9i7Q/0av0rtnLf9YysMawBU9B?=
 =?us-ascii?Q?nFlOxZoTG4ztHpTqEF+vl1H0uB0F86CLVDZYN8uzE6CerO9Y/rBK70Nh22Ul?=
 =?us-ascii?Q?HKQLweV4oGkA5NuHTAJkRyieA3Z3WjJn+dpXIf32J/V1pZLd8NgTiB0+s6Fl?=
 =?us-ascii?Q?hHsbBxPW6eB5l5gavyLp0fVUht/n8KoTK51xlaypphBJ7troeZZ8itmCmBzo?=
 =?us-ascii?Q?2iEUfof4XShM3Fdi53ekpeh2fl7r4xKtskwklsQkZHD20fTUpAbEDgk/Kqaj?=
 =?us-ascii?Q?koW3U+mdIgla4cKhSpiA5ze4SZUBZP2bkpwO2C+CnY2KuaeZHxt/F8xMYtST?=
 =?us-ascii?Q?37iwgvjweKBl4922mP9cMlZ09J0C++Q9eLya3xqFQ7TEdCI/0UHCl5Al2gHU?=
 =?us-ascii?Q?Cor61K/JgoP9EsZ6/lbKoVuGslUBUhQv7bH3XJoLSPJdCvuVs7VN+2/SmAx3?=
 =?us-ascii?Q?qDGKJS5v8k97VHVnoCA9MXhUvizHuwUHyRtFnShABJ0447rFvlqTv9v8FgLE?=
 =?us-ascii?Q?NPAKRI1h21jFlr5dUqpiKRmSoFmiUHF5/aZ332M+TWNX70ilP+cJdoTpa+Pg?=
 =?us-ascii?Q?mXoT5eLIkgaTwGWMmUh0j4kVp598Mxl1XzGAqs++joWoHFAwfnlP94/sUT+G?=
 =?us-ascii?Q?ReeK9DWsXRSP0cGEvqrO9UXZVSHj4TtclZmF/RI+LuZzw3OeL3DYS32QY2X0?=
 =?us-ascii?Q?+hEMQWzBLxv9k4i8jHyLuQcdqBpS1JmZ3vWTuiLKdwUVkTqwWPQjAuwdvVK7?=
 =?us-ascii?Q?CGVtJlLWKwx8+BJ5yg3pOfSZHKeZzj1V2YPLpFXzz5v6Kk3Uk2kqb1HJO3jj?=
 =?us-ascii?Q?/2hNulxVEIh28l1ZgRXg0ksf3LN1ZaapvIGhvoi07rckc8i/xG9Fs9iQ2B21?=
 =?us-ascii?Q?fjJ9L9D7zVBrE9pQ2rZCwcuoznu7R8ciW587fldi2RlvGyMGze7oLyH+X2d7?=
 =?us-ascii?Q?R0fXcJKLlEBD/Pb/vmWcHAlaeVsDWD5BKWZR+ncMpfH6rdyIH1iFwIUpJCMw?=
 =?us-ascii?Q?RIlr2Uk2RMColPtWvgUtbiSHkXYssEcLKQs+Be9ZzFcI3TzaQWfYQVokVff9?=
 =?us-ascii?Q?fbQo8ASkIQ0QvMKg6MkfcAWEN5agNYhh+k8OkUeRNdRXhvaEqLIuNQ/M88BF?=
 =?us-ascii?Q?LAYrVNsnuIhCfYIHU2L3tAZn2xFbDR6bLWSGb8SqD2gTTDw33A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6305.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MW0jws6+pbHWY04kAWMRgf0od5K4z0K2HwejLrFoHkMCg/9MZMbuQUK9gcPM?=
 =?us-ascii?Q?l2D/wZx7+MyFbrC9+YlxUdVKgWDGqMq6f3oMdDweXNN4IJfh22ekDGTCb2uY?=
 =?us-ascii?Q?c0s5BACG6WfH+Pr1FmMNcIWI6FMtRI4ifEi3viS0x/nqTcj+aYOhEeJI9tdv?=
 =?us-ascii?Q?bN/IeESSfh/Ywpfq/ZyRp0qV5ASRg/CzuTgYrgPqGpSuTMSSQ68UDzE/lQaA?=
 =?us-ascii?Q?tsMvYxajQ9SESGAf/bYrZZof5e70aSpuhGIGmNgsUl9zpQq0u/H4/cFLfyNT?=
 =?us-ascii?Q?qhUROb0lC6seMZOFpcoK6v8NGb4AT5G+SeKt/+9Njs8H8tQNX6Hk9gLgJDte?=
 =?us-ascii?Q?MOhkHNf71a7EXDjzm4m9nHjPFNADPs8cu5h8HiT5xwOVd6mCo2MoN8uRhF4A?=
 =?us-ascii?Q?JsaYGEz2CLpduXP5LNf9fJAkZbGe3MecGF9x20BqxVQLSXXtXnQAImtoe876?=
 =?us-ascii?Q?d7A3qVl7fGAhCIq22+oRPP0gsWhTZhfQNHQ+qhbGfCLoRsk+QUCmzkNi1a2l?=
 =?us-ascii?Q?Y+iB5tLt9hA+V+7oqdmV+KZut11PKKN5ZuBLeDFrx9o0INaz2avubXgcYGpd?=
 =?us-ascii?Q?u/rT6+gN98HTrFWVtM8S8JCIajV1rePqqfVAvIeeNX8C3rJ1crTRJYiIe3+H?=
 =?us-ascii?Q?XIUW/3gaf/o1vvVkm9qPL5jp6qU+0xAxvuO+1pOVW1a/MIfdxp1JR8HZU/IZ?=
 =?us-ascii?Q?VHT4+rH4cnID61o9Qtdpu0LDR0LLWkSxbeEvvrd24wvNRmukAGTfFN0mfwkF?=
 =?us-ascii?Q?ES5K3wf85gqFWVL8WYuRWR5LKpalV5wyhqHzDC++EbmNxiwLg+DoE60+u7N1?=
 =?us-ascii?Q?VsICDv1sTP6l2nEoU8BudvgqNz7Nwq6husPmyhYMzOTvx2VaRZIegOGstcQD?=
 =?us-ascii?Q?tWAgJcbnJHQZBbwJS/XQXQ6/hY/KURjsnMYWzBVefyxNjMfJrupmgJwWyw64?=
 =?us-ascii?Q?PBBJhWzASNGZiO7XVyEoKmUtSsjlBx0rOhflsAucQe25yeyt+fd8XdsCuxwU?=
 =?us-ascii?Q?l3xf0nTB/WR4j/K+oZovW9MFm/kGKJp+3p50YDDde0eWMZLv51tNeSwiJ4dE?=
 =?us-ascii?Q?4hKggsL5ikTncG3G3mk1C/pLgFF9Bz+pa1rThXgVrQ+D4ouQ1MUinRH+CPBI?=
 =?us-ascii?Q?9lWMd/ZqNGCseOxGqr6lZfZ6Bctqr3ZbqolO9eGnK+j9QWfu5q1tth9EmoO7?=
 =?us-ascii?Q?TVk8vsSpeiOgovRCNCjA9OWKrglhvGU8r2zuZCn5lfFJm+fXN+AyJ6rUzXHs?=
 =?us-ascii?Q?EgJ6S87KmrsD1XmJ0zu67Se3OBLd+ut1BVB5QMyL4IOqvmT7cwaZJV2wIxXd?=
 =?us-ascii?Q?NfOvorXxHtIuhWA7n1OLggW8t/w1R2+huvbpoc83PiDQT0Snigz2vGBkpXQm?=
 =?us-ascii?Q?5GXvN9GE+sqWlaLrB+8QqCXKbrUiQsOzA+V0CPn91XnPKlZZksSUuKsXdnBH?=
 =?us-ascii?Q?UUhWosgH8Y2xSWMYpRmD6cc06Jju+JbFwLGJWQHGATwH9U3rsOesdQ14/3IQ?=
 =?us-ascii?Q?+IvCKc7E2opUP/oPe0gripJabuvTmxZeDf3a34k4nm0yds604nPBvDWpifWY?=
 =?us-ascii?Q?y/hPN/qGEmXkPFD2gWA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB63054CD01BD8566177678D92FB942IA1PR12MB6305namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f771eac1-1473-4c48-9fdf-08dcc6c97a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 18:53:02.5970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I09I/y7tDht2jfoQYby6xcBPBtgqe54F51Ce4mdok9LPFd0zacCDdaF8JFoKvNEI6qsyit8+a7ZNl3YAmyvTpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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

--_000_IA1PR12MB63054CD01BD8566177678D92FB942IA1PR12MB6305namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>

Regards,

-Sreekant


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of David Be=
langer <david.belanger@amd.com>
Sent: Friday, August 23, 2024 7:58 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Belanger, David <David.Belanger@amd.com>
Subject: [PATCH] drm/amdkfd: Add cache line size info

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Populate cache line size info in topology based on information from IP
discovery table.

Signed-off-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index cd7b81b7b939..48caecf7e72e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1434,7 +1434,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,
                pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
                                        CRAT_CACHE_FLAGS_DATA_CACHE |
                                        CRAT_CACHE_FLAGS_SIMD_CACHE);
-               pcache_info[0].num_cu_shared =3D adev->gfx.config.gc_num_tc=
p_per_wpg / 2;
+               pcache_info[i].num_cu_shared =3D adev->gfx.config.gc_num_tc=
p_per_wpg / 2;
+               pcache_info[i].cache_line_size =3D adev->gfx.config.gc_tcp_=
cache_line_size;
                i++;
        }
        /* Scalar L1 Instruction Cache per SQC */
@@ -1446,6 +1447,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,
                                        CRAT_CACHE_FLAGS_INST_CACHE |
                                        CRAT_CACHE_FLAGS_SIMD_CACHE);
                pcache_info[i].num_cu_shared =3D adev->gfx.config.gc_num_sq=
c_per_wgp * 2;
+               pcache_info[i].cache_line_size =3D adev->gfx.config.gc_inst=
ruction_cache_line_size;
                i++;
        }
        /* Scalar L1 Data Cache per SQC */
@@ -1456,6 +1458,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,
                                        CRAT_CACHE_FLAGS_DATA_CACHE |
                                        CRAT_CACHE_FLAGS_SIMD_CACHE);
                pcache_info[i].num_cu_shared =3D adev->gfx.config.gc_num_sq=
c_per_wgp * 2;
+               pcache_info[i].cache_line_size =3D adev->gfx.config.gc_scal=
ar_data_cache_line_size;
                i++;
        }
        /* GL1 Data Cache per SA */
@@ -1468,6 +1471,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,
                                        CRAT_CACHE_FLAGS_DATA_CACHE |
                                        CRAT_CACHE_FLAGS_SIMD_CACHE);
                pcache_info[i].num_cu_shared =3D adev->gfx.config.max_cu_pe=
r_sh;
+               pcache_info[i].cache_line_size =3D 0;
                i++;
        }
        /* L2 Data Cache per GPU (Total Tex Cache) */
@@ -1478,6 +1482,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,
                                        CRAT_CACHE_FLAGS_DATA_CACHE |
                                        CRAT_CACHE_FLAGS_SIMD_CACHE);
                pcache_info[i].num_cu_shared =3D adev->gfx.config.max_cu_pe=
r_sh;
+               pcache_info[i].cache_line_size =3D adev->gfx.config.gc_tcc_=
cache_line_size;
                i++;
        }
        /* L3 Data Cache per GPU */
@@ -1488,6 +1493,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,
                                        CRAT_CACHE_FLAGS_DATA_CACHE |
                                        CRAT_CACHE_FLAGS_SIMD_CACHE);
                pcache_info[i].num_cu_shared =3D adev->gfx.config.max_cu_pe=
r_sh;
+               pcache_info[i].cache_line_size =3D 0;
                i++;
        }
        return i;
--
2.41.0


--_000_IA1PR12MB63054CD01BD8566177678D92FB942IA1PR12MB6305namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Tahoma, Geneva, sans-se=
rif; font-size: 10pt; color: rgb(0, 0, 0);">
Reviewed-by: Sreekant Somasekharan &lt;Sreekant.Somasekharan@amd.com&gt;</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Tahoma, Geneva, sans-se=
rif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" style=3D"color: inherit;">
<div style=3D"background-color: rgb(255, 255, 255); font-family: Tahoma, Ge=
neva, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"background-color: rgb(255, 255, 255); font-family: Tahoma, Ge=
neva, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"background-color: rgb(255, 255, 255); font-family: Tahoma, Ge=
neva, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
-Sreekant</div>
<div style=3D"margin: 0px 0in 0.0001333px; font-family: Calibri, sans-serif=
; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of David Belanger &lt;david.bela=
nger@amd.com&gt;<br>
<b>Sent:</b> Friday, August 23, 2024 7:58 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Belanger, David &lt;David.Belanger@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Add cache line size info</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Caution: This message originated from an External =
Source. Use proper caution when opening attachments, clicking links, or res=
ponding.<br>
<br>
<br>
Populate cache line size info in topology based on information from IP<br>
discovery table.<br>
<br>
Signed-off-by: David Belanger &lt;david.belanger@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 8 +++++++-<br>
&nbsp;1 file changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c<br>
index cd7b81b7b939..48caecf7e72e 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
@@ -1434,7 +1434,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_DATA_CACHE |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_SIMD_CACHE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcache_info[0].num_cu_shared =3D adev-&gt;gfx.config.gc_num_tcp_=
per_wpg / 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcache_info[i].num_cu_shared =3D adev-&gt;gfx.config.gc_num_tcp_=
per_wpg / 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcache_info[i].cache_line_size =3D adev-&gt;gfx.config.gc_tcp_ca=
che_line_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Scalar L1 Instruction Cache p=
er SQC */<br>
@@ -1446,6 +1447,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_INST_CACHE |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_SIMD_CACHE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcache_info[i].num_cu_shared =3D adev-&gt;gfx.config.gc_num=
_sqc_per_wgp * 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcache_info[i].cache_line_size =3D adev-&gt;gfx.config.gc_instru=
ction_cache_line_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Scalar L1 Data Cache per SQC =
*/<br>
@@ -1456,6 +1458,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_DATA_CACHE |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_SIMD_CACHE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcache_info[i].num_cu_shared =3D adev-&gt;gfx.config.gc_num=
_sqc_per_wgp * 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcache_info[i].cache_line_size =3D adev-&gt;gfx.config.gc_scalar=
_data_cache_line_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GL1 Data Cache per SA */<br>
@@ -1468,6 +1471,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_DATA_CACHE |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_SIMD_CACHE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcache_info[i].num_cu_shared =3D adev-&gt;gfx.config.max_cu=
_per_sh;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcache_info[i].cache_line_size =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* L2 Data Cache per GPU (Total =
Tex Cache) */<br>
@@ -1478,6 +1482,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_DATA_CACHE |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_SIMD_CACHE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcache_info[i].num_cu_shared =3D adev-&gt;gfx.config.max_cu=
_per_sh;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcache_info[i].cache_line_size =3D adev-&gt;gfx.config.gc_tcc_ca=
che_line_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* L3 Data Cache per GPU */<br>
@@ -1488,6 +1493,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(st=
ruct kfd_dev *kdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_DATA_CACHE |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CRAT_CACHE_FLAGS_SIMD_CACHE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcache_info[i].num_cu_shared =3D adev-&gt;gfx.config.max_cu=
_per_sh;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcache_info[i].cache_line_size =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return i;<br>
--<br>
2.41.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_IA1PR12MB63054CD01BD8566177678D92FB942IA1PR12MB6305namp_--
