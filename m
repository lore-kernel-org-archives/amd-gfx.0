Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CEEC5AE59
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 01:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6952B10E025;
	Fri, 30 May 2025 01:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0727NUzx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163AD10E025
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 01:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwvFaKJCqSXNPPyaQGWFzDoWaIYrdgjRJODDaBy/l5+freg5zAbB+puhjK80sgweL9A8V8MpUnpQjWf7tTiCW1LOVTlSlt0i5GCWD+qCK2gmANLBMODohPPA7AE/3hx//Y7C6jd0oIHmiC2X0crOgbsEsqeUBBWCt8mKAKHkXTM5EZQY/a50+4Y+uzI0lqZ8f3C4VHljX/zbhviRJuYSTz0BYnh2rf5VWhbRPbBIAhmprSyUYepGbvI6TL8BsqNtju6UI+JDIsUF7pLFC9OagFSKXJ9uwZhmoTxNbFMRB52nfHh+ziPxi+mw0mvV2nC/gAxrrVn9yg7QnDzRu2mEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTrTCFoW90AwKiMDSlbzBVN88WWMj8CHRkwKNajgVbc=;
 b=kK6874XmB0n3NSDzBpi33NMjE3/XZtejpxbWZXPbJEYOnDyu0xtxvQB0r33EvEO1ZSxqrhr3OrwJ704DIaYL5hrrNvP68Ik+8g6oT0pJijFF2MRYM/y9TXda2c7gmbt1tRh7INil9AganLFY3JU+Mp1yE1DjMsHA9Xe7GbYIv2oYtUmHfoq7GKXtaFGlAHjbn3eejajxfpk4w5vsEDa3cbDRfMKimbBAlFFdR7H3GCPlFy7dlF951287A4x9iq5wG6hPWs1GdJJcfksYG2dTvrk9RUwbFkbyWXLLnYQk87Q7HxFJsQw1kuJK+OSB2vGBkIlfdmZVjLLIdUAif44jBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTrTCFoW90AwKiMDSlbzBVN88WWMj8CHRkwKNajgVbc=;
 b=0727NUzxlWnOyn7Wt9J20o/cLNlkFdVA4iWqffvr4gSqTHxXKdPISguJNAQqtLj8rDMSEYDKrvzQa+26AlCcRJ8Zh1Q5khDHpNwCCDMY81089EuqxUxjpEWBcOQ1LRvCQrycB2WPVIgHarRVv+sQE3lGpqM+Y5uAXU1fwiTo7ok=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 01:38:50 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 01:38:50 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume out of
 full access
Thread-Topic: [PATCH v2] drm/amdkfd: Move the process suspend and resume out
 of full access
Thread-Index: AQHbzvUTZbMMhfehQE6fQzi1RSDgA7PnkvwwgALWOhA=
Date: Fri, 30 May 2025 01:38:49 +0000
Message-ID: <PH0PR12MB5417541194A32741CF817B898F61A@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250527104943.3020168-1-Emily.Deng@amd.com>
 <PH0PR12MB5417B96B410513A018108C208F67A@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5417B96B410513A018108C208F67A@PH0PR12MB5417.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc3e1e79-46d5-483c-add9-89294efd6437;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-28T06:19:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|LV8PR12MB9272:EE_
x-ms-office365-filtering-correlation-id: 1177364b-69fd-491f-e8b3-08dd9f1aba4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FaSJDX0Z0TKRDX0/ndetdVzDYJp6lRMJLFT+5BztKIoMGbrD6+LbYhb+XXjQ?=
 =?us-ascii?Q?Fb5hZhjxmxewB1D6s4R7HmxVvideKbMKqp9AHH5tf8kiVn2u4ZYyqc3jFy0o?=
 =?us-ascii?Q?lhahFPP0yaHyEqWs6qpkgY0BAv4EoXjTP/nDeLi43MmkhOSXis/VcRVJZKXY?=
 =?us-ascii?Q?caHCr+zNwt5l1MWRF6jTiIE+BjmahC2nTzQQjA0/M9scVouLIXiq898GlIXu?=
 =?us-ascii?Q?3JBw/vkgLkTN/Zay1VXxherZUOEXjNWdXAHQvzmi0o04mkq3ehNM/093onxf?=
 =?us-ascii?Q?x2G/1XIBXRpFns4NrZ8pLihalnqc6RK3KPeo1sGp47s+H1EudNr/fChtYyML?=
 =?us-ascii?Q?pp6Q4nhqN0dA1wSeH5hAJeHonSrOVKoSjI/xMUG65skMzw6LfuvBjGggUXNF?=
 =?us-ascii?Q?tuPJUnQ9TAIHKEl13hj5dXPnV+eRCtNgzwr9WNsTvKaBwif9OJVAsYniGO5S?=
 =?us-ascii?Q?JPOd3QuEfmxcfQ4WlNBJHJ+PieGj1qd0DCdGsNsQdnrLntY5Y9JmHQ8szgDU?=
 =?us-ascii?Q?4UOLvb0v2mP8YvSEglf9inqwqpVFg/nT+nc5Q+b18NdvRHm+7JBhCou/5HLu?=
 =?us-ascii?Q?nvWicV3zX324WcfMIs8Mx0MO9WKbiNQBdIbhYKNxK/1zNLGxwhQbg+VVETnJ?=
 =?us-ascii?Q?L2vgXAE1QNDsfJk8TYcio7m9vkt7mh9txe1R7qFGP+gQkhmYboGnYxJvke4V?=
 =?us-ascii?Q?4YHcTzQ2Rq34s8TGcTjpf7Qig4sdSBezpaG3X6MANoUkPhB4F8QIyFpjSi6i?=
 =?us-ascii?Q?PdapNwoek8PkoXrn4LdKzXsxqt3FYTBoslMfQJU4HU09GyJDdfIVrIJ5wdBI?=
 =?us-ascii?Q?thL8y4DHufBq2ZB4YNjWwFpuPyf5Iq17IGISHFdA3+/6xF8GAncKqN30gfCC?=
 =?us-ascii?Q?WfR/3bUoRLKqaELAcZPUvl7r6BBbNuhsT7JNjLek521fO1qOVXw9ABlGcLlD?=
 =?us-ascii?Q?Mx2s8HPWCQeSZzAiy0b4PNhPaJq0XuTUA3HmAsfmhtbkOA3QXRlaCrpcIIc0?=
 =?us-ascii?Q?CPOnxz5HmjBqzBwkY0CxJN9bsjzxVBuxyUfugu7VUwEYuZccN81NkE/5Pj9+?=
 =?us-ascii?Q?37vtyoeWEfS4hEyQZsJ4e1tQfcLb4DHAzHkpSvBfU/ZKotNgmKQzux2gi5+5?=
 =?us-ascii?Q?nl7MdUSm8VOkBXn7efF+LrsjNhCm5rAqUi4D0wBlwyt4KqKYQLFdOS4qWXMO?=
 =?us-ascii?Q?YBtbbxpsTTTH/YWL6CHQIbwCiCCH1yRE5KrHiSqXX/CymRW3TrqXHRtYEJmZ?=
 =?us-ascii?Q?/8LesJa3Q9dLL9NZR8aMx7ZJTRmSh4Bvpxh7mAstyz+0p0PZy8ogPfHGMvFX?=
 =?us-ascii?Q?hFaxyWV9UIoguNkhBO+UTRrSdHfcfMekB39q/+QUUOBU3h4Am1xKlf6zPq6y?=
 =?us-ascii?Q?LajFWUmQOPf8yk9WZBf9mwJt8d+Ls+2cNz+bXa+48DSx0wE6UH3h48ZHNLRx?=
 =?us-ascii?Q?Vo0Xyjyq8z53BUopjr8erXi6ddgPTQdd5Oq8jLxpRCIYVRYB5VoJBriutvHX?=
 =?us-ascii?Q?4hSzEJFSuBPwGMI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kd0/H20Imhqt27PYGcJygLie8ZkuLGHUBwRpERpwouKZc9IYUZztUQt40goE?=
 =?us-ascii?Q?oNpmzMhkK7vboFHqOXNRYDifY4raD37uwEhijk9b0fTscxFdKJt2ovZkf9di?=
 =?us-ascii?Q?biN1LhlUt9vLT5Oppc280vaM0cs18pwXX+eI5T/hYnult2L0TTjujnnS1Bby?=
 =?us-ascii?Q?NVIWOFhqRcHWBPMdFYcgdRe8OF3Y4Uxnm9MLPXwWBzv8l4ckTIjDyIyU5Rnx?=
 =?us-ascii?Q?wcz2P6Q1y9KFlpCalwmoQU4IBx/kMq/GaztNbcu/+RIVHeHy3L8mtfQ6GWzV?=
 =?us-ascii?Q?D2W49UyDX0WG8cFJPyMqZztH5X/4il+7uxsA/G0reDDXisH07PMBX0QITryt?=
 =?us-ascii?Q?gexrDPxmsqtb5O3s2Q5inwtwwZHUomQxQJi9RZZTRSP9mmcC/+ubw7NCTqum?=
 =?us-ascii?Q?8plaFiirCT18BgdnGJscm41bfbZdV5SajajdBXZdsHi7BnEMS13cj14ihleP?=
 =?us-ascii?Q?knRhhzQPKB2HjSB+cBrernVdlteW0LmpXbgcH/+ljpl+u1r2Hxc/smG7cMOh?=
 =?us-ascii?Q?qDVHb6ahe5fZipT9acuVlDF2BlTVVVlT20A1ovksXA3Cogb0GO2CoGSXF47V?=
 =?us-ascii?Q?/GHpldcv8A8MmHSoZremwiH2DdjjCPf1WRO+rTXjdsTFObMAOtIBXgSTf/Wg?=
 =?us-ascii?Q?OSZ856nAKs1Q2x3CQfetH1Ftba5DetLQab7+y+/AAidPbQ80WyoG+fed3h8V?=
 =?us-ascii?Q?EPMdnzSGH5Xx9d1IEaalJhM1rB9egrPp3vOlvQMaPBwvmfjEXdkHcedH10bO?=
 =?us-ascii?Q?U/4vYg2KWbmfhYZQJfqvJ7Cfu6UKHSMC8HT/8ozM962HpgHaQfzQ5QM69iFb?=
 =?us-ascii?Q?PkOt26A0TWNEEpbSAM+NwHo5PF9ywckI+o2yXGUW7KmRxKi0NTuJ5K4wodDO?=
 =?us-ascii?Q?qN+aXDoXzPnjfMsjL63g7SHZTjqxAN79mYfil9dGZOYa7LiiZcf5hlD46Ji9?=
 =?us-ascii?Q?mfcfBsw2bQKzP8w1EmppY48x+T6ZKfgj9bLZ7Us+rn5USZzcC0R2YBZlW7MU?=
 =?us-ascii?Q?7hulYtQzh1BrgoY4nTyGKfwTUXmp9mwWsdERHblU0pBbRKXcRau8tF57wBle?=
 =?us-ascii?Q?ubPVhjUwHNa3+NHS+YUHcyTug1LJjiBwfHeGZbrcI1SidYpaM8guyKuIAf9A?=
 =?us-ascii?Q?IFS2Vz/wsK7eSN+M7ZIyCKSV5/iAVsQ4+MdOeUbElRdAngDqEoeZwOBxPDNv?=
 =?us-ascii?Q?uCQN55p+EHFepNSRPG0VppCcMLLr/M0HOoWckHltmjaOvkqmvAYvd0c49ar7?=
 =?us-ascii?Q?oAk9kDlo0SW9tFAK3HQldOQr+meU4L6zYoSJSdNZh5RO1zirEz2L+XUgldeK?=
 =?us-ascii?Q?8g4rgLzknJtw8IDDlEqEpwV8IeoysA1lNhEErWpTH0M9YBK7vHd8qy9yYtpu?=
 =?us-ascii?Q?p8Qa1A6pm/01xZr8ctvlsPMtq7chHgfGaeg/8Cbp0OKayVpxnfj4/aIf7uMb?=
 =?us-ascii?Q?Ki6zJD/z7PfhnZZFz7g4RQqVBY+OFRntYs5DZB5dycWr8wQUESJDxwCutUV9?=
 =?us-ascii?Q?3+ovVfgfMlLAbe1YROBlvOoHr6w3I49X187SuCRK+TkvNQYy84CHkJ0wQ4mh?=
 =?us-ascii?Q?8chj0Ihj72y/1bcwxWQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1177364b-69fd-491f-e8b3-08dd9f1aba4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 01:38:49.9557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3sZbwgKXroIdXDXvNByIEwGHMkqbqaCC+PlMAqEm2QROnctYMX413bwNgmgNzgg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272
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

Ping......

Emily Deng
Best Wishes



>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Wednesday, May 28, 2025 2:20 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
>Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume ou=
t of
>full access
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Tuesday, May 27, 2025 6:50 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>Subject: [PATCH v2] drm/amdkfd: Move the process suspend and resume out
>>of full access
>>
>>For the suspend and resume process, exclusive access is not required.
>>Therefore, it can be moved out of the full access section to reduce the
>>duration of exclusive access.
>>
>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
>>drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
>>drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++--
>> drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
>> 4 files changed, 70 insertions(+), 11 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>index 4cec3a873995..ba07e9c6619d 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>@@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device
>>*adev, bool run_pm)
>>       return r;
>> }
>>
>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>+run_pm) {
>>+      if (adev->kfd.dev)
>>+              kgd2kfd_suspend_process(adev->kfd.dev, run_pm); }
>>+
>>+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool
>>+run_pm) {
>>+      int r =3D 0;
>>+
>>+      if (adev->kfd.dev)
>>+              r =3D kgd2kfd_resume_process(adev->kfd.dev, run_pm);
>>+
>>+      return r;
>>+}
>>+
>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>>                           struct amdgpu_reset_context *reset_context)
>>{ diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>index b6ca41859b53..841ae8b75ab1 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>@@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
>>
>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>+run_pm); int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev,
>>+bool run_pm);
>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>                       const void *ih_ring_entry); void
>> amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -413,6
>>+415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void
>>kgd2kfd_device_exit(struct kfd_dev *kfd);  void kgd2kfd_suspend(struct
>>kfd_dev *kfd, bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd,
>>bool run_pm);
>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm); int
>>+kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
>> int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>                     struct amdgpu_reset_context *reset_context);  int
>>kgd2kfd_post_reset(struct kfd_dev *kfd); @@ -463,6 +467,15 @@ static
>>inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>       return 0;
>> }
>>
>>+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool
>>+run_pm) { }
>>+
>>+static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool
>>+run_pm) {
>>+      return 0;
>>+}
>>+
>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>                                   struct amdgpu_reset_context
>>*reset_context)  { diff -- git
>>a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>index 625c416c7d45..6e29f8bd54bb 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>@@ -5080,7 +5080,7 @@ int amdgpu_device_suspend(struct drm_device *dev,
>>bool
>>notify_clients)
>>       amdgpu_device_ip_suspend_phase1(adev);
>>
>>       if (!adev->in_s0ix) {
>>-              amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>>+              amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_runtime(adev)
>>+ ||
>>+adev->in_runpm);
>>               amdgpu_userq_suspend(adev);
>>       }
>>
>>@@ -5097,6 +5097,9 @@ int amdgpu_device_suspend(struct drm_device *dev,
>>bool
>>notify_clients)
>>       if (amdgpu_sriov_vf(adev))
>>               amdgpu_virt_release_full_gpu(adev, false);
>>
>>+      if (!adev->in_s0ix)
>>+              amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
>>+
>>       r =3D amdgpu_dpm_notify_rlc_state(adev, false);
>>       if (r)
>>               return r;
>>@@ -5178,7 +5181,7 @@ int amdgpu_device_resume(struct drm_device *dev,
>>bool
>>notify_clients)
>>       }
>>
>>       if (!adev->in_s0ix) {
>>-              r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
>>+              r =3D amdgpu_amdkfd_resume(adev,
>>+ !amdgpu_sriov_runtime(adev) ||
>>+adev->in_runpm);
>>               if (r)
>>                       goto exit;
>>
>>@@ -5199,6 +5202,11 @@ int amdgpu_device_resume(struct drm_device *dev,
>>bool
>>notify_clients)
>>               amdgpu_virt_release_full_gpu(adev, true);
>>       }
>>
>>+      if (!adev->in_s0ix) {
>>+              r =3D amdgpu_amdkfd_resume_process(adev, adev->in_runpm);
>>+              if (r)
>>+                      goto exit;
>>+      }
>>       if (r)
>>               return r;
>>
>>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>index bf0854bd5555..22c6ef7c42b6 100644
>>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>@@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool
>run_pm)
>>       if (!kfd->init_complete)
>>               return;
>>
>>-      /* for runtime suspend, skip locking kfd */
>>-      if (!run_pm) {
>>-              mutex_lock(&kfd_processes_mutex);
>>-              /* For first KFD device suspend all the KFD processes */
>>-              if (++kfd_locked =3D=3D 1)
>>-                      kfd_suspend_all_processes();
>>-              mutex_unlock(&kfd_processes_mutex);
>>-      }
>>-
>>+      kgd2kfd_suspend_process(kfd, run_pm);
>>       for (i =3D 0; i < kfd->num_nodes; i++) {
>>               node =3D kfd->nodes[i];
>>               node->dqm->ops.stop(node->dqm); @@ -1055,6 +1047,36 @@
>>int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>                       return ret;
>>       }
>>
>>+      ret =3D kgd2kfd_resume_process(kfd, run_pm);
>>+
>>+      return ret;
>>+}
>>+
>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm) {
>>+      struct kfd_node *node;
>>+      int i;
>>+
>>+      if (!kfd->init_complete)
>>+              return;
>>+
>>+      /* for runtime suspend, skip locking kfd */
>>+      if (!run_pm) {
>>+              mutex_lock(&kfd_processes_mutex);
>>+              /* For first KFD device suspend all the KFD processes */
>>+              if (++kfd_locked =3D=3D 1)
>>+                      kfd_suspend_all_processes();
>>+              mutex_unlock(&kfd_processes_mutex);
>>+      }
>>+}
>>+
>>+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm) {
>>+      int ret, i;
>>+
>>+      if (!kfd->init_complete)
>>+              return 0;
>>+
>>       /* for runtime resume, skip unlocking kfd */
>>       if (!run_pm) {
>>               mutex_lock(&kfd_processes_mutex);
>>--
>>2.34.1
>

