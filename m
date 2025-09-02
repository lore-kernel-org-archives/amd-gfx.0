Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7E4CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4250A10E71B;
	Tue,  2 Sep 2025 13:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XRdSwXUg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB2310E71C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYmwoQ1QD6ayrTPksqDwns9tIfJl95LGPoJer4JXrFPAzxwuq7VtdgJKC+jR2Hb4g/XJJMaGXGrfOMMCthjgASdfj+hvOm+rXAbOHmaMY09kYusXdchDRku0yolbpH5XhkCWD8Dw+CifcHm45nFEGwXy2yOxD4oBm/stlFRIwspdyGDja06fXSxMM/aEiqNef3uKnqljUilwtyKVM+gU0FQKs6gK97XqN9kq0uL3ad/kiqcr1yoYH1rpw1NBKaabgo0FM7vphIMJt9SH+1vnX/4mSTZWSOP1vSts5CnlmOr1MJN6gUuA5dwIgjZqPnH6uONyZc1HyNkfjmBpBWoC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0/gSKxVuw4TsFZGgIUOytrZY0Ybhx6ut8lgPAJ0nkY=;
 b=wog2PGxn8W7xyI7j9ltgsWrBdVCtvKitSnqpRgwHBrSb/PZ3hg4xNGn34pUDF1wZCDxb0nezqUBVKb0M+95RxoFIo9BoBXuXQL1rLxbscseN7OzWehofl9vdSj6WZfRx38TaqCtDSIylFcUMOdswPeWvPHWlDeKy5i3ZgVw0lfXhllNnJFW5VCJEuFmNzWBn2qucPj2R8wCNqqscftrXBQmaLUs8BekgN0AmDghXyvP0qsP3MbqOkJsIy1ZCnRJDQIvBogVN2TBnBPBRc7gaM0SKwVg7pD/p3S4cU/bzYScZtjpGDlcM6rku3ebezhcLBNi6HatqYMjLZMBe6uv9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0/gSKxVuw4TsFZGgIUOytrZY0Ybhx6ut8lgPAJ0nkY=;
 b=XRdSwXUg3RLMkKwryW2ZKpr/AFMrc/egDc4zlRKQjIokpZDCC1tUpeIwl8QL5wHQLnkpKSYs9j+juLpYJnf6TPhJ+YchMoCeLflv9c8/QGREfVN5iDuq0r9eSk7oQO9BgYELItBt4YzLsjWwVzyXjnLc5O4y9aFEaixl9PnZxd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:41:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 13:41:38 +0000
Message-ID: <963f3180-36ba-4c14-828d-5dfb9757e506@amd.com>
Date: Tue, 2 Sep 2025 15:41:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP
 Singleton
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
 <20250902032938.468332-8-srinivasan.shanmugam@amd.com>
 <c1e61d59-b8e7-485d-8e75-34bc306a430b@amd.com>
 <CADnq5_O59on_=wt6ayS-JWY7ZVCzO0EdvikeQAAv6hG_++bZxQ@mail.gmail.com>
 <50b38fdd-93c8-4176-affc-6435aac7640f@amd.com>
 <CADnq5_OonK_eFiom_0VnFzSEJe2Z=CUSxK8nSt8QFq2bkLfHnQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OonK_eFiom_0VnFzSEJe2Z=CUSxK8nSt8QFq2bkLfHnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR01CA0010.prod.exchangelabs.com (2603:10b6:208:71::23)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: b9692cb7-81e6-4714-052e-08ddea2670f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1BTNEhnbWdjdGo3S2lUZ2Q2eWVSR1dPWVI3VVhUWWdZdmtLalB1Y2YwaTkv?=
 =?utf-8?B?SW1NQmJObEhtamNQRTA3TG9qZkt0bVZTYkQzYTVXSGFSTHFhOTBxaGtYRjI0?=
 =?utf-8?B?cDc2QVhXcHhLTVJOT1RsS09TZlYwSHlTbDk0QlhXeTk0V3RDaGZyUkV6dFpl?=
 =?utf-8?B?Qk9JM201TWgzTVV0ZGdoSW5PT1RDWjU1eThabjZ0VGtXamlZcEkwZ3dBeTZy?=
 =?utf-8?B?R2hpSDJVYitHckFDTkQzZkdvaXpjUzg2UjhyNkpMTWVJTzFsWFV1dFdRL2Jx?=
 =?utf-8?B?ODN2U1ZIS1BkQy8rMHJVTjdaaU5oZmp6b0Vzdk5lK3M1c3VLanN5WDE1N0xt?=
 =?utf-8?B?RTFkdExORzZaZEZONEFCM2pNcFhwTDlydFhiUTZCZ3cyQzRnWUQ5SzhvQlFO?=
 =?utf-8?B?dUxhM2xPcEJGbEFTYkdWY0czeVBtaklFWHVGcll0UEhlSWVrb2VaRzJ5dGRk?=
 =?utf-8?B?ajE3ZHJMdzlwanRMTHNzdTJZYWpldUx4T1d0WmZpVE4vc2NPaEdQVmh6Q0c0?=
 =?utf-8?B?MmRobmZuMkxNQmtleDBmUEd6Tnd1VUlreFJRUXlNQVRpVmFGOWl1bDlkWk0z?=
 =?utf-8?B?WlovMWlldkRSb2wxS0llL2tFNUJNOTgvQlppNTZjcWpHOUlUejhJWkJMOFVV?=
 =?utf-8?B?Q2piL0RKMXEzQVNpWGczZ09oTCtzRGFwNVV6OWx5Zjdma1JqSEVQdXErUSt6?=
 =?utf-8?B?ZFFESjNXMWRxTE5QMVlLSEdPbksrYmZMUkh5bGM3UDNISlV5YnY4dGRvUXV5?=
 =?utf-8?B?UWkreElmUGtaZ3pCUjNLcXY1ZUVuUlZpUVMwWjI5YjB2WTVDUUhqZGtaVmxk?=
 =?utf-8?B?Q3BaTnFCb2ZVOEI5M0RJQVNjUlpZSEhXUkdDS0dHL2VYczUzNXZISGswYS8y?=
 =?utf-8?B?M0dtaVY1dDdKSzdvcGJMemNpWXhObFJManBLSk1Vd2VlUzhtb0NkRU9Kcjlk?=
 =?utf-8?B?UmJELzN2cjhMVElFeTQzUEF3Nm9hQTZueGw0bmsyVHA1Zkh0NHNQOUpMeFRI?=
 =?utf-8?B?QUZDMTdMNGc2b2dyTEhkSHliWmVaeE9sR2JlV2dxRWVDdFZMVFZrRmVHUHBK?=
 =?utf-8?B?Y0lGRVUvZEN2MHdPVzNLTG50cjZ6ODVHL2I4Z00zWWFNdmc3djlnSHdZVDJN?=
 =?utf-8?B?cHRNWHVUdGtMaVZnUzd2dXFYQWRQNktab2RpbFRWdWpYU2lwdVBFbnBnb3JY?=
 =?utf-8?B?Vkp0em5wTnVPUkw5V1VLaTM4dUZKbGpTdUlNN2JEeGk1Z0dwM2psSW94UE9Q?=
 =?utf-8?B?TUJZRURveDNxZnBQUVA0blJIOEJmV3kvTUx2NlB6VW4xUjFOZ3V2MHZ4Tndh?=
 =?utf-8?B?OURSck45QzVBTDJaejFPa3czQ1VLMGpKd2FybVFON0lNYzBscUFUdzFnWGp5?=
 =?utf-8?B?ZEY5NFQ2TlNiQ0UvN2FMUGduVE04MmduUzliclhORzdGYld3Z1VXb0NQMzlI?=
 =?utf-8?B?am1VaCszZ2FoeHBQT2t2MjRTeE9qNS9zRi80Vld2eVdOYlhteVpqMUtQWFk4?=
 =?utf-8?B?dlVHb0xSaDlvNkJud1lYUUY1NTR4RVpjc01KNDJDaHIzV1EwV0ZJMVlJdENK?=
 =?utf-8?B?SEQzUTVKODgxSWwrQWVTL3RnREwyamttYXNLQ0I0S1k0VjRKREJHemtPV2ww?=
 =?utf-8?B?c1ZiMy9uOGY0OSthM0gvemo4RVV5biszRDZpT2hEREdUZ0xmakJ5OEZ4OGt1?=
 =?utf-8?B?bjhVNmNmZ1dIWTRFWUdCVXRaYU50QmFSMDBHZFJzVjB2dDhGUUVlWnVtYmV3?=
 =?utf-8?B?TncyYno2YzJQUHg4V1dFUGlVRVB3TzAyYWlnb2VmelpXYVArRERvQWpIanZz?=
 =?utf-8?B?Z2UrU21KOEJJdHdEdGpWRVI3RlA3elllUUt0RmZYL1NkSFE2NjQ4NGJ3SmEx?=
 =?utf-8?B?bHBpN3lGTWxISWl0NVZGSHMwczI0N0hKaUl3NzhvVGcxZEtkWHhYV0hQdlov?=
 =?utf-8?Q?lsyOYX71raQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpjRHRCUWVVYW1DdzgwNjFXYjdYQVdld0RZK1VFREI3N2FwZXR3dVA3OTR0?=
 =?utf-8?B?c0I1bDB0QUlFWnhzd0RJRVR0d3ZLS3FJM0ZGOHkzWUdpbjI4OEhPd0JTeGhN?=
 =?utf-8?B?SVQ4Z3FFalJoOWdha1FFVTJSRzZ0SG9UeG84V1Y1VmtvUmF0d2taQWxIV0h0?=
 =?utf-8?B?eWp6UERnT1g5cjVtNm5naFlCYmtpeTZHNCtvMlVtTm1FU1Q0akkxRWNrOWlr?=
 =?utf-8?B?MjVSSVFmN20wbFJ1ZG81Vmx3U25QWGhSVEpoM2NLdVdCa1BIWVdsekgxWEZ1?=
 =?utf-8?B?QTRBRDVseW1yQzBDdUxkcFE2TEZ5WVpmdldOZ0g2VmMvOEppLzgyNS9pUm4v?=
 =?utf-8?B?WlU1Y2pRby85UU5pL3psZXZmQW9qVmt1UVRiTXN6R0JXWTFONjFTekZzMnU5?=
 =?utf-8?B?TFpNTlRrT3cwdFJOczUzREp1MTl0ajhPc1VxMDNSdmpHZVNWWTJLQnRxN2dt?=
 =?utf-8?B?aWVmRHQvcndsdlF0c1BkUzFRTWRET0xnMDJ1bDZFUnVDSkxiNE1GKzd4NVVJ?=
 =?utf-8?B?Uk1lbFp4cUU4TVlEYWVnQjRkMXBodjcvZnI0cWVVa3VTdmNvdmt6NU4vL2M3?=
 =?utf-8?B?dzlEUmJoUWltTThJdStQdldNMjFwbnZ0ZU1zYVRlY3lWc21XMWxETldDdDVC?=
 =?utf-8?B?QXFDUWc5eHE0TUlDVnpjYWFKU0lSV01SYy94anBoendKSFp5dXo0Uks5YTgy?=
 =?utf-8?B?WCtIcUJ0V08yMzljT1dVLzBycHRaN0ZNUFF0L0prMWRYL3lEb0w4MUVoaDl3?=
 =?utf-8?B?STAyT2p2VFBSUDhxTTJiZDhjZ21FSWR4aW9DdHN0WHludk1ac21TcTk1cFRy?=
 =?utf-8?B?M0FjN3FPdDFDWEVRUENnVjZ6YUhoeXpuYWpUemJZWndldE9KZ29wMjFXUlhY?=
 =?utf-8?B?RTBaVm1CTHp6Q09yVTNaZUx3cXhJMlpWWHF6VC9DcGtFTVdsVEZxMTFJSjBQ?=
 =?utf-8?B?VnduMjlIelo0MExVQm1sUHI4R1FLK0lqT3N2bzdCak52N3JKRDA4b0pmR1RK?=
 =?utf-8?B?K3pTRVJRMGZ5WUZRUXNhbklPemR2dkJRQVAzNzRYNFBwajNDRHl2UU5mcVBi?=
 =?utf-8?B?bTRxRVM4Y3Rxc0JScVVJOGcxanZMQW9ZTm5CT0ZPT3I0a29pamlNd2NmbVZr?=
 =?utf-8?B?TXUxWVlWOFIySDhYOU53aWZnUjZycWwyTjNqUkJyeHBlb3cyallxN0o2aHJJ?=
 =?utf-8?B?ekJEb3lSZWlaSnRrSUd0UHIzcW5Lc3o0SGJJZzFWcmdWekliRmI5WjIzWUkr?=
 =?utf-8?B?dmVjMTRwNnlCZ010THZLSm10dm5Pc1AwVm5sUDROSXlreFJYVnRjUDJSaEdw?=
 =?utf-8?B?SGFlSGxHVU5HbWp4RWVkTWdwQ2l3MTJXN09wcjNxRDM5WVFBaHpqMWVKUXFL?=
 =?utf-8?B?RW1HYlVkQWtObW1UVHhEc3VibVpVTlpUczJvamppNVVXR0tWTmpQSit4azZH?=
 =?utf-8?B?V2dueHVpampvTDVNSHFhM2NtdXhQREhUTEZkZFE0amJZdWJaNld5OFF0bHUy?=
 =?utf-8?B?QjlSWk5RNXZuc043WGpxNlpuQTVYbVVNOEZWbWsvVXQzOVpEc0dwb2NrRURM?=
 =?utf-8?B?MEFZZ1R6MnFFUlZ2V2s2R0s5UGhLQ09vNXF3ZlBwNUF0TktkQm4zeitucTkw?=
 =?utf-8?B?cExzeGJnVW92WDhDMnl3WDQ5N1VRWEh6bXhxZ0JHZnhXbUZJR0xsWjhTMG5F?=
 =?utf-8?B?YytDNis3bE1DcXZjQlhrVEtZeTFWZ2pRaTR4M1pDZkJIeVlhT1JWV1lnTXlX?=
 =?utf-8?B?UGJwZ0RBQ29sZHEzMEpOK1UzeDZsK3VKNE5oQ0VqTXlUWnVuaDJpZDRvemNN?=
 =?utf-8?B?ZW15ZXdrTUpWdjU0UjlsdEIxSjd5TVpsTXFHUEVEVkMwL0dialZLdFkxbElK?=
 =?utf-8?B?VDU0a3Vmc3lJSjRPN2VPdzcvQmhWMnRVZmU0bk9Hb2xNRGtlQUJVNmt6WHov?=
 =?utf-8?B?UDBCWVM4NkRqY2ZleDFTNzFYQkJ6Qkh5SWpEQ3g4SXpRSHJQSHZxL1hEb1NU?=
 =?utf-8?B?U1o5ekNyb3Z2anVpS1pvam1SaUdOMmRXNnc3c3FmekpWVDFpcnl6T3lmM29G?=
 =?utf-8?B?b09XVDI1K2Y4TmlodUU2NklibHJuVis5azVEYThsak43M3Mxc2tiMkNaNmdE?=
 =?utf-8?Q?cQe1jPN5V6eQ5kHhQVkZBe6Wd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9692cb7-81e6-4714-052e-08ddea2670f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:41:38.3581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwRHG4cRvYn7JQcIVMMhCWwc0U0emBYr/J8TIy64gJyApxrY7urymAlEZQXkXlMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
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

On 02.09.25 15:31, Alex Deucher wrote:
> On Tue, Sep 2, 2025 at 9:27 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 02.09.25 15:25, Alex Deucher wrote:
>>> On Tue, Sep 2, 2025 at 3:38 AM Christian König <christian.koenig@amd.com> wrote:
>>>>
>>>> On 02.09.25 05:29, Srinivasan Shanmugam wrote:
>>>>> Add mmio_remap bookkeeping to amdgpu_device and introduce
>>>>> amdgpu_ttm_mmio_remap_bo_init()/fini() to manage a kernel-owned,
>>>>> one-page (4K) BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP.
>>>>>
>>>>> Bookkeeping:
>>>>>   - adev->rmmio_remap.bo : kernel-owned singleton BO
>>>>>
>>>>> The BO is allocated during TTM init when a remap bus address is available
>>>>> (adev->rmmio_remap.bus_addr) and PAGE_SIZE <= AMDGPU_GPU_PAGE_SIZE (4K),
>>>>> and freed during TTM fini.
>>>>>
>>>>> v2:
>>>>>  - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
>>>>>    rmmio_base. (Alex)
>>>>>  - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
>>>>>    (no warn). (Alex)
>>>>>  - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
>>>>>    is stored in adev->mmio_remap.bo and will later be exposed to
>>>>>    userspace via a GEM handle. (Christian)
>>>>>
>>>>> v3:
>>>>>  - Remove obvious comment before amdgpu_ttm_mmio_remap_bo_fini() call.
>>>>>    (Alex)
>>>>>
>>>>> v4:
>>>>>  - Squash bookkeeping into this patch
>>>>>  - Place longer declaration first; clear bp via memset
>>>>>  - Reserve + pin + kmap(+kunmap) the BO at init; unpin in fini
>>>>>    (Christian)
>>>>>
>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 87 +++++++++++++++++++++++++
>>>>>  2 files changed, 88 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index ddd472e56f69..24501d3fbefe 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
>>>>>  struct amdgpu_mmio_remap {
>>>>>       u32 reg_offset;
>>>>>       resource_size_t bus_addr;
>>>>> +     struct amdgpu_bo *bo;
>>>>>  };
>>>>>
>>>>>  /* Define the HW IP blocks will be used in driver , add more if necessary */
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index 1a68ba17a62d..0d03e3a6f92d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -1854,6 +1854,87 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
>>>>>       adev->mman.ttm_pools = NULL;
>>>>>  }
>>>>>
>>>>> +/**
>>>>> + * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
>>>>> + * @adev: amdgpu device
>>>>> + *
>>>>> + * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
>>>>> + * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
>>>>> + * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
>>>>> + * GEM object (amdgpu_bo_create).
>>>>> + *
>>>>> + * Return:
>>>>> + *  * 0 on success or intentional skip (feature not present/unsupported)
>>>>> + *  * negative errno on allocation failure
>>>>> + */
>>>>> +static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
>>>>> +{
>>>>> +     struct amdgpu_bo_param bp;
>>>>> +     int r;
>>>>
>>>>> +     void *kptr;
>>>>
>>>> kptr should potentially be saved in amdgpu_mmio_remap.
>>>>
>>>>> +
>>>>> +     /* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
>>>>> +     if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
>>>>> +             return 0;
>>>>> +
>>>>> +     memset(&bp, 0, sizeof(bp));
>>>>> +
>>>>> +     /* Create exactly one GEM BO in the MMIO_REMAP domain. */
>>>>> +     bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
>>>>> +     bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
>>>>> +     bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
>>>>> +     bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
>>>>> +     bp.flags       = 0;
>>>>> +     bp.resv        = NULL;
>>>>> +     bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>>> +
>>>>> +     r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
>>>>> +     if (r)
>>>>> +             return r;
>>>>> +
>>>>> +     r = amdgpu_bo_reserve(adev->rmmio_remap.bo, false);
>>>>
>>>> The last parameter should probably be true here.
>>>>
>>>>> +     if (r)
>>>>> +             goto err_unref;
>>>>> +
>>>>> +     r = amdgpu_bo_pin(adev->rmmio_remap.bo, AMDGPU_GEM_DOMAIN_MMIO_REMAP);
>>>>> +     if (r)
>>>>> +             goto err_unres;
>>>>> +
>>>>> +     r = amdgpu_bo_kmap(adev->rmmio_remap.bo, &kptr);
>>>
>>> Can't we just skip this?  We don't need the CPU address in the kernel.
>>
>> I thought you suggested to use the remapped HDP registers for the HDP flush in the kernel as well?
>>
>> If we don't want to do this we can just skip this.
> 
> In the kernel we just use the existing mmio memory map via the WREG()
> macros.  Using this other buffer would just complicate things.

Ok in this case I misunderstood you. @Srini please remove the kmap again.

Thanks,
Christian.

> 
> Alex
> 
>>
>> Christian.
>>
>>>
>>> Alex
>>>
>>>>> +     if (r)
>>>>> +             goto err_unpin;
>>>>> +
>>>>> +     amdgpu_bo_kunmap(adev->rmmio_remap.bo);
>>>>> +     amdgpu_bo_unreserve(adev->rmmio_remap.bo);
>>>>> +     return 0;
>>>>> +
>>>>> +err_unpin:
>>>>> +     amdgpu_bo_unpin(adev->rmmio_remap.bo);
>>>>> +err_unres:
>>>>> +     amdgpu_bo_unreserve(adev->rmmio_remap.bo);
>>>>> +err_unref:
>>>>> +     amdgpu_bo_unref(&adev->rmmio_remap.bo);
>>>>> +     adev->rmmio_remap.bo = NULL;
>>>>> +     return r;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
>>>>> + * @adev: amdgpu device
>>>>> + *
>>>>> + * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
>>>>> + * amdgpu_ttm_mmio_remap_bo_init().
>>>>> + */
>>>>> +static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
>>>>> +{
>>>>> +     if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, false)) {
>>>>
>>>> Same here.
>>>>
>>>> Apart from that looks good to me, feel free to add my rb.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +             amdgpu_bo_unpin(adev->rmmio_remap.bo);
>>>>> +             amdgpu_bo_unreserve(adev->rmmio_remap.bo);
>>>>> +     }
>>>>> +     amdgpu_bo_unref(&adev->rmmio_remap.bo);
>>>>> +     adev->rmmio_remap.bo = NULL;
>>>>> +}
>>>>> +
>>>>>  /*
>>>>>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>>>>>   * gtt/vram related fields.
>>>>> @@ -2028,6 +2109,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>>               return r;
>>>>>       }
>>>>>
>>>>> +     /* Allocate the singleton MMIO_REMAP BO (4K) if supported */
>>>>> +     r = amdgpu_ttm_mmio_remap_bo_init(adev);
>>>>> +     if (r)
>>>>> +             return r;
>>>>> +
>>>>>       /* Initialize preemptible memory pool */
>>>>>       r = amdgpu_preempt_mgr_init(adev);
>>>>>       if (r) {
>>>>> @@ -2091,6 +2177,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>>>>       amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>>>>                                       &adev->mman.sdma_access_ptr);
>>>>>
>>>>> +     amdgpu_ttm_mmio_remap_bo_fini(adev);
>>>>>       amdgpu_ttm_fw_reserve_vram_fini(adev);
>>>>>       amdgpu_ttm_drv_reserve_vram_fini(adev);
>>>>>
>>>>
>>

