Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEF9EFB801
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8A010E4E4;
	Tue, 24 Feb 2026 08:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oFFxqn6B";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E820810E4E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx/9plgSqZrUVwxdgibJwYy/ZsCad+qqv/gZ65ZzQmnKt39vKnLaCJvxNGAOxwh8nOTJGudbjlbE/1l0jvQnl9VTirDuhQyO/kxWGzjHq/PLe+jR7tpMIT/Wurzb440eJHU2PiEbj+9r2sceEkVt8N1E5VsjV0mXVwn9CfQ49zT/c5bjvK6ZwKJEKXYPAn9ltQarlfbXegZisfehrM5GfNl5SzrEvf9vZSUjde4FzuN2LfbwnUOx41Bpm0Davf3vZG5+rn7HAezlDFJTSOUeCZt/52odaUtLBo0ZGuePnf/TlIXLX77tqJ7kg/ZHkS3NuyPVuaAdRUUelennj6svag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHmNP030f+gg36WwCGSkoDkXGV3lboW7NI8g5Q3MUG0=;
 b=RgXQrEBlg998rLSpZc8zq00ET6PbFyNtjdzcIWl+2SxvTp/dE1gUQpqH0AHFWmyyGaIqvwA49GrtN50WGsLFaLDoAga3iYur4T1OnZbzN2mLvTjEiluIQhu7GETkebhIwtJ37vgEH82lpZD2/xVyD4ZXoRRCNweWGRV9ghiDq+kcKXpAu9iCBo8Kx5O4qlAcDz13HJmwcYgMQiJHdZl4CLRXfVdCJihBnChOLfx8NVFL2tzkwVhqv+/e5R3xXBUENXjWsCK1j/AM8BLc0HneGRiCBONiDJBAsJcmsSnsL8h5h5DqGZ5t9vW4mxIX38yvqgkG1Fm2EP8AYcr1lll6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHmNP030f+gg36WwCGSkoDkXGV3lboW7NI8g5Q3MUG0=;
 b=oFFxqn6B90vu1wTUpRgUdv978e2CkycpYJVlMHWmWWQPslatOP2remhnT4CTaItp6GRKpn5fObra58i94eKpOH+Cw6Ren9zjQC+Tz/Pdl1+EZnpelkIKPkL56a7VZvXV8YRyoJsgajYHruGmXxHDyjEJdoSZkDLJGjC7DpAd+gE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 08:28:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:28:51 +0000
Message-ID: <9041d720-7cc9-4a2d-a5bf-1ed6ce7c4640@amd.com>
Date: Tue, 24 Feb 2026 09:28:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/62] drm/amdgpu: Fix locking bugs in error paths
To: Bart Van Assche <bvanassche@acm.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
 Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Jann Horn <jannh@google.com>, Alex Deucher <alexander.deucher@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260223215118.2154194-1-bvanassche@acm.org>
 <20260223215118.2154194-9-bvanassche@acm.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260223215118.2154194-9-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ac3370-ed33-4e35-6bc9-08de737ebd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajR5U25DbHMxVUpBaEw4QU4vRnZURzV3L1QwVE9Ba3JCWnBqdjJZcGVZN3Bk?=
 =?utf-8?B?RjVoSE1ydWJNZ2Ywa3N2Wm9EUnphc01hSlRNTGQzaXR5Zi9SODlIK3dtb0Q5?=
 =?utf-8?B?RmFWSFIrZlBqb0NRZVdMNk1qM0Z4L1Yxck5HNTRDWjFTUGZkMDRRRFRlNkJs?=
 =?utf-8?B?cmlzV1lObWFKWUFvc0FlaWhlMi9PUm9Zb1VlRnBZRC8xeU0rNzBLaThIdXRL?=
 =?utf-8?B?UDNPMEtWWmU4MTQvdGhwQ3VKOFhFRWFHbHNqMmpFN3dCZmRWVERUU2NYaDRQ?=
 =?utf-8?B?ZUkzSnU5VnBKYnVkN1N1N2lOV0lkZUNVWng3a0phZVpFakJkcmVXalNtdzl1?=
 =?utf-8?B?M05EMGpqc0hEWTl5YkdrL2ZnOFpyMXVOdUVrbEJNTGdUcU5Md2VUSGNDRHlh?=
 =?utf-8?B?QnJCSjVjdXNpOGJTTTcxQjhCK2UxcjFSSUFoeGc1bmRoWm5zTHZ5VkJqVmh3?=
 =?utf-8?B?K011MjVTV3JOMkhvV1k5QmxkS2hpRHZMRHViaDV2NEt1N3NOYjdoVUhyR1Bn?=
 =?utf-8?B?cWh2dDFDLzBsNmRGUFZIL2RDSHhnRFVucGc4K3JJUDZwWmt4ZXdNMHJUeFlF?=
 =?utf-8?B?ZmtvZlVndnVHcElybU5qbzlYZ2RTbmdBakhBelN5RVFFRHgwTEhWWlRHY1Fu?=
 =?utf-8?B?bUpOME04YjdkWDFHUlZpa0doU1EzZjllY2I0Z09xc25ORC82d0llRzkzdWFQ?=
 =?utf-8?B?ZDhZSVVMbnB2YXBLZUN6Vk1DeWhwbVRHMU9yMmxXVXhHL1g1anB5WldDSzhx?=
 =?utf-8?B?TUQvMFZVWVJkZlovbFpOeDdUS1pwTHBpOHR2Nk9Vcm50Q2hWZnBhK3dNaDZF?=
 =?utf-8?B?SDNabXlsWFNpOC9hZkRWQnFubjM3a2MyYk83K0hZNEd4TVhpa3c0YUNXOG5y?=
 =?utf-8?B?cW16OXFNVUpRMjdtckNqOEkrUjdFVjVkamI3V3NTd2NHVFVFTm8wN0RFRVdq?=
 =?utf-8?B?WCtycWZwcWtvUnNWUW1BUkp3K21ZNFVRZlZTU3BCUmRlTG0yKzZ1Z1AyN0tx?=
 =?utf-8?B?MmtUWWRXRnV5MVVCWlI0K3IxMFpqOG0raVNheGk2elR0bWsvS1lrMCtUQkNu?=
 =?utf-8?B?dk5KSk5GYkhmYlJ4anIwZTBsN1JzWEYzeDVJYy9vWHBLcW1nSHIyQXVGcGRx?=
 =?utf-8?B?NWRGdmFXQnQvT3JiRmpGNytpdUtTdFROZEtTZGZaQ2p5dkE4d0kySkFJTU40?=
 =?utf-8?B?RTlvMGdVeUlDVVBoQzJwQ3h0SHBFckY5MTArTTNZUTVTOVoyMEhsenBsMTQz?=
 =?utf-8?B?SThIYllCMzVHRDYvcWFVL0poSmFKdlJjU3FXTzNuN1lGM1NlaytZNm5IUmdX?=
 =?utf-8?B?YXBBeFBnRTVIb0NhdktGMEUrOXg4Wkl2dHNSeEYzVWk1SE9PdjQyOWUzcVNi?=
 =?utf-8?B?ckQ5MUNkMEZNWFg2aWVLZ2syYkdxT2FBK0xXbFBxMkFtZHVQY041a3JHNTR4?=
 =?utf-8?B?MFZjTlFlby9URCtUL045d21Tck1MbEN6QnZNM09GbDJoMjVEQyswMkovUElQ?=
 =?utf-8?B?QitTNUM4QldKaXNWL2Ezdnl1Q3VmQ0o0dU1KTVVtaCtaaVQwRmhTOGVNNGxJ?=
 =?utf-8?B?OERJOEVMdkJ3ZmVhSU5qQXcyTEd4Z2VOWThnTnFzb0lkbjNTZkRRVDN1eWpP?=
 =?utf-8?B?ZVBrWGJPOWdiOCt1MXFrdlJVdzlYUDlWZnNEWVdNQ1Q1MXhoWkRMM2t1RVE4?=
 =?utf-8?B?TzJHamdWVmhvNzVOUVkvUTlHM3l2amVWSlBOUEUwU3VjdVZhRXhKcUI1RmRD?=
 =?utf-8?B?S2dnMGlscFYzSTVpOUJMUnFOWlNYNVVkQnhYU3dVUmV4SDlONEFyWUQrK0No?=
 =?utf-8?B?NDBtUlpubEFud2JzMjJBYTJHK01lbGJjNmtJMFdRWUc1bjA2Q2RvR3A3OFp0?=
 =?utf-8?B?eGIzb0J0VEw3Q2VCai9OSmIxOXhIVGRyTkxzTTNnY2hpbHFOU01sWWQ1d2NL?=
 =?utf-8?B?OVFTaWlZRStYclBCQ1hiajJJbEl0VGdvcE5wWlpEQVlRSWNETnpOTlRyWFRh?=
 =?utf-8?B?TFh0enl0UFYvcWFvekkybHh1TUxMcGZMR1g1MjI5YXl1TkF1eTN4Q1pOS1J5?=
 =?utf-8?B?YWkxdFRlSjNDOEJ2aUlBRHdPb0ZocU1vT2xRWmt0OWJ1b1VBdTBZV2ZHTnJP?=
 =?utf-8?Q?TGow=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlZDcS9Bb3Bpbytod3ZNUTYzQ0JweWVEbzRqRjNPY0dRZGc1S3o0cEM0KytE?=
 =?utf-8?B?OVRoNUdRMUFmK3k2K0dpS1Z2WHYrY3NpU3B0c2w1TjhpRDFpb0xURGM3elpC?=
 =?utf-8?B?UW03MmxXR3Zkb0ZNRzdBSS9SVStGSGo5VFZscUtHaEpPVXphb2MwTGQ1ZUNV?=
 =?utf-8?B?RUNqQ0g3cEpVTlp3Wll4RTVkcDNubXlJSE02VXZCaklESmxIWWdpallqaHQ3?=
 =?utf-8?B?RlE0djVySHZBR0JSSmlLcmlGclBVeUhTZ1NueFlydUsxVWw3SVFUTXVoTEZl?=
 =?utf-8?B?bzEyM1dGeWJCa2NFRlVkY2kxQkFtL290RkNhWnZNd2tHYS9KVkFQdDhTSTB6?=
 =?utf-8?B?cndjZUplMkkwY1N5SzNIMStxTE5WNGNjK1owNy9hZmdEeWtHbk9nZUNSdDlC?=
 =?utf-8?B?U3FPNnRhdWxXTjh1Z3o1MkJlNjJQQnlWOTFWNzV2ak1ZUEYzeGd4RVE2S3NX?=
 =?utf-8?B?WW91bkVxb0JoRWJpd3hiM2FFMGJtV3ZXL1NERVkxeGN6U1NGNXhBd3U4ai9X?=
 =?utf-8?B?cGlZdEhRUFZsRVpmak5Od0xqU25BNGlUS2M4SWdod2dNZkJNam5aUXI1ZUZC?=
 =?utf-8?B?OTF6eUd3ay83WnlTdndaWnVYTlMzVjVLTlJRbFFnUmhwREFmQ1VmRmtoRzA0?=
 =?utf-8?B?VEs4enNkRCtYdGNXWjZmVksxRWVQdVY0K2x6RTNNU2hLQTJ1UGpjOGd1cWVP?=
 =?utf-8?B?ejVZaDJCZDIzSzJONHl1dzRuM3V3UHQvbk5KOVZ0UUpDamhidHVHWUJyWW5m?=
 =?utf-8?B?WFlOT0F2Nk5FcGdCTnN2aURlS1kvZS9lcTJncDhuNHNSN3phM2REeGpoSXM1?=
 =?utf-8?B?ME5NTjRseWlZWXBlMkFFOGUyQUxrVW9HaEt1bmZFYzVOcUpFWGdSd0o2bFZR?=
 =?utf-8?B?MEk1YmR6OC85WS9ETW1BenB4MGhJbHBBblA2NlFhQ1BaOTJYWXlWVnpIM0Mx?=
 =?utf-8?B?VnVjU0ZxVGtsNDBsR3RjMitzVW8wN3A2VWRZZmVoajIzaXIzbzdOR1BQTjA2?=
 =?utf-8?B?UzVPNkN6KzZmTkx5V25Oa3dWQTRlV09QQjBBemlpajVkVXNJWjZuQjVPNmRz?=
 =?utf-8?B?czRnS214T2hQb210RTFPQWdKcUhuTVlXcXNpNVFYV29DMHZuWmQxZy8vZXps?=
 =?utf-8?B?YTZaYWhTeERQYVorQUxtTm1LcVdsczJ1bmhkS3podTRjSzl0ay9iZDVrTmU3?=
 =?utf-8?B?Y3ZNMFpYVkFzTGQwS0pXcTdXQjdlUktud0F0N1VZOEt6YTVhcmFuRWlGMmph?=
 =?utf-8?B?QnBKUXpkMUJEYkcvUVRtQkRMMlB0eGpyMmw3QjQ3QmlEUUxFWk16cUlMOXp2?=
 =?utf-8?B?dVpNTlhOWDE5OWVOcTk4L1JtaVpoSmdWVklJeVoxQ0xpaHVHVjhHeUk1bGRr?=
 =?utf-8?B?R2kwUmt4dUJOamNYTndVSTU3VUlYV2l0UjJUV240NitZeEg2WWxQbG5TL3BN?=
 =?utf-8?B?cnh2L25kcVdRUTdMOHcyYTNiczNYeTYrdjBFcUlCSFlTa0ZMZHpXRm9BOTQy?=
 =?utf-8?B?eDY0bFBDeGljbmRXRXR2T3pqTGpXNXVvbVFFL1NuRSt3MFc1RFJUb0VNZkdX?=
 =?utf-8?B?dVBUUlU1WjlUQXlLdTRIcnEyK1g2MkFlTnBEVm9vRzZhMlE5ZWtJU001QWlj?=
 =?utf-8?B?eEVNZ2dkQytDUGMvOVhmbzl0bXpQMkdqSTcvVGJ6T2czcis5VXpsazFUOEY3?=
 =?utf-8?B?eUJVbzJ4YWNUd3Z2L2gyK0o3Z2ZwSkVPL0RRZ1plbW5TK2JuZG1HbmhqYWl1?=
 =?utf-8?B?M2tKSVBQTlQwNlRkQ3BTLzVWa0pPUjhZdUZEMVRmWEdFOVdjRTVaSnlsTDlV?=
 =?utf-8?B?R25WUVFTOThvR0VlNG9WU2VOb3U1YVBWaktqclNnOWlRWUdTSFFScW92T2h6?=
 =?utf-8?B?UjBJaUpWblNSc202RDNyNkwyRUVOSGZONG1WNjMyMlpIb2Q1anFlMnhLQStw?=
 =?utf-8?B?ZitwT2VOMVNzQ2FuL2FKcjV1L1FmT3I4V2tqNW1EbldsU3V0YjVneVcwLzUx?=
 =?utf-8?B?dmZrbmJtQjB6ZS9kT0lPNjBUemlQUXZrR3paQS80SnZPd1lucDlnb3ZvMkp2?=
 =?utf-8?B?SzZISS9JTmJ4Zk9tYmZYY1FwdSt4ZHJCRTB0TkZ2YzRFV1NnN0ZONjF4ckFI?=
 =?utf-8?B?TEFReFFGeklEWU5KSU50dzRlQVd0eGhzVC9md080M3lGcFJMR3pFVTUyZzdz?=
 =?utf-8?B?b3haMk4yb0NhWjFqN2tkVDRoMm9oQis0L1dNTmkvcmdod3J0N2ltYk1tMUsw?=
 =?utf-8?B?bXZGbmwyMldGZUx5ODI3WlJMWWhiaXJhclhwai9senpjU3lyL2w0RzVpRjVY?=
 =?utf-8?Q?FDJcekIl13oOEx2izE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ac3370-ed33-4e35-6bc9-08de737ebd2f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:28:51.3406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmTOQoge0D1QiKHOhJ2xY6aiZ2b9/QO0B/1ZjN8DxWGFR5FyMalg/Zk2XWNPWtMT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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

On 2/23/26 22:50, Bart Van Assche wrote:
> Do not unlock psp->ras_context.mutex if it has not been locked. This has
> been detected by the Clang thread-safety analyzer.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: YiPeng Chai <YiPeng.Chai@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Fixes: b3fb79cda568 ("drm/amdgpu: add mutex to protect ras shared memory")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index 6e8aad91bcd3..0d3c18f04ac3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -332,13 +332,13 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
>  	if (!context || !context->initialized) {
>  		dev_err(adev->dev, "TA is not initialized\n");
>  		ret = -EINVAL;
> -		goto err_free_shared_buf;
> +		goto free_shared_buf;
>  	}
>  
>  	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_invoke) {
>  		dev_err(adev->dev, "Unsupported function to invoke TA\n");
>  		ret = -EOPNOTSUPP;
> -		goto err_free_shared_buf;
> +		goto free_shared_buf;
>  	}
>  
>  	context->session_id = ta_id;
> @@ -346,7 +346,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
>  	mutex_lock(&psp->ras_context.mutex);
>  	ret = prep_ta_mem_context(&context->mem_context, shared_buf, shared_buf_len);
>  	if (ret)
> -		goto err_free_shared_buf;
> +		goto unlock;
>  
>  	ret = psp_fn_ta_invoke(psp, cmd_id);
>  	if (ret || context->resp_status) {
> @@ -354,15 +354,17 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
>  			ret, context->resp_status);
>  		if (!ret) {
>  			ret = -EINVAL;
> -			goto err_free_shared_buf;
> +			goto unlock;
>  		}
>  	}
>  
>  	if (copy_to_user((char *)&buf[copy_pos], context->mem_context.shared_buf, shared_buf_len))
>  		ret = -EFAULT;
>  
> -err_free_shared_buf:
> +unlock:
>  	mutex_unlock(&psp->ras_context.mutex);
> +
> +free_shared_buf:
>  	kfree(shared_buf);
>  
>  	return ret;

