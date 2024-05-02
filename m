Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A88C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 05:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20D910EB69;
	Thu,  2 May 2024 05:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lTeuf56x";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F2210EB69
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 05:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vls2IkrQXfjfjt0ZBZQbiWVLC2WVToJ4gK5auEYLFNpEfNsWd9tqpKy7MEsOeerYr7qZTRn38L9CT2zV81jh3Q94NCYGnfrpBs3ra0QKv10FZ2vuhlR4ZP+tUawTR6VnvXDx6gxs91Kd6MJ0pA9PxP9KoLTDOnNDNpZW2skqwVme1x4DlQpRj4Euz02FJ25UoAhk3OoKwGpQJpRt3h5awKXJLpj0zwj1Hc0JFIapfduD8Be+uW60AamN6roorQ9CBBtpKqasiLpTrFw6DpJOdo5d9W25fe2zvjyh5WTuevOCUKmxvIl2s+mZzvgTovcxQctHsfP/wTY7AQaLUeZ5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrZ6I/LrD9s2gzE/xl4dvBmibEnA3u3lj8QNz3f+Cg8=;
 b=PSdlWwUWmUBs4P2lzukAALF4TzGKj2ysFi7EMOD4DQ9/TlneImNKu3zTNkm96rE27WCa6tcERjXOPgjQXFgdhFsPgDmECN30Lu+JIlecEjpw6rKzNIm57NU29Of1R5SUVCujy/M/1vAOCD5mlEztu65i0K1QOtkOIy/eeVoV6TRdmHy4jmmrj1ImFyJfUwaKJArfbAkVf5QNf3lYLWAgIvfJuZ3bJHByzK/E4szCs0B1afQJ1kADGFsgGtvghU1uRpNZJbZwlQeAdDFQGdYVfInNi/lUxIkiNX9P8iIUYRvIxA1Ndo4j6nw3bJHCuWVrdWYiqK6NDc1biRG/rtuLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrZ6I/LrD9s2gzE/xl4dvBmibEnA3u3lj8QNz3f+Cg8=;
 b=lTeuf56xqgyVZrnHBJEePvnkSziOkEuh24bzay8hDHas4JnDaFb4ik5Px2bByGkIqi8+oCoY+Ueg0My2tpb30HoN3AdYc7aKNy0qYWSnaCix9B1A3lIgEr0JHKwZOnnqIDn9mVIgADKRX7+pjDqeeHVR0JiSoK2sfGEOngqiDqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 05:51:00 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 05:51:00 +0000
Message-ID: <1f34c3b7-0c3a-b83b-efe4-d3f5750cfa34@amd.com>
Date: Thu, 2 May 2024 07:50:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 13/14] drm/amdgpu: enable compute/gfx usermode queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-14-shashank.sharma@amd.com>
 <CADnq5_OQHhmPZXsPdQfygAR3=EsWMB3r3n=Y0ajJFBhA+voY+A@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OQHhmPZXsPdQfygAR3=EsWMB3r3n=Y0ajJFBhA+voY+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0280.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: c722a681-1ed5-4e0b-5b03-08dc6a6bd866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dldDZDZOKzdTYVVoMTN1ZVJNSnZBMVFHdEpzS05aK1NLM01Qb1htc2FMZmE3?=
 =?utf-8?B?OXNwQy9mQXRIZDJUK0NCUWFwZzd5RDhna2paeUdWeGQ5QnNUSHFpQkxvbVZW?=
 =?utf-8?B?NzBjMzlidkdCV1c5VG41MDg3Vk5XVUxYMXpGK2Rab0FEV0ZSRUQ3RTJjRzk1?=
 =?utf-8?B?Z0dvYWx1QXlLbmh5QTBMTWgyZlF4azE4UXN2SDZJZVdYQ0krV3VpRDJFSmUy?=
 =?utf-8?B?NWprTSs5TzdQTXBxR25NVlNtMlJRY1hSTW5CNHVVZStzbm95U2pwYjZwcXJP?=
 =?utf-8?B?MjRpbkNJYklPc1pyd2dhTitmNElJU1BFZ0FzVWNuOGNQRFE4ek16eUdZdkFP?=
 =?utf-8?B?d3YvTGVaOEFrY0czZlF4RHo1blZIaXRsVVZuQ2pnb1JhZjg5ODU0NHpZZ0lR?=
 =?utf-8?B?eW5nS0pUWlhtVXE1dFdidndkRzVONVdsdHc0ZEQzTlcxNUxiSGZnL1QzS0ln?=
 =?utf-8?B?RmgrUlJ1RlZlOW5lZ09PZ2RYb1UzK2dHeDY0OVNSWTdCclYrNkRNMER3Q2hN?=
 =?utf-8?B?OWttbTVuM2RjQkZtQlFRTXYyQllvdGwrSVJpek1ZNG4zNm5MaTZGVU56ZFhP?=
 =?utf-8?B?U1hyZGpZdWthSUxGM2c1T2t2RlRlREUvNkUzWDZKSHRVcGd6U1RWNHpuRFNu?=
 =?utf-8?B?NXRpTjBrNWtTUEd2WU1ONGp3RHVSRlg1aDUxYi90R1QrcGVUODJPS1NTd3Vn?=
 =?utf-8?B?Sk9Xc1dpazBJa01Cbi9XaGJ2N29LS21FdmtUYlpoTnRuN0JqYUloMFNqcTVB?=
 =?utf-8?B?V25RS0cydGdEbG9McnNpcXZVM09Mc0U4MnRjN2c5dVF2QUJ4RnRnZ09sVW1B?=
 =?utf-8?B?cGhGYWhNZlF4QU4zZklENnlWWXJLTURhSjNqVjVlRytkcm4vQy84ay9GYWVT?=
 =?utf-8?B?UCt0VFRMYnFIRnhmcVhMYVdQTWdEaXFObzJia0VsTUVBU2VpU2xxQjdzN1Ur?=
 =?utf-8?B?Ris2cWdGUG9nbGE3RFVCWS9ZUW5Gc3lLdmFRRDdONklEbG4xdStMSnpuQ1ZE?=
 =?utf-8?B?bXF2YnVyejNGbFl0VFBxd2xoWEdSeExyTTlqVkNvSHBnVDVrR0NmWXRjL3Fq?=
 =?utf-8?B?RDQ5MTlMdWdOZkp3YklrRWFLOFQ4eWNkcGF1bElmUHIzVTMwRFFpcjVqYU8r?=
 =?utf-8?B?TVRmaGlnRTYwUHVNV2VKYzRUT1JxVUs4VEc5YTBaNy8xQ3c2SVBPY29Kbkt0?=
 =?utf-8?B?dUJhMmpaZFhvaVVNazhMY253azlBMVJKUW9HalJBb0dSZWR0QnNnVkNsNkRR?=
 =?utf-8?B?TTYyV0tnZUFCeVlCRWNrRERySUxiUVpLVnU2QjZWUzBlVzJteTYzU3N6TlQ2?=
 =?utf-8?B?NzN6aFlGUHNDWDdDUjk0T0IwZ2NaZ1FqMk9OVWNoeUl0UWdObE4rZzY1THhZ?=
 =?utf-8?B?OE5xVFFFZnpBZ2QrVk5HS1FRZzdLR0dlNkdqQ09JL1VseU85QmRYVUVzQXAw?=
 =?utf-8?B?aXlhTXQzMmFueVhHdEFlU05xWjEzTE4wZHVyMkY4ejQ2MVhvR2NsaDJrYTdj?=
 =?utf-8?B?RXhqTW9reVlPallwblZxTVFEY2hxNFFXcE91K1A3aVg3SEY2RGk4d3BHeWNZ?=
 =?utf-8?B?N3Q1MG90ajZuTmN6ajQzM081c09QNjZMaDl2cGNxd2pXL3pkM2pVYkZTWnpE?=
 =?utf-8?B?WGo5bVk5S1k3ZEFCOWo3UXVIbzQ2bERQVFQyRDQ4bFZXS25PNEZ0RVFBaGVa?=
 =?utf-8?B?bmY1bm11T1l5aGFXdWtzN0daMFVGTEkzYTZxMnVPRU41RWFjT0hCU3J3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVByeVptd3lqcXpndVlTdUd3YklBdnp6clU2cnE0c1E4K002YmZLYWZFbkl2?=
 =?utf-8?B?MGYvTm84UGpIL3NKMFJScHV5dDhzU1ArMXlFUjgrTnZzUURIY0JtaHNJQllt?=
 =?utf-8?B?YWhlbHpmcU9IN0FBb0FiZFdPSFlPbnluaTRNYmxTQ2huZmRNdUExNDBoa0Vm?=
 =?utf-8?B?SXprLzJtMU1LNklrK0ltMythbjEwYWs3SHZ5czJTRW9yQjFOLzBNTTZRMWlT?=
 =?utf-8?B?empROTZOMnpWZDN6WjdZdU9DSlNUb2R3NmZLbjFmM0s5Zm1EN2svK0lndHow?=
 =?utf-8?B?MG5uNXQvT2RyUlpWVk1QVEFPVS9NQWo3bU9OZ0M3Tmxjd0R5bTZZeitma2kx?=
 =?utf-8?B?bHIyVCtQME9NcTJyeXB0QVExbVBBSGc2RFJiTWlWRGl6RVYxWlRkek5SdHV4?=
 =?utf-8?B?eGdOM1M5V09GOFFwTERsbGxZd3Y3bFFhbGVaeXZ0TitZMGJzWjN1VFZkbDRq?=
 =?utf-8?B?NldYd2Q0YUs0WnhoTjdJVDNXNkxvUlBaTld4MjNRaGRRNFZTQytHM00rZHFz?=
 =?utf-8?B?SlRuNy9zWmRRZDhkU1l2d3VYcUFzSzRnK3JzcEJRVHBrQUUzY1JCaEpwMXI3?=
 =?utf-8?B?cysweGovS05DK3NiQ3VIU1YyVlJnTG1JblpxNWhlVU80L2tIa0dNRGQ0UTgx?=
 =?utf-8?B?RG00MExpWVBheFZSMEdRQ2FlakdMK2NySFZBV0xTVnZtaGhnb1krajlCckhX?=
 =?utf-8?B?SkZHVUlWdjBKZTBRZ1hPZVNOeW1PMGlZdHlFZUFmUk9CaStMVXZncDJCd3Zj?=
 =?utf-8?B?RG5jbFczOVQ2TlM4K3dsNlY2WE5YM21jbkxpa2txMlFucFc0NlpjVEw4b2Zk?=
 =?utf-8?B?WWpyYytmdWdhVGJVUmRlWkRmUE1WZS9IeVZuNi9mUllOcExYK0c2dkxyVnV0?=
 =?utf-8?B?RUNxc2ZabVptVStCYkovR0dmVWFqRGlEMGVZdThoa3UrUHVTbFpqckdxeUhO?=
 =?utf-8?B?MDBIY2dpRkY3bG04Q2NrMVRjRGFiYXpMQ0Y0Z29uWkc2ZGhjbXd0bGZxeXEy?=
 =?utf-8?B?bktZUHhFbGd3S3dQNjgzNVBQMjEwbXhLbCtGWnZ4aWpuUWQyS1pIVDg1RGgr?=
 =?utf-8?B?a0ZTNDQ3QzVHaWoxZnpzUlp5NXF0S1MxS2I4NUVHM3VkUkJiYm50WG5qRW40?=
 =?utf-8?B?SkM0RE1mc1pYY013VklRYk9xLzU1MmhQMUFDdjRBQVNPbnFOc0tjYlpaNC9K?=
 =?utf-8?B?YXlTVTdFRWhObHZLa0d6WUJTNGxGUWc3Z0IzZ3lKL0l2MU1QWTJ0eWlBRzll?=
 =?utf-8?B?aGY3RGVUdkpScmU0RG5JTlAvR3dBNFg5d2hhSkNMVXpTc3QwM1FNalJQVnhG?=
 =?utf-8?B?UDFWRnJQZ0dDczhUL3VOOEs4SnEzelkxNTZ1RFpUZ0VWeWhDWXorY1N2UGNI?=
 =?utf-8?B?V3NraUpvMlhuT0h0S2RsTURpRzE0VTlsRzNDQXJyTnJJbW4wUWdjdXBNUUVt?=
 =?utf-8?B?ZTZNU2xiWDFvaThDTXVOK04vUG4ra0NNMHdad2xSMEs3WUJQenlhV3VtcHNH?=
 =?utf-8?B?UHVIeFV2blZxUGhvbVlXWVgxRXRHVEJsbURkeHRTMWYxbTJXa0dMT21zc0wv?=
 =?utf-8?B?UUp4NUpyb2pZMzdlQk1pc1FmT0hyb0Fhd0NoY3ZNdTdjZTE3VWRVN2g0Zndi?=
 =?utf-8?B?MFFoYkFRWHhkdWlhZzlvMzlVM1Joa2FMVXE1MnUySmpjVmEzRVdMZEpqR3Bk?=
 =?utf-8?B?VzBibHlwMHc3bGs0TTRIOGRMVytybFlJRERxYUgzYUp2ZFl3L2FIa21Vd215?=
 =?utf-8?B?Z0tZa0k1T1cwSEZOTWl4ZXVpZk1mU1lqMnNQK0tuejBIVUZ6UVAyK1dYYTJ2?=
 =?utf-8?B?ZkMxclg1NURmWXFZQzV4bXpwU24ya1lhazEvRk1zWDBIb1RyaEpETmRLTmRz?=
 =?utf-8?B?MUlYalpEbjdZZzdBSFJKUk1CMysyOS90WTBKZW10NUR6bnZPb0VNNGN1NG84?=
 =?utf-8?B?RDRtSHpwUy9GcnphK1M2ME4zTURPNmo4dEcwWEZkbFNQRFhGeldvaXgrb3dL?=
 =?utf-8?B?SnpSTUoyNUt5MjhocnpUVkhRVW5pQ0Z3cmRLZ3h6RXpVNVo4SXFpdDVCYndz?=
 =?utf-8?B?Ynp4Y3JXaG9oTU9sclBOZ1Rja2V1dU01cXdQOUNHYmhWeWxVdWo1UU45KzNC?=
 =?utf-8?Q?mLHSOgWXI1o3mLg5zTRTu94tp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c722a681-1ed5-4e0b-5b03-08dc6a6bd866
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 05:51:00.6693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjJl7j29QygCYSXZt59kcs2d2DuqqM4CzFQcTQ847UaFFOwaPUbyY2jHEiuuQY3Sf3LUpd83OorQNUQ1ljTe5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
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


On 01/05/2024 22:44, Alex Deucher wrote:
> On Fri, Apr 26, 2024 at 10:27 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> From: Arvind Yadav <arvind.yadav@amd.com>
>>
>> This patch does the necessary changes required to
>> enable compute workload support using the existing
>> usermode queues infrastructure.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 10 +++++++++-
>>   include/uapi/drm/amdgpu_drm.h                    |  1 +
>>   4 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index e516487e8db9..78d34fa7a0b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -189,7 +189,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>          int qid, r = 0;
>>
>>          /* Usermode queues are only supported for GFX/SDMA engines as of now */
>> -       if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
>> +       if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA
>> +                       && args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
>>                  DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
>>                  return -EINVAL;
>>          }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 525bd0f4d3f7..27b86f7fe949 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1350,6 +1350,7 @@ static int gfx_v11_0_sw_init(void *handle)
>>                  adev->gfx.mec.num_pipe_per_mec = 4;
>>                  adev->gfx.mec.num_queue_per_pipe = 4;
>>                  adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>> +               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
>>                  break;
>>          case IP_VERSION(11, 0, 1):
>>          case IP_VERSION(11, 0, 4):
>> @@ -1362,6 +1363,7 @@ static int gfx_v11_0_sw_init(void *handle)
>>                  adev->gfx.mec.num_pipe_per_mec = 4;
>>                  adev->gfx.mec.num_queue_per_pipe = 4;
>>                  adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>> +               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
>>                  break;
>>          default:
>>                  adev->gfx.me.num_me = 1;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> index a5e270eda37b..d61d80f86003 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> @@ -183,7 +183,8 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>          }
>>
>>          /* We don't need to set other FW objects for SDMA queues */
>> -       if (queue->queue_type == AMDGPU_HW_IP_DMA)
>> +       if ((queue->queue_type == AMDGPU_HW_IP_DMA) ||
>> +           (queue->queue_type == AMDGPU_HW_IP_COMPUTE))
>>                  return 0;
>>
>>          /* Shadow and GDS objects come directly from userspace */
>> @@ -246,6 +247,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>          userq_props->use_doorbell = true;
>>          userq_props->doorbell_index = queue->doorbell_index;
>>
>> +       if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>> +               userq_props->eop_gpu_addr = mqd_user->eop_va;
>> +               userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
>> +               userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
>> +               userq_props->hqd_active = false;
>> +       }
>> +
>>          queue->userq_prop = userq_props;
>>
>>          r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 22f56a30f7cb..676792ad3618 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -375,6 +375,7 @@ struct drm_amdgpu_userq_mqd {
>>           * sized.
>>           */
>>          __u64   csa_va;
>> +       __u64   eop_va;
>>   };
> Let's add a new mqd descriptor for compute since it's different from
> gfx and sdma.
the only different thing is this object (vs csa and gds objects), apart 
from that, the mqd is the same as they all are MES based. Am I missing 
something here ?
>
> Also, can we handle the eop buffer as part of the 
> kernel metadata for compute user queues rather than having the user
> specify it?

Sure, we can do it.

- Shashank

>
> Alex
>
>>   struct drm_amdgpu_userq_in {
>> --
>> 2.43.2
>>
