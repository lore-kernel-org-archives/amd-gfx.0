Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E050C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 21:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F40E14B702;
	Fri, 12 Aug 2022 21:11:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96BB2B9CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 21:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwnz7syJRfmdsx0QE3eZPhpycM5QmI1DnuS/QcmgtAS0kTu1ExvLamkcSS80pB4nuLsNSR9+lSjjKg2wcJgIrBe1OFODUx5ExqouDSWwm4LtaMbYd1WMzGr0ltXWSnim3aELTbfOJOxf+brGobNIo2SbgasOZ/GF5bRLgX+g4JCGxr/Gt9DgSV6Q/Oh4tXBD/CPCwaE57um/8g5WwTW2RqnJ19FU5jx6yTw4fb4wM0Sn7lyja6lAeCZN8BLJnHUzWJGKJ9rwrbTk14UIPDfsstH+vmOmY2YILW3PSH9bb6U1IfKiqBMNJHnrbtHacntgNM7VdFaWFwl+8T55NxxViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxPYmbIfLD1IsrLMOBVO6Duaf8P0RNJBbBWTN+bBNlc=;
 b=jCYsxn8Zs/11HmhHpMIRdp+SUu9wClnmpOBlNTACvs73gw0WA/iDZsnCE37OEsD8MYIAXDAW4FIKiFaDhZnxiItR9D8xjkzM6H0eUyBMTGdCoKhTvMWsDzH1/QmfHOwAKRKmn4z0LIfu1bVDaJPXq/MPgMGq2RaZbf3oNsIC/ZdiXYZjKJ1DLW2PZHAdNJ2NQyi1euY1FFjcXqR18a8VxFsW6AI2FdDA5Fc3s5G8iKvdTTvSjly7SL+tyAAeX9n/8YJYzkSmKaxc+Dtm+AAzjTsLc0FlwlMkpM5QKh98Kan8FbCVoZBy/+DbYSBjz+JyqInm08KTXv0T0XE3glMXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxPYmbIfLD1IsrLMOBVO6Duaf8P0RNJBbBWTN+bBNlc=;
 b=kHbqeS40Qsgq9HclHfbzcooJdF0WHR4NQCOOcsHpgJ2KnPITkoV/fvmWcXVke9Uu9SQ+78SiwqplnJwMD/FFUOWAHSlXAr3JArLofzsxIxoQrrHfqgHoyC2AuVA5+hJH167amE4pnv+EUYlsLqFIOlxurYKjP1oJJz1WIvSB+k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB2451.namprd12.prod.outlook.com (2603:10b6:207:4e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 12 Aug
 2022 21:10:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 21:10:54 +0000
Message-ID: <8fe840db-ccba-0dae-23fe-d08db0b35167@amd.com>
Date: Fri, 12 Aug 2022 17:10:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: potential crash in
 kfd_create_indirect_link_prop()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>
References: <YvXxSkLaaSMLU8fT@kili>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <YvXxSkLaaSMLU8fT@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:610:59::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f23ad010-11e0-425a-0309-08da7ca7244f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2451:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYCcJsb4rLaYnP3+gj2wQah1DqQ8ZXlealgVRhUYgdLuPjLs3UZ63fGCoMQFJb0spTfZ4pa+FUVLAu/61Lvha/07NSrZLurbo5OxuBr3A/jISnHGlLRRGU4Vd7gUjhHPQP/fmK3jniyzsKd7gyZ+cFUlE7eISpVtGftOfK2WzuZiEsWWQAUvsPzMgpw9ThlhS9UIfEoSJUOBEQEKandzHgxyPelZfCj9REcoXIeK1jb1Hi670VYfBUwEI7wHXl1ZMzZ6vbz51grOpnAJDekV4PLwBieFYtrHAqupOjwsVxKW5eWXOYqTd+BiIVAGo4adKIBcNiM/qr3HPWUUCAqZe/65ULtjq9khf81oFkJPFUT0zQNyFRdX6xOwIfZQObKJHrK93wa9iqD1Lhp32nVvGJlzoEgzyE5Xezq2Vcw1J2UGPtDjM7oWHj16iDw3cNok5468Otv3Hr8c61qiv51hFTvGK75YlDLX2qW1TP4lS/7UjGmbHLlrTTytM7mJS9SfsjKT6cEdXAUc/noGcF6bMbMuXJjaGVR+99Vi04nyXnjgIjAZJ8bmbJoVjgsG/Zi0VOw1H3C+gZESaksBiXHj3iCO6nDCjJ9WeIhDKUrJ25zuUpvVPEPCaTreos473fG4Lo0xgQrBbPdj1xmADCT+Y10RIL9h4fIohkhIqq3F/NBuuyirWqW72ckUN80DmmInDD9n1hf12H3EFbW4y1gKQ4wXirtMS9vGzLFiPcS69YZBpxpK+lZukCtw8WXbf5hOvwIldIGalk4Q83OlrxT7YMibzxc7KEGl/FAVmrc9p6nTikWf0QabLDTgvGJRurR+klutC7w2I7GDB7N6MJy2RgCXPo3hI9LKJsY2BAPX5pC0JvfwtmzwzkpK6OcRFMbLNI4Mfa/vWMmePFFbMjT6Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(5660300002)(26005)(44832011)(6512007)(110136005)(6636002)(54906003)(8936002)(83380400001)(186003)(4326008)(316002)(2616005)(8676002)(38100700002)(66476007)(66946007)(66556008)(86362001)(41300700001)(6666004)(31696002)(31686004)(36756003)(6486002)(36916002)(478600001)(966005)(2906002)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNjWnk3WWtML1Q5ZUhEaGdkeVIxblVPQzNmSWxQMzA1b2oyaFovRUtwcmRU?=
 =?utf-8?B?WVk3bVA3bXdFZ3hzekFTWmFtNFBvS2xucnZtWko5WVYvRk1jbzV0M1hENDE0?=
 =?utf-8?B?aUpEOEN2amxxNXBJN0M0a1p6eWpxRmRVS1dSQVhkYW5wKzVtU0F0dDRCWXZl?=
 =?utf-8?B?MHhmWHRRbGdvZ3d2T2RRNUhCYUJkcmJtbVBjQlpiUUdKWll0TDluUjl2bkJQ?=
 =?utf-8?B?RVM3cGNYYVJ1U1ZPalJwMVdWV00zcGN1T00zdXcwazFQZDJZZ3R0Umh1Um9N?=
 =?utf-8?B?OVJXN0FHNlR5MWI4M1puQTlqbEZNeHZoQkVtVjZqL1lzYS9UU0NRVTNRODhY?=
 =?utf-8?B?eGYxN1pMdkZTSldPT2sxL0NWOTUya0N6bEVHR3RWcUNLZW9CS0IwMHI2a1NP?=
 =?utf-8?B?Q0tyWUpaL0hxdndRdFp0dWRESGxycmhrQUx2WmRYbjg2N2FwelowbGRGOHpG?=
 =?utf-8?B?T3hUYys4bWFOZFFxMEJ4dlNmU1lEOWw1RUVYK1I3UFZSUXhzMnFFbHF0Mk5y?=
 =?utf-8?B?NS9BcTBmZ1F4UGx5bVlwTzh0cVFGWVp3VzY3ZGcwakNOSTEyNEVFSzBFeHl4?=
 =?utf-8?B?YVhOT0dSY1V3VU52NWJuOU13b21UYmk2THFKWmM0MWhzOVdVTk5Sa25TaExZ?=
 =?utf-8?B?MXdJeXVJeXJvU1RMemdXRjVITHBFQ1VyODhTMlpZeG1iei9OYnNWcWEwdlJh?=
 =?utf-8?B?aVFCbStGK1J4MFdSUTZQcFM5MFVvTUZxc1NmTkU4SXhOMzY4M0tDb05vU0du?=
 =?utf-8?B?Vmwxdnh4Y0dOWVQ3a1dML3VDZDFmUk5sckh2MUtPTUNoMUlqUUljWEM3QWFR?=
 =?utf-8?B?VmVDeGxEbFNlZzhkcXhhQVhjSTJSVjVBaTR0a3F3WkUwSHpLaE9hUDhPRWor?=
 =?utf-8?B?UTBGMWVpZHZpTEVkQ09xbmUrOWFSWVFrRWFqT1hlV0QzMWtFTXljcW5DVE1Y?=
 =?utf-8?B?UUhEN2F4NUlhTXhlaVpHdEVGYmdOKzVOdzJqNzZhVDRhR1JVeFZhZGJTVG11?=
 =?utf-8?B?Rmc5VXhpaXZYTFV2SFEwT2ZIdUtrZkgxZnRjUGRvclZXL05KSktvcEZzbzV6?=
 =?utf-8?B?bm1xay9MZDZOV0tvc1RKZmZwcWNLb0wwUnpkOGYwS0JTUk5heCtDTUx0NlZV?=
 =?utf-8?B?emx1LzJDYWRUNUtqZWZaNVBsQ0s1c29MdE83ekcvQ2ROM1FVazdBeHFQNnJ6?=
 =?utf-8?B?c1htcm4vZlVRb05EeHhuRUt2dHdTcWRBU1N0RXVzTWdPakZhTTB6MCtwbzFD?=
 =?utf-8?B?UkNPTU4yNk5CMDhOV2dNQm5tUDFObEczV3h0cnBIZFZNSWpzOE5Gdm1ZT3NB?=
 =?utf-8?B?YnY1c0NKWEE5OVR1ZWxsUXkxM2Rac1B5Zm5NcWtLQzdXbUlKdUZOTE9neTRM?=
 =?utf-8?B?OUt3UFVXYWFPT3hnVGRPRnlYeHRnZnN3Y1pYZXZYdlFYTTVHRVRQMmtKUk5w?=
 =?utf-8?B?TmRJc3REekZnQkh5K3VHK2pxMS82ZEY5QjBWSkQxSHRWMG9VcTB1YkF6TGFC?=
 =?utf-8?B?TC9FYjFPMzhsWXM3ZlRZenFmanpkNTB2dm0rY0M5aUYxTnl1VmwvaGp0amo1?=
 =?utf-8?B?b3dCSHRKSmNCRmh1b05zSzVPaUpLNC9lNkd2Tkx4YkIrZzN3QmR3V3pkK05O?=
 =?utf-8?B?WElBK0RxeGMwN3UyTEdDd3BMaXJzQ2lRSHI4U25ZR2gyaW1xK21YaWFaYXdw?=
 =?utf-8?B?QkI2ODlHcnNDbnA1MzBLT3czaldFRlJ3ZHh6eUdVZk1aQ2ZQSjVkR2NHc3hK?=
 =?utf-8?B?NnVKOXJrdDlqbWxKQ1VqUEJxT294VXhpUWdNMnMzL1JHZ0llZUVIbEFFeVJT?=
 =?utf-8?B?NENHQmh0US9kNzUrVVllclRaQmhSM01pOWFWWHljWmMzV3IvQlNQbTkyeXhy?=
 =?utf-8?B?L0lEenNkdjY1RHpwdkRRUVJSMGlIMDVyYTR5YjUzNWcwWCtwYVVaaTdVc2Qy?=
 =?utf-8?B?T1BuM1QyelJxMmNuZW1BVG5GRHV6bXN6Vm54T2hzVHMvbWwrQmM2cU1MWlll?=
 =?utf-8?B?V3k5d2lOMEd0dzUzWEYrV21ScjVKdkF3bWx5YmVEZ1FlTVpGMkRKTThRY29F?=
 =?utf-8?B?YWFUNUNMcFJOR3FXc29qOUhKODJxdDhxN2ZTVXVhSWYyTHJHeVpBenRjL2xB?=
 =?utf-8?Q?K0GdgsfHn3ze6Z/DHlLb2iNfa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23ad010-11e0-425a-0309-08da7ca7244f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 21:10:54.5791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQNKJKxN2m6MuuCkFzl+5hTiNo0PjHaKNS6vildVL2NMZ5NgcNocHkMUQN9KvQb8grLAdtWWFYVTjR8svxgnlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2451
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-08-12 02:20, Dan Carpenter wrote:
> This code has two bugs.  If kfd_topology_device_by_proximity_domain()
> failed on the first iteration through the loop then "cpu_link" is
> uninitialized and should not be dereferenced.
>
> The second bug is that we cannot dereference a list iterator when it
> points to the list head.  In other words, if we exit the
> list_for_each_entry() loop exits without hitting a break then "cpu_link"
> is not a valid pointer and should not be dereferenced.
>
> Fix both of these problems by setting "cpu_link" to NULL when it is invalid
> and non-NULL when it is valid.  That makes it easier to test for
> valid vs invalid.
>
> Fixes: 0f28cca87e9a ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I reported these in June but never heard back.

I thought Ramesh implemented a fix for this: 
https://lore.kernel.org/all/20220706183302.1719795-1-Ramesh.Errabolu@amd.com/

You commented on a version of his patch: 
https://lore.kernel.org/all/20220629161241.GM11460@kadam/

Did this get lost somehow? Anyway, your patch looks good to me and I'm 
going to apply it to amd-staging-drm-next now.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks,
   Felix


>
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 25990bec600d..3f0a4a415907 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1392,8 +1392,8 @@ static int kfd_build_p2p_node_entry(struct kfd_topology_device *dev,
>   
>   static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int gpu_node)
>   {
> +	struct kfd_iolink_properties *gpu_link, *tmp_link, *cpu_link;
>   	struct kfd_iolink_properties *props = NULL, *props2 = NULL;
> -	struct kfd_iolink_properties *gpu_link, *cpu_link;
>   	struct kfd_topology_device *cpu_dev;
>   	int ret = 0;
>   	int i, num_cpu;
> @@ -1416,16 +1416,19 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>   			continue;
>   
>   		/* find CPU <-->  CPU links */
> +		cpu_link = NULL;
>   		cpu_dev = kfd_topology_device_by_proximity_domain(i);
>   		if (cpu_dev) {
> -			list_for_each_entry(cpu_link,
> +			list_for_each_entry(tmp_link,
>   					&cpu_dev->io_link_props, list) {
> -				if (cpu_link->node_to == gpu_link->node_to)
> +				if (tmp_link->node_to == gpu_link->node_to) {
> +					cpu_link = tmp_link;
>   					break;
> +				}
>   			}
>   		}
>   
> -		if (cpu_link->node_to != gpu_link->node_to)
> +		if (!cpu_link)
>   			return -ENOMEM;
>   
>   		/* CPU <--> CPU <--> GPU, GPU node*/
