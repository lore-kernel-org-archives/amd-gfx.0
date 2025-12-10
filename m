Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41618D3C92B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 17:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66DA10E772;
	Wed, 10 Dec 2025 17:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZhTspwH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960EF10E772
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 17:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8oYHY1QGCp/i41M51vUKOqPecd+Hw4XBiqhfXANFVau7HslzefTiy0ETddCRnF6jYbIQzuernT95knZwiKI+/PTsAJ7UvPob/Nwhd96A+DanfxyFhmeOABP5yn/Py8pcKs6Yio6IxWDatgSOw6cUZ8lKOMUmVh24RY8Md4ofomD1WyUFBHNyu3qz/rlnzYZKP+pwFWGIFnsgoMeI/GoQ5maVGEAC72I3gfpHP2FHQhlG//em549YZa/mGbnaNEe8RWa7iYvCfrM3as/ESOicIFi2iaXw59AmpeuahWOL1yE03Ifa8QQHBP2Kyalzqb94VqjShnqJ1/vzeahy2ej7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKMigh2q6ZPU/qxayQRhWr/002X6uymza5PM5DNndIo=;
 b=vPkIy9eqBkV8JGLOcGPKBw8905qum18w43nctUV34wa+3ufN3Hr4tgyCHeyjgR+Vs2jbGozi8ltsA8QWHgM4CzXCE+j4BdxAcuJGTRIKYOO0o50BRlCyNKccefkuNjEe6yh8GhlK6ncGsMq8oDtW0SYV6fNDkRE/hL7CKiLx7UO3i17KgFHZDcSZV7WGMYThXkFfvEHiOOTPvr0brwjxLflED0U6TsUojF+G69KkvlQqxV8uoRlrUw6WlffrLgRxLd3rgRmF4ajHw5lWxzmPEVPyU1EbcrH9jGCJg0uM50W556f87+3Y/rYY9RYFQOj+ZwSPbrNYuMihAzwGL6t9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKMigh2q6ZPU/qxayQRhWr/002X6uymza5PM5DNndIo=;
 b=wZhTspwHkTUhr1YoGPObhpqwUdI5YlYKohEEMXFl1LFHSExbQRcPpcb6+0fqeJ+GNeMIVkb2Jw0ZcepV/IdZWTXKC0h8DKCqz++n50ODhOR3Wq6FPM14h/0/zh5jnhW9KCEIXRHmHtztFQC1ouDhwvMAxmGDd//dHlJ4DK5hEqw=
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 17:04:58 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%7]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 17:04:58 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, Matthew Brost
 <matthew.brost@intel.com>
Subject: Re: [PATCH] drm/amdgpu: fix a job->pasid access race in gpu recovery
Thread-Topic: [PATCH] drm/amdgpu: fix a job->pasid access race in gpu recovery
Thread-Index: AQHcafK4f9w6UF19iEyhJ1azIqFXdbUbGc6u
Date: Wed, 10 Dec 2025 17:04:58 +0000
Message-ID: <SJ0PR12MB708204C40ADC23BA42E4545097A0A@SJ0PR12MB7082.namprd12.prod.outlook.com>
References: <20251210163254.45210-1-alexander.deucher@amd.com>
In-Reply-To: <20251210163254.45210-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-10T17:03:15.5358389Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB7082:EE_|LV3PR12MB9412:EE_
x-ms-office365-filtering-correlation-id: 58c5d988-5e43-41fd-f5f9-08de380e3f9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6oaedty2YqwNz2o7NRFpwJW85ddKB1vQK/cez5orsNZsKdrXZTo92R2wkQpS?=
 =?us-ascii?Q?2qNz2rBMJaXsG7S/08quGtszpGdJA8Iu0jbG8BZ/usRQlIHFx43m7Lb5LXhS?=
 =?us-ascii?Q?tmXM4xZ8s1vfkXplgoSfpl6akj5LuBrljwdi61TG/aMgxXygTloh0IX68PLt?=
 =?us-ascii?Q?NJ8aI6Eu7s6gmjbEyYd5JAzBtfQEfUwYU0mqDe5Px6uf/HDRYj+4OACZgLKz?=
 =?us-ascii?Q?UW5Q9bFP01QdRHH6mh+E+U5P/nKRrXJ861WwABkidSv+e6sinO6Bcx8CwsUO?=
 =?us-ascii?Q?LqFp595FBJx1Hl/jYEzPnLp9A5ZfxE7T4O4bL/6Yk8VmoTKdOzICYTufThBp?=
 =?us-ascii?Q?cbhNeU6l2YzTJhgUre7/hkCdZgy1KAO4Q45LO2y62fBWb4uhqBw76W7d8a3+?=
 =?us-ascii?Q?bshfIV4PihCq+37sL14CUmDaJONInTOfz1jR0XziQO92jLIw5jkpLhV3t+ng?=
 =?us-ascii?Q?N5f4JuyEkT7e1FHrFRsq7JW5zmFO74+fIPRKB81UnQ1ApNwfFwiJwz3t/Mpi?=
 =?us-ascii?Q?2JtMlQlPInvP40qGf4RUgSeOCVKxkSH4jeFydu1Vi3WL63fmyf4x8Ez7EcqA?=
 =?us-ascii?Q?I9UKFOMaGFtQgP6ttu7zr7g8pegfR5OvtuQSwYhG9rMCk2I+hjYtpFY2a93t?=
 =?us-ascii?Q?wUbX5vCdUKLS7oHhqmtE/yssxtWuLLNrFZKxzTQG4U6z/opKg7TboLDnWI15?=
 =?us-ascii?Q?NKVWnCEK5kdrM3MDTgRI2KJoTeDtkZJfAYYFnKYV1N4fZMeCAwW3DRsQoR5x?=
 =?us-ascii?Q?IZxptgmICshgJucS9e+Sgx1fb1rdAYGof2eonCD5mE1i/6Wc2mCirpnSyBpV?=
 =?us-ascii?Q?3ZnjU83Y6qSV8aegeQqkpY/WWn8eAp3Z/443uT0aGmjf2KtLi+327i3F4AOF?=
 =?us-ascii?Q?bBnKly5GyjkD4qvBay//xONGgvFs1gKSDXIzrp+cbIIulOtg6qTRTfdqSWDE?=
 =?us-ascii?Q?syie/9VuI9ofjUz2swYBpuxji/Dw1DRAC0qrgA9PK9EdQIJ6PHj9hSV0ZPME?=
 =?us-ascii?Q?1fhTPzGrDXkqifKwkG5RkBI/DeA5NTLSm8yAQ57T9+eR+0wQdGoXpihkdW1F?=
 =?us-ascii?Q?M7s7LNfBDIfZVCe/7cFJjofDHCd7SLXut4xlzXk4NVAZiyxSliSdya6wwkq1?=
 =?us-ascii?Q?YKfaSYMkvtSNVlPeV7oCgRYvfd382u0Zr+U1PhyN7T9JG17ZWcNc1/U5rapS?=
 =?us-ascii?Q?elEQQdIUQRa4LflKzOJqa1QihWsq9j1JJzA9j2BZ/DrtktAJmWYqK9E8GVjK?=
 =?us-ascii?Q?3Wh51QfMNqLN7ZQcmUjHFs0OkR6rS3Wd5nvmJnODg9s6GhNN7te5WtQTArjq?=
 =?us-ascii?Q?CdkU/y7MDIn9XKQt9IuUmtOzZTSAp7x1rlFz8OQ1YidV8/I5WpUxO7f13Zxo?=
 =?us-ascii?Q?R9E1NAes08rEo5sO/uOtwrwCLTzznk6JHHTZhsPtRfzwGnFBfuQAjpRtGUFp?=
 =?us-ascii?Q?jqJGPR/Ozucwv6B2xdiGzKhGeQbGNtqTMjQcPDyyDLJ7NswqjMS6743vygfM?=
 =?us-ascii?Q?fZuGSfKp5EJPWaPauekMg0TWHDkJZu5wiF7Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jwAXZqeT7U9lahiUUWV5/bw+Mro+n5d1yviwmWL4FVBvTSi3+IXqJ1Q4YQLA?=
 =?us-ascii?Q?on8crXsLYs68H1/dG9gSd2benUZZ6NgPsyKotYUDqXUh6DVArJJ9ZQr6hZ69?=
 =?us-ascii?Q?qjGdYDRyNIvjPfssC1wvZj5gh/tQrb3UL4tTz7FvIVJoWUTHhft/EO1vx7M2?=
 =?us-ascii?Q?5m24+yAuFwAcCghmDKQ24nI9AdWIhblr9WOUkISDwD5CX57uOaNslMArPj3S?=
 =?us-ascii?Q?ot87nohBDug9Y4+1LMyFR2oT5gshp9O734P812cV3DRypmiS6dF7/1Nj+Gxd?=
 =?us-ascii?Q?0jWNGbrHMtclHTW0IWg7RtYuGZW22Xz8/+lCAtNJ0JxNUy7xeaNLYTYuHraT?=
 =?us-ascii?Q?cpJ/JO06bLV4wXLVWJLv7r2QF8/5LWCrSy7LdN0NgP9xGu6urDRxrxoA2gsM?=
 =?us-ascii?Q?l3wTZp2Lur2zZo/au0hXK4Gtj9AgLyg+Nyt6WJwehlr9Mc4dh0jIrCn1MfeH?=
 =?us-ascii?Q?ObYDwqUshd9H2ZsK7yAZWN7X7q9jWpcq+JF+w93zZ963fIV9SBnfBR4HUVMp?=
 =?us-ascii?Q?8Agv5pFirTSit5AFfXlcKPxuBcjRNI78ArYIjgcnoxxJzQqtrL0pD526imiQ?=
 =?us-ascii?Q?8q5mf0x2gNRPy7a8WX/07VtvNwx4MQr1O+GIbQPblR3BDS0hOkvIp10i7yle?=
 =?us-ascii?Q?PWsJbRv0FEPyJ4gzBiBgmxiHdwGs95TZV4McnkgdDDgeQYBOKxewC/U9F6Bz?=
 =?us-ascii?Q?3QE/qnvax553Q1sjj8knHUEG1xNY/l4OBNO97BaMM1hlgpstPI8d/2rTkQMs?=
 =?us-ascii?Q?6goG7GYcDwLuaVsXkQZ0Hu9iOgtiR/XfMjzSqNfZn6Q+yPNy7cOdRdyd53kT?=
 =?us-ascii?Q?KId5rENGg2ei0580ESOXxc5/Wxed8CXutr/I6AcGq/dYJsM3OUND/Z9Tmt4L?=
 =?us-ascii?Q?AvYjanfWV02LVWDlk4R317hfBvFJ+3KJOh8NstPWgDk27DLqBKOUrsB5Gluk?=
 =?us-ascii?Q?wNHsdDF3+E/eAiMT4LpwIhi3hmDPnWhXQEBQ7GgAGWgGO8fsmJD6T/i0ApiM?=
 =?us-ascii?Q?ewwGkmdP7MM+YtdZwPtJmDfCJSg+lchlnc4OY2+RNWIsPeeDk0TwiSfZos5F?=
 =?us-ascii?Q?9leSATItSllzM0RJ0hjYcBWudsC81yuC8DAx4KBoQKJJXPhe+nMRsVSFOBge?=
 =?us-ascii?Q?RCPHr6eaL2nY6D+Y836IVyFS+74oqdwtABsmsXi2gKNcxFyUexZ5v0G+AY/D?=
 =?us-ascii?Q?CigPiwHYqPr8lSYEYYeFCd4SpSZbJ+H3GbPuWCoX3VT1W6Ao8IQ3LOQYDbpG?=
 =?us-ascii?Q?oPRPggoB4KANKY9R6IHhifFprvcv9xFwurlNJfWXuMA/UJkLgYnX9X6R/lO0?=
 =?us-ascii?Q?F/q5tJw9Nl2Wy/2p1pBlPZHAAHNjyyv/i2OHpFVijFjwohgClX297TrpmXpi?=
 =?us-ascii?Q?faJwVT2H0ukAplwgECSLQ0KJWpZLq20t0L0gmZRTjSY8SIMykn4SfuldAwfo?=
 =?us-ascii?Q?tJgUbCySZDJDQvD9hZeOiICvMRSdPquR9vxIZWbthmqocWJv+hPFLI0I51Km?=
 =?us-ascii?Q?uebUfJVhcYPOKzJHM6lCENbRGefWPeAkGjJ7WSsAEk7Icn9JArsq4bKgNibt?=
 =?us-ascii?Q?EVV08hb9Xd6/YC4qHVEMstre7/MUtkAQk0xA2Fpd?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB708204C40ADC23BA42E4545097A0ASJ0PR12MB7082namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c5d988-5e43-41fd-f5f9-08de380e3f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 17:04:58.1077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGMWCWOl8AWnLbxBoH2DQXrKMytM8pK2Zhgfj/B+8NkXoh2l9BNYRj13BeKZlj0u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412
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

--_000_SJ0PR12MB708204C40ADC23BA42E4545097A0ASJ0PR12MB7082namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Instead of keeping a stale job pointer check at the end, may be use if (pas=
id !=3D -1).

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Wednesday, December 10, 2025 10:02:54 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM, SRINIVASAN <=
SRINIVASAN.SHANMUGAM@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Ko=
enig, Christian <Christian.Koenig@amd.com>; Matthew Brost <matthew.brost@in=
tel.com>
Subject: [PATCH] drm/amdgpu: fix a job->pasid access race in gpu recovery

Avoid a possible UAF in GPU recovery due to a race between
the sched timeout callback and the tdr work queue.

The gpu recovery function calls drm_sched_stop() and
later drm_sched_start().  drm_sched_start() restarts
the tdr queue which will eventually free the job.  If
the tdr queue frees the job before time out callback
completes, the job will be freed and we'll get a UAF
when accessing the pasid.  Cache it early to avoid the
UAF.

Cc: SRINIVASAN.SHANMUGAM@amd.com
Cc: vitaly.prosyak@amd.com
Cc: christian.koenig@amd.com
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 8a851d7548c00..1adfa23db0981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
         struct amdgpu_hive_info *hive =3D NULL;
         int r =3D 0;
         bool need_emergency_restart =3D false;
+       /* save the pasid here as the job may be freed before the end of th=
e reset */
+       unsigned int pasid =3D job ? job->pasid : 0;

         /*
          * If it reaches here because of hang/timeout and a RAS error is
@@ -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
         if (!r) {
                 struct amdgpu_task_info *ti =3D NULL;

+               /*
+                * The job may already be freed at this point via the sched=
 tdr workqueue so
+                * use the cached pasid.
+                */
                 if (job)
-                       ti =3D amdgpu_vm_get_task_info_pasid(adev, job->pas=
id);
+                       ti =3D amdgpu_vm_get_task_info_pasid(adev, pasid);

                 drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY=
_NONE,
                                      ti ? &ti->task : NULL);
--
2.52.0


--_000_SJ0PR12MB708204C40ADC23BA42E4545097A0ASJ0PR12MB7082namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Instead of keeping a stale job pointer check at the end, may be use if (pas=
id !=3D -1).</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" id=3D"ms-outlook-mobile-=
signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 10, 2025 10:02:54 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; SHANMUGAM,=
 SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Prosyak, Vitaly &lt;Vital=
y.Prosyak@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; =
Matthew Brost &lt;matthew.brost@intel.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix a job-&gt;pasid access race in gpu =
recovery</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Avoid a possible UAF in GPU recovery due to a race=
 between<br>
the sched timeout callback and the tdr work queue.<br>
<br>
The gpu recovery function calls drm_sched_stop() and<br>
later drm_sched_start().&nbsp; drm_sched_start() restarts<br>
the tdr queue which will eventually free the job.&nbsp; If<br>
the tdr queue frees the job before time out callback<br>
completes, the job will be freed and we'll get a UAF<br>
when accessing the pasid.&nbsp; Cache it early to avoid the<br>
UAF.<br>
<br>
Cc: SRINIVASAN.SHANMUGAM@amd.com<br>
Cc: vitaly.prosyak@amd.com<br>
Cc: christian.koenig@amd.com<br>
Suggested-by: Matthew Brost &lt;matthew.brost@intel.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-<br>
&nbsp;1 file changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 8a851d7548c00..1adfa23db0981 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *h=
ive =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restar=
t =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save the pasid here as the job may=
 be freed before the end of the reset */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pasid =3D job ? job-&gt;=
pasid : 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If it reaches here=
 because of hang/timeout and a RAS error is<br>
@@ -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info *ti =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * The job may already be freed at this point via the sched=
 tdr workqueue so<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * use the cached pasid.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (job)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ti =3D amdgpu_vm=
_get_task_info_pasid(adev, job-&gt;pasid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ti =3D amdgpu_vm=
_get_task_info_pasid(adev, pasid);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_REC=
OVERY_NONE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ti=
 ? &amp;ti-&gt;task : NULL);<br>
-- <br>
2.52.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB708204C40ADC23BA42E4545097A0ASJ0PR12MB7082namp_--
