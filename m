Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFCD10854CB
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 02:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B34E10E376;
	Wed, 18 Mar 2026 02:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Q5ZBBy0";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688AD10E376
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 02:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIA7Pc4oL3m5EJOX5n6wH+pvtEt+bz/f0w/tFOE9dVaubU37slw18/YZmnzK25HB1gVAnMuRDW2ffQ8GKFECMj+rSRi1PNsOBYHDBdmHskbUrY0nhmnOR0iHEjJvlcSoLcLnmMvjG774yjN+cSQctNq6jid9+ZLc1qDPdZAE0b+OSuHB/Pi8NokzaXAQn6Q3n7V5E9sweyMQqeVgnhGakFmTwl5rMqmLquTwLCsARImxGaEnb+R75ryDvsVsgorCPgzspf0Ry6oBoB+rz5uySmxLnciXJ7XGu4adQhQpSnc6wduZpkUfnszYTus6ZTU+dnZ5fiWdz4on3mIx8a8AzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKm4/BnOmPC5ZC9YvRsCit5WyXqJgSbqSk5Dh4R78vA=;
 b=PyylMziBqYT2RfpUAgmdtpJzr0YwP5Hro/xS2E40hTNOK6s1AlDZoVC0190cTD5fF7QM2WGJbRuo/03m6JRsErax0LcS+IXoWvL6xKHCWMAZoDqDNU8Sx8ITeC/ATgJp1qIPNqszajRt1fV3QjxBIYE676xozQFrpOlaNs4P7iDUsBO6LwDsF8VpCzomap4Trfz2nq5RwPYkJ7KfhX2+AoUAPwrfdlr2t0BPOU6u/HtajeyQVgkfXsyry8t1soltg38OtnL4cn5Lvg0aYOVhiK/FHUMsLGKWUwvhVcmDr6qxWWVxzYKMhrB5WJbRYCb30HSQsZ58NRWNEj9m1gl5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKm4/BnOmPC5ZC9YvRsCit5WyXqJgSbqSk5Dh4R78vA=;
 b=5Q5ZBBy015ruOs31sjUUMzhhUy6lhFM2E+b12goPM+g6I2AZTBPPVl/86m51YrSN3kTaK141eXys9NtFI+KpM3W7tCK/IAYjtw4/2GqYCOVpHEHBXMSLuOE1BoD+opRcZrVVIgiRcqY1OK0KjiAQO+2PlKmoo85Htz/JWdRkl80=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 02:10:53 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 02:10:53 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: don't set queue priorities for kernel
 queues
Thread-Topic: [PATCH 3/3] drm/amdgpu: don't set queue priorities for kernel
 queues
Thread-Index: AQHcofb7DqXrE7PJ4EyHUvbG2ijBzbWztKUQ
Date: Wed, 18 Mar 2026 02:10:53 +0000
Message-ID: <DM4PR12MB515201DAF95345E35922D188E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260219232433.31453-1-alexander.deucher@amd.com>
 <20260219232433.31453-3-alexander.deucher@amd.com>
In-Reply-To: <20260219232433.31453-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-18T02:09:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB7511:EE_
x-ms-office365-filtering-correlation-id: 33faa1d4-7709-42fa-81be-08de84939572
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: K/ZEgigfn2B3l8/9vJ6/LQXzOHfZbUMl3oemPpBWnCoionOEdz3n197Mr/iX18W7p6ljmwGikIOb1OWWL2XoUXC10fK2L2n4NslUxRlweliWUukM71upJ03kOrTXW2yc+g/RsaO6Y7siphiX3Dm/qOVWeaf8DrfZcx+vMv0mzfBMqhTKE2VerjxVZcnnX0Ns08zuRqqqfZCfyvl478Ez8nWmn+OTYlMRp0f8t9QaNOYc4kbqb7XKlNkHiB55hCw9fcjvpYD7tZmQ0dUkxpJjHPSFW+qOm14cm/LB7HmEMtHOveQc7lzvB88XiT3RY82V6YPYKNEK7ZOOZz26bLx5rrNNhC6TS5bV/wsudVfRGwJriNn6l2b9wMaidr6dEhebJFmbYC12ceMrsskqoQLwUFEP9mPPH8ezvf2t3PPy9GQD/4/oRfsAPg0qqXg8N8DG5OHgoiAXhNUKTKuxweuURY4akhxIq4bG943tj6OuJsadoz/jhngro9Sj8FnyYsklgNvuWeR96ggsUV/381MWCZeAZJKNJgSNxkU1VOf2jk+7cmISXFaKq3s3kZkhYpqcfPqUjs0w1kOdk0YY2FRl+mT44MLdr2ObJF7RBkvW2GQN08fodzCZLqP/G+rMVftq07Ld/WyhIKFEIZutOZPIY+x8D6XcGBCysREG0Aaa8U0KFJGRwvqGyVT+9eAUAp5cUzw6Cu0z3zXZ0rtkbOBHQm8JAPYMDjiLiK0OXnLKoahuQwx8ECm5//AFgm8KEMOIcdozW4OOrWHS9c9vDB2Dyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZHNkUnhodnpZYXZYYmlzRGt1aGxGclBWMmdFMXZUZTkxQVcvWGRRTlc2?=
 =?iso-2022-jp?B?c1lMVUJIVnZIa2VIczVxalVMTzZZZEQvWTdEOTZXZkFDUUwwTFhWbFpp?=
 =?iso-2022-jp?B?U0xBS3lWTVU5OG85SFZNMnQ5dDNyTExpZkdYNFRLMFMzRFFzRGZwa2ox?=
 =?iso-2022-jp?B?OXI0bmgrdkNCTHVKdHNpVTZUd2dtUmlEdkk0c2tmUWpXMTl5SjFsbG8x?=
 =?iso-2022-jp?B?V0pqS040ZnZLSzg4SWE5bllhYkZKZWJVTEhEYUp6V0x2bVhrWlFZSnlF?=
 =?iso-2022-jp?B?d2doK3UvQW1rU1huUWpYMnNkMVl1UDduSnBYN201NTlKUTRvMmR6Znpi?=
 =?iso-2022-jp?B?UmhJdGlNNGNJUlVTNThRVUFzQkpDUWlkS01GRzVDSVI3bTJNYjd0WFEx?=
 =?iso-2022-jp?B?MFhRY3Qxd0VpVFZNeHE2b0NDL3ZsdkZYeG4vWlJhSzFJekpmT3pwOFox?=
 =?iso-2022-jp?B?cGFrNi9wUlJwcVRqUjZQM0tFVmFYOU9JaElqQmwrZzZ6Zk5GSW9PUllM?=
 =?iso-2022-jp?B?TDh1ZUVteWxCRlovNk1Sdko4TGZCMGxZZjJTVmxaYnpXT3p1Q0llc0g5?=
 =?iso-2022-jp?B?M1BLQUVnQkhlSjlHN2VER2wwVjNUakFUOXdEVGpqa21jdlBvZDlzdGR0?=
 =?iso-2022-jp?B?T3RLbzBxT3M0YklwQ3VmQmxVbE9CVGJyZXFwd0E4dStJUnR6cmU3NTBo?=
 =?iso-2022-jp?B?N0lTUUlmZUNnMzgwdjN2VFU4b29GSXRmM1hVb1E4S2hFZnFBZ2tOc0gz?=
 =?iso-2022-jp?B?WVhuTTgrQmFVajNoQzJsZlVvT3J2K3ZjNHRlaHhQa3FLZE14SlNGZzlm?=
 =?iso-2022-jp?B?cm1UOE9JMkJraTR6RWxNRnBJbHBnWFpVMmRCRHVmSG1TMzV0bHY0NjE4?=
 =?iso-2022-jp?B?UnYzenlDdTk0NzZDdmVNbnRjb0pjUTh3ZEdwdHB1TlJZblFNbk5VZHhj?=
 =?iso-2022-jp?B?eFJGQ3FLYWttME1ub2RtL3EwSWIzTUtNeVlUTi9BZ2dCZDFLRXhDYk5I?=
 =?iso-2022-jp?B?THh3Q3h1NjFrRzNyWHlWOW5hM0tFTHdYRlN3VXBDLzdMeUdnNmRXVWR6?=
 =?iso-2022-jp?B?RmdnbTczSGR2UFJhZWJVSlVIVUtHeGtxbHRJdmRIaHJKbURIaE9jNkJC?=
 =?iso-2022-jp?B?SUR1REV5OEpSNmpxczB2WDRoeDBRMXo3U2Q1cCtsTkNNd3E2a1dvMk9r?=
 =?iso-2022-jp?B?TjlrQVBwK3cwbUVzS1ZGb3BDQUhZWmFLQlQ4SmV2R1pKMXViV1FnWElS?=
 =?iso-2022-jp?B?ZzNPRkFOVURYcjhUbjFtWnJiREhZTDQxQTZRb0Y5QXFIOVNXTjlsVjJz?=
 =?iso-2022-jp?B?NlUrNXdFQmpJSGFJVElFVExyWWcxcFFmK01lcUVyMVVPY0lLNTRQNnJE?=
 =?iso-2022-jp?B?TlFBcTNUZ1JKUVFVNHh6cUlSZjJKVmdNSGRKalEyaXA4dThNWGlKa1d6?=
 =?iso-2022-jp?B?OFFVOW1YcEZnUFNYRU9nZlRTQjVxWmU0b1pHQ3NFY1RHQXF6NkxxYXF6?=
 =?iso-2022-jp?B?eDZaNGVEL1R5dkhPVXdId1hXajYwQk84NjQzSXA4dmt3a2hvNmNIM005?=
 =?iso-2022-jp?B?SCt3ZEZHRituQnFabUxvWWlqdElnMmRTSjRkSEpYRVZsK3l4VHNrSXdB?=
 =?iso-2022-jp?B?ZXdDWGRCQWQ3K3JRVE5pMXpxTWVmczdxU1lRUTZnQ2FMekllWndHc3Zh?=
 =?iso-2022-jp?B?ZkdlbUp3eEhOc1hoblJoeWpjUnNnMllDeFJYYVJLYkJjbGFVcjJnWlhz?=
 =?iso-2022-jp?B?YXo3R0dzSUtvR3ZqYmJWZ1BXMmlsWW9kQ2VlNmRCbm0rNjNkYVNiNlhE?=
 =?iso-2022-jp?B?S0NBZ2VjRnJ6VnRMVXREZWtIWU00UWxCVWdzMWk4WWhmUWQyZFRZRDJ6?=
 =?iso-2022-jp?B?Qmwra2ZrUk9NYzJtSklNVlBOSGVSd2R0ckFYOW5pSXQ1VWwvazBObE5J?=
 =?iso-2022-jp?B?ZXRoM2FwWmtVaG9GZmhKaUxIMWpvR3ZHbllOQUdTcU5vaUVEL2JzbjBS?=
 =?iso-2022-jp?B?d01qMEVvWXUyZVdRQllNdEpzM0JQVHpzcFRVcTl1Z2lKSGxiT09sUHA4?=
 =?iso-2022-jp?B?R3JhaDduUlZxNXBjWDRZTXBPNE1OdVBFU1FRWVZCQy9VdjhsSG5iR2RJ?=
 =?iso-2022-jp?B?dHhway9Fc0tka25rOXMyd1Q1MkNIdUZKbWRNelJnS1hXa0VwNEU4bmdh?=
 =?iso-2022-jp?B?VmFwUm4xOTF1RytlWlpnbGdFMU05ZjUrM3VDZGtqUEdYUTcyWkVCaTQ3?=
 =?iso-2022-jp?B?V2MxVmhKNlI5cEZyV3NDdWJhSGNMSE53WEc4aENUeitORitXbVR6VGNh?=
 =?iso-2022-jp?B?clpkNHZ2M0xSN29NS2syUFo3OXhBVkprUzYwT3pRZHppNEdsbmw4V21v?=
 =?iso-2022-jp?B?SnkyTFNkSDJJQW45WEhiakRpakZKU2cwR1ZvMm5pdWU0TDZNNXp2bWQw?=
 =?iso-2022-jp?B?eGEwYkFLcnBDVGVJMUVqb0lxakFzZ01TQTU5bXhCc25vYzhiK2s3UTBv?=
 =?iso-2022-jp?B?UzlMYlVI?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33faa1d4-7709-42fa-81be-08de84939572
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 02:10:53.5403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P50b1tvFYdkbStiKKOx50ONpN606sACONaVVULfgUD/iU+uWPF+aSANXjDPSqTnGFSFLwQg+r4nfG6ndd3HyNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
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

Series is:
Reviewed-by=1B$B!'=1B(BJesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, February 20, 2026 7:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: don't set queue priorities for kernel qu=
eues
>
> Align with KFD and don't set queue priorities for kernel queues.  This ca=
n result in
> starvation of lower priority queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 129ad51386535..805f1f29a3c25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -800,10 +800,8 @@ static void amdgpu_ring_to_mqd_prop(struct
> amdgpu_ring *ring,
>       prop->hqd_active =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ;
>
>       prop->allow_tunneling =3D is_high_prio_compute;
> -     if (is_high_prio_compute || is_high_prio_gfx) {
> +     if (is_high_prio_compute || is_high_prio_gfx)
>               prop->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;
> -             prop->hqd_queue_priority =3D
> AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> -     }
>  }
>
>  int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
> --
> 2.53.0

