Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B8606A331
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QKwPjVdE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502DC10ED9A;
	Mon,  2 Nov 2026 12:50:38 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB4A10ED9A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 12:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avbGfEGNmYKApmtCHTpVi+i6Y27yYtd8KqvDXsRTi8A6wfYyz1XEuHhfpi1at2oyKvwkaNZ2rupb1iv5lGHqKDtxU/Ls/VGEnSLbeLOYXxpv3/F7kRpSk1M2wYUflfg/NAuExy6UcTjI8/D6rEolb1ctDFkOtexXvnpBeyOP4CaoQaq9eYHUjcdvFCU2JzivyHPxs4Y1r0es2/XtHlPysrGtQNmC9YIuHRzRNYzYJWsbghNaUuSDoxmxd4bH4ga9+29950Ce79L4oXT5wTZPSEYUfbunkXOFDp6X2BoEB3c8jffz8ExI0dnjJm3GgQSkxcQVvRkDwowHO2nGK92yPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDujgPxC+Sc6SnfZxS2kWzEmF3hnASWDXwQjiAibNLE=;
 b=JwPUIx+WRWe1u/oiaocRx2gdCHnPfZMlIYHL17I7yvdYh3k638Y5peiA4UGCdc1IUpNX646q9auCLyzDI0YgHEfsdS+a4+ORft5fydgXHxC3dpulMKNvh8VvlAoM2Zao0/Fx18CYi0Eh00KZXQPAUEdd3OoXGqClQOlzzHiNI30x7ZbALmc/i4jodFVavWHxP2yktApce21+OcWcLa0O/6k489eHkGC9v2K3CC+mLkS8juGrawAm4NBTsO13j+pqRR00svziA/s9hwoWPJtrBEgbrnaIjhDARTSPlz1r73o/KMZkKGIe/D1pm/nGE7Ki5aaGrRfJ49kN7m6nz8/N8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDujgPxC+Sc6SnfZxS2kWzEmF3hnASWDXwQjiAibNLE=;
 b=QKwPjVdENjcjOpK4NytTJeBK+gsvEQXFCI0a/D1UcrrjJtUamucxu8DL0vqV1SY06aImZtVn1DTfk07mE9YHb66P2Iu5j0zvjSOXVwF2sO+badIlZCI1PuDzvQUdLMfMpirPiEkk174GLBwX/O257LbljfkuZAyRtoGib6VkmGo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:50:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:50:28 +0000
Message-ID: <ba707a14-2802-4a35-a727-c22e749c136d@amd.com>
Date: Mon, 2 Nov 2026 13:50:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] amdkfd: Native integration with DRM fences/syncobjs
To: aarthex <aarthex@proton.me>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <6LGhg_Yb_ppPcBcic7UenLy4cBVr66GyWswWm0xLqKQZc04YxYzLkPxbPNQj_2LvHWaG-hSzXaFM2ERSYhJbEOEUYXVn_tWBUYfMP_KzQAI=@proton.me>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6LGhg_Yb_ppPcBcic7UenLy4cBVr66GyWswWm0xLqKQZc04YxYzLkPxbPNQj_2LvHWaG-hSzXaFM2ERSYhJbEOEUYXVn_tWBUYfMP_KzQAI=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 61606b5e-a283-4d16-9a55-08df38dfdf3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261021121427099003|11063799006|56012099006|261009223027099003|261028144727099003|261021135927099003|261026121527099003|261022105027099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l6D0i6cOy86JwlSj7r6fFUMvuPU81YrBEx9TLX6veUYc0yE/vkHXjxg7mgy2jHVtr2Oc4NxmXxLtNxyk5HcruN7uvrX1xcYE3L0lOSdHK7MTMK7SLmU8T7CJ9hczQz2KxUoBal/slSPtR8XGwKx0AmbQeipMzl0zbBG33heO1Bsg5XaEMuXJt82pMy1yesGjBhGFPS6wc82Elfd6I6ZtgLZqngLW2y+FLGrvlt1sB+sbx8cTgi9A60wGdcYFDcZ9nRdKxxQ1adtPym9LOve4DTAz8CDYvtBTpb4M1OVXOgsWZNYNOk6Rd7b9R1g+EWLRNDLTYNQLKRAaQYMCR8HZPmnCUlMGatfqbPNKSphiBQN2+Lfbq3HqWlLkC3c4EGl9dOc/V9iEif+lVGoZTujeEwQ2zT2dC3IQmO0fKIXQljUUK+KuPpZsFdXOEkr9oAHzGh6k9gKrxG9jRt4o52zqPD8YMuJRNtOmXG+3tdcyk1XB/JSIw9svRMIz/4LvhfX1HUQu4kjcIio6vlglbyzAeb6jy6YBMYBLqub3qEFtZ4x5hnVhpbtGZMfV+nqQJcleVu4Mwn+Ep7RWLxFfUg+ziB7WDKblaAyOhwV7sUQ4bNlq6wniCbOG9y0aOb8nTAXC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021135927099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVVVT09UazMwODkxQWJnRFMvaDh1S0o1RGtjN3N6RHZISmhiRXFqb2MreDJk?=
 =?utf-8?B?dm1qQmxoSUpVNnM3V0x0ME9zVWszQjFVQlBGOVpqMGxQRVNCUzNQK1ZGTjRI?=
 =?utf-8?B?eEhBVjhZSXpMVEQzcS9OVWtyVmJiKzFUaGlCL1diVmlCdVI3UVp2ZUVWc1Jp?=
 =?utf-8?B?V2hDSnJ4RXZoWFJPbDFybVBuTVEyTG8xMXFNdmRwZlhpcStXK0ZUTDJIN3Ux?=
 =?utf-8?B?WHpGaTNTU3RMdW5Mb2dNaHNLZW9nZ0NjMStaZXdoMHRQQloxTmJ0S3RsdWlk?=
 =?utf-8?B?VmhtVEtrcDBLWWNCamRiVXhMbVYxVmtIVEtwZTVNNWY4STNPKzJTcUVSQ3Fw?=
 =?utf-8?B?b252bEZqM21ZL1BKdHlVU0ZjbGVLaVF5QWRJemhDSGhFMThrUUJGZ0VMNDcx?=
 =?utf-8?B?VStvZFFuc3RNYS95SmQ5cGVEQVhlWG56em1BQ0o4djFiYmM5NjI3aEJYWmNr?=
 =?utf-8?B?d1JGM0svY3RaZUxHdGtRV0lnSnE0MVk0LzdmKzJCVlZHL1pBcUphekdXYXdL?=
 =?utf-8?B?R2NzMWtHbjFvRmxRQWhsS00wcVJrd3ZIMVB3eUVkdEtadTdhWUdYS3FBaUlk?=
 =?utf-8?B?SzYxa3lrd1lOcGRJV2RTWEFKZ0dtK3dEZDVtdlc3bktLVVNaaEpOYXhvNi9R?=
 =?utf-8?B?MmJnT213WFlST0NRbjhENHIwRnVjb3RpZzEvU2haUFFwWHE0aDlwMExVN1FJ?=
 =?utf-8?B?ZTJWTXBESFlJMDBiVTFvcmZJWDdNdGdMNjJnYVQyeVpXcTc2enQyMmpESTNj?=
 =?utf-8?B?cjJVY2N3RzROamwzU2Z5czYwU2l0YXU3TlhpR2haazBIVE5JSEZVSTRoWVEy?=
 =?utf-8?B?MVAySkQzdmVtc2RZMFU3QjFWY0VMMFg0cGNkRlpyVlFkZmdiS2x4M2ZDalkv?=
 =?utf-8?B?R2x2alBXTWNOTzAvRVlOS2d3S1FwME5aQ1dGOXYwL1RxSFYweU9SQ3IxT2JH?=
 =?utf-8?B?Vi9aSXJFZHl6OENXNlZIb3lyZllMTVlldUNlYTBwQzhJV2o3T0dyazhzM3Ey?=
 =?utf-8?B?WUJDYlh1dEJEcEU2c01laDlKcTFLWFlkRHBLSEFEdTZEZTd3dEhSaXFub08z?=
 =?utf-8?B?clJSVVdHd2svRXNkS1R1a1Q0Yy93NVA0dTdzQzZJVHI0c1JhR0NmR1VDaXNn?=
 =?utf-8?B?eGJiMGRhUTh5cTNlSDd4NStab2FCcDlvbFZBWFpDb0U0Q09MVnRsZExvQzJo?=
 =?utf-8?B?V2VlVkFiZDNlNEdaLzhFZXRZRitHZUFCQmU3WVFvazdEcVZGSitSSndCeFNw?=
 =?utf-8?B?M2h5R0lkUUJWNUR5ZjdPOGJ1WHNFSVI4UGlJY2F3cWMxQzRqaTByNXR1T2hr?=
 =?utf-8?B?YlhrL25JYlk3blBxT0hoSDlOeDhoaEZUbTJhNk9pbVI2YlhTWDVBUVFXTUZQ?=
 =?utf-8?B?Ui9DSTNmQVBJTjVQY2M0a09XSTByU011QmVoNVgzK09McEF3ekJDSUoyelpw?=
 =?utf-8?B?MW5IMU9FNWlRTG5kNTlrSFJXVmlTSEN6VVo1Y0xuL2VsdjlZdVR6QjJuTzJI?=
 =?utf-8?B?ekdET3pEZ0JXdEZ3TUlDOFdHT1ZkQWlPaHZHYVVsMHQvTGVFa2c1WG50SE85?=
 =?utf-8?B?Z3Q4SDRidUpKQ0hJekpSaENXUjVsZmltWkdsbE95Q21DelI4UXZPQXUxYmhu?=
 =?utf-8?B?ZWRNakUrK0NqalJtR2x2MVJXejZ3R294M1NDL0ZZbUpFTHZZZWE4WUV5d2VH?=
 =?utf-8?B?Sy9XazFPd1dMdlEwSElGSlhhUU00M0xjaTdHbEk0LzJaay90L3pjR1o4S2d3?=
 =?utf-8?B?SXNISnpHV0JNd0pyNnUvUElXTEJtdUJuOGh1cGRIK20raFJSb3FqNnZSMGQ4?=
 =?utf-8?B?MDhiOGJsLzB3Mi9XczNyOUU2QWpMV3RHeWY0MVVFR0MrVlgvY3V1dVNJNVJB?=
 =?utf-8?B?d3ppZjk3WTkrOUUzZThlV3V3cWdCM1lGV0hKeHhNVTlpS3pia3RCMDNSUFBY?=
 =?utf-8?B?WCtjUGg1aHUvbmdnQkVLdUs5L3JjMEx2cjRaOHNtdE9aOE44NHYzQjZNTEdO?=
 =?utf-8?B?Z2h2K3cwRy9SNVFEd2FxR2JFNi8vM3dqN3NndWJaaFUyWEFXSHNhenN0b3VC?=
 =?utf-8?B?UVBEM1pGSHV0U3lxL3dlbEppeVQwYzFMVmxyYXZWbnBtYy9ZWi9jUEcvSnVR?=
 =?utf-8?B?SFNMQy9JeHFOZXU2ZmREbnltY0JydC82OUVyUGJLbDkzUUJuM3U3cHduK2FF?=
 =?utf-8?B?VEtTUksvQlJ5UW1Ea2lJV2ZIUVNMZzlQdU5IWUhsb1hTZXRZR1ZqVU9UZ01q?=
 =?utf-8?B?K0FYYy9yOUFHN0Vvbkg2ellQeDRzaVNKWlg5YlFESmIybnZiZEZmU0NMVmNs?=
 =?utf-8?Q?QkIVB/HxiFp4GoTtK8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61606b5e-a283-4d16-9a55-08df38dfdf3f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:50:28.5697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzOV6f/gQZdKaYX6KewRBwIHyawQaWbG5Ja3NIKW8nD6vPH4uxCVjxee6sYEaZnX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/31/26 05:28, aarthex wrote:
> Hello people,
> 
> Currently, amdkfd provides no native way to integrate itself into a wider event loop (like epoll or Wayland explicit sync) using standard DRM fences or syncobjs.

Yeah that is completely intentional.

Background is that the semantics of dma_fences/DRM syncobjs are incompatible with ROCm or more generally any compute stack, Intel (XE) and Nvidia have the same limitation.

> There are some workarounds, like creating a syncobj and then signaling it from the CPU side after the GPU is done, either via polling or hardware interrupts.
> 
> But none of these are very tasteful, especially for something that is ideally the driver's job.
> 
> I opened a feature request for this on GitLab a bit ago here: https://gitlab.freedesktop.org/drm/amd/-/issues/6013
> 
> 
> Before I work on implementing it, it would be nice to know if the team was open to accepting this, or if anyone had any thoughts/architectural pointers to leave.

It's really good that you asked before starting anything because stuff like that is completely impossible to get right for dma_fences and DRM syncobs.

AMD and Intel are working together on a eventfd based approach for their compute stack to replace AMD specific KFD events. If you are interested Srini can point you to the right patches/components on the mailing list and in code.

Regards,
Christian.

> 
> Thanks,
> Arthex
> 
> 
> 

