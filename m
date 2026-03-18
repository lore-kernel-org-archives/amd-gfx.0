Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DC9103E18F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CAE10E263;
	Wed, 18 Mar 2026 14:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="epyvNZbm";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D11110E263
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJPg96fPBn0C54JIOwfFaTZ7L+OmF+zxyNy4aIkLQEwQ3X0W5dX846cH1jRbYA/FCdcd6TsKkRzqBOLJGc5acksl6YC3nZ/dxbbS7eBs1+b96qrmhhlQrAervQA+aVwQgchep5mPiCXG64SJsim4OcFzWa42DMpJcqcGeSATAlFF+s2P1l811EmvjjroKX8/AoI8ZLL+/UqueB+ArJQlbBqHBra8jJ1PYfFAe5gSC+xY6FZxlrkUkbKixB/T4NzQpthLhQdDOlTTqyL7heaByqvf0lo0ZIrRH9GeB/6TKTlmR7yhlvyr1NgB/6Tp5PfYQCAzrDJgv9cChrswJbsVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DL0N/5tJt2Xo+uOY7E6eJcRIkFnQlRj4cR5DYcnTNE=;
 b=H7YMGO3heO5PLCKJ55t9/NqahjqWcrEwR0r9C2qO+35o65QhhDKTXXSpE3/lDEXwuI4+28oCgP98mo2dJagKrYmk6ILvcSgQZ+3oo+Q3Uqwxe4f9R30oAsTED6xaPW79XjDgt5KRfOva2JnmyPIEXfdRLMhfYf0vanQN4yfJ5rgYWj+fzt66d51WeMYHTruZsWwvn8PRSgvnINzjZNaWNNnUdrcVW9ly62NRiTYK2WsExSvN53nhzKQreCAcV376c+vUzqThCXjjNYAg6cOq+AIt5TXt/4XbXynRjLTAz+cfArbOrxPSwWOUxihxWiUu06KdXuxJ7sSJ3D7AcuY1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DL0N/5tJt2Xo+uOY7E6eJcRIkFnQlRj4cR5DYcnTNE=;
 b=epyvNZbmS00FCekQ89lw7vHbKHZWceKNHaF65UlZp8gMuvaL0OBhmNqQX5ImkdnvBD3RnJmnjtHzUURSNmWULfXfqdJHPIJE0w/sQYfkAYi1Z69GiPRZo3NTzno0Dy25KmS/LSneLu1VqUc9GjJqXWdSdElndCNXoWmaHeq4uBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Wed, 18 Mar
 2026 14:43:04 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 14:43:04 +0000
Message-ID: <f65148cd-5cf6-49c6-82de-9d0c22684656@amd.com>
Date: Wed, 18 Mar 2026 20:12:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Review 1/1] drm/amdgpu: Add amdgpu_regs_pcie64 debugfs node
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260318112201.3779461-1-Stanley.Yang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260318112201.3779461-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0063.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 24600b32-28e3-4c83-dba5-08de84fca93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: DCQvu7NBXy4+mFI6q6vm15hXYoTYCE15NRtuMex3iBVhIC8lP10jICnVDYwMvzlwmE2/CjQAVh4YArX3eoK7cYtPC13JB+FliEjg5bv8zeaPv0/96yAzaOvVJrMSBNM6fKzMgzsiCHMzRxSymWfmZ8iyqI1OjLhcEl5NDt0wWlqwmIx1rrBWqgvpSt0nBaO8E6bUDc/8qmkO3ZoITHPWxW7vpDDpqVDFhEBbo9Y7axIxp1ck7WA3wAu/dM2gw47yln+IUdKHjM1T59ZPBNFCiRbuycPSYYBzzi5qKkGLQFVgF3pTUKv9eolC68Tx+DmF/jCChA7u+22TDyu+imUYZE7SWZlL8xY8AZ6x5Lx/ybLiflyc4sp8Atj6k7Z8m8SSSldkjEuoeJ8m0b1w1QdQkEdhFsDsgwayHaIc623dwdqZ/CrBnm3aDQdXRzFqP3ydPyO/A55ofITNHZuBtLSSOjhDb+z83/oLgp5BQezE6K0Ysfq78fU9ZKDx16VbGcWdyjEDYt9CfPt4wgVV3bOWMf0FlnG/hDezCNCeFkkUEu0rnmyBbOmX0LV9a9au2PVWcJjEPBsom/q77rkhFGNvwMpkDbOGcqW9ydrTEW0DbUP2AO9npWdK2wtvPLknEcvZuX3KHCUsp5kDuWT0UENJYWsKxe/qya+raag61YrVlaXBe6tuW81b9S8qBTnB3iiFDadbjMntQgQSTvhcevHYlgzMhcTbY4c5cjzQdHQN27Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDArdWdCWFBlcFdORUV1b2xFRzA5MWlucXRMM1JWUWhUZW5RTnVtMWNsd2tk?=
 =?utf-8?B?SGtPQmNPSmJDNk5VbUM2ZDNGV2Y5bDJnQ1Z6NVBWNG5GcDdlTjlES2JLZVhp?=
 =?utf-8?B?d1U5bUoyQlpmcHN6bXh6YWZjR1dHNmJlbTQrVFRmRkI0dU5wYjRnd0M3TXdv?=
 =?utf-8?B?RTVvQmczcjg3TVBVUHZ6b2M0aDIzTGNGSTJOdTFscFhaaG5OcC80eUZDcm9T?=
 =?utf-8?B?cmtsRDRpaEpvb3dhbHd1TmQ1WG9reVJiSEZiaXFPMllmNjc1bjc2TUZVZk1o?=
 =?utf-8?B?dERwNytOQjlSNWJmTzUwSmcxUDNwak04WXFRajVUb1BqMXJFQjRXMnpFN2Rv?=
 =?utf-8?B?ZWJNRytxeFdFS0cvUE82VkVCUHIwcFkrSThhMHN4dGNLR0ZUTU5jN3Y4eTRN?=
 =?utf-8?B?R1N1RFR2K3ozRC9QVG5zZ1pLc0xqRHdLWkV0NGl1TTJsaXpLakRSQUtXZ1VY?=
 =?utf-8?B?OVdrejhFYXF3OEN6SkRrV0hPVFFXSzBEMDhMUllpRlZ3aXV4R3NwWHR5Qmp1?=
 =?utf-8?B?WXhtQ1kwdmxTRENmbjJHZjlnNnJ2ZGE1amhjdUFwQ0h5TWpMMlphNEVpeUJQ?=
 =?utf-8?B?Q1I0WEwwUm0zNFo5akZzZ1lFaDkxNmlQUmcwakVrMkZxOHlRcXZldVIzUFpa?=
 =?utf-8?B?U2dnTU04bWw0NXkwL1p4a1JZT2NTQ0dMOC9lRmJwMlpUZ3NSdkpzWloySWdU?=
 =?utf-8?B?UVE3M0QvT0d3NDFDYnB4OU1Qc2NUN0VDbko1dHk3Zk1CWTFHRFBSR3BUUkQ2?=
 =?utf-8?B?Y3psaDMrdURWZWZmYis0Y2FiK285aGlZNUZ0eFZDc3VoWkRYTUkraXYwWjZG?=
 =?utf-8?B?clZndGhuTGZTVjI4WHRMcDJtbk1xcm9FV3RidEVRVDQ3TjFNZ05jQmxVMFli?=
 =?utf-8?B?aFJDUmtsY05uNVhnaVNpNTZFM3k4NmtESlc0dHQyWDJhWDYyd0dtS21rS1Ev?=
 =?utf-8?B?MERneE1wc29URkROMVgyK2xwZG0vNkRZaVlhOE16c2toNUdENXp2K295KzUr?=
 =?utf-8?B?ekdBTEZKWFRJV0xINWV2TjlUMWlISjFISmltUS9yMW5ZcGZEMUlFakc3OVpj?=
 =?utf-8?B?YTJuNHdCajh3SWtWVUZyR09DNWhRSDdLS01RRmRpZHJnVnlTNzdyVmJqbEkz?=
 =?utf-8?B?R1BrUktOM2FFN3Uxb1plVlowclBYa0pnK0tCT2RZYnNSRjhuaHNKMzlYMWpk?=
 =?utf-8?B?Y3R1Ym9pODc5SkNjMEc2Y2taV3JKbVc3cTNoS1p5MFRFYnlGc3lFVWY2V21o?=
 =?utf-8?B?UGxsbzJOQ2s4S1FaR1hoMnZvQURIY2QrWU9JSEpRc0IyL0Q0aXByYnZCZnpL?=
 =?utf-8?B?SjBTNkJ3ZWpsWW1tMjJIS2FxVjliM1FOek5qUExRWjZWZHYzeTk2Qm54M01x?=
 =?utf-8?B?d2IrMFhTVGsvcDZWVzVWWkhtMlZxdCtmRmpaMW02bHNmS1NoUnFUVUd3UHZ5?=
 =?utf-8?B?N281K2dTWFBvdmZJNjFyUlJuQ2JYRG9qT2ZrV2FSTDkzWlpQRS9GR09mSDZs?=
 =?utf-8?B?d0VhbGJaMjE1ZEw0ZHo0NEtTZUdicEFFMDhVUmFWanZ6eGdtc2hTWE5TaFJG?=
 =?utf-8?B?NHVuaFAzbldrM0NtdXVkWXlFakRzTXMzWmw4WHNlWFczNDZNeG5lZFFlZGJy?=
 =?utf-8?B?bmlMYUpaWEx6bFgrZ0Z0cWhwbjQvUk41S21DSGsySThZejdRV2VRQXQ0bTly?=
 =?utf-8?B?VjUvd055TmM5THVxdWhrUzA4RXFka2JMRmYyN3I1c3o2aTdPb0gvcjZVMHNV?=
 =?utf-8?B?Q09TcDBhSGc4VHZIbHIvUFNQT2hJL0lmczBpWHEyNDFhemkyK3ZtS0J3NnZm?=
 =?utf-8?B?NEJZV1pHQzdlc1JqdWxLWVRTd1VYNEpwQklDeFFla1lHSlY4ZXFZRVhrS25G?=
 =?utf-8?B?T3FyK2g3RlpQckhDUmpoc1lwaUY4YVNFSGU5akVGZ2F5N0dleFVXU3MxUlNH?=
 =?utf-8?B?YjcraDF0RlY3N3lveVZZTzI0cmlZU21KM1VEcEM4MEMxQkZ5R3Jkb0VWMDF4?=
 =?utf-8?B?QkJ5b2pWS3dxTWlQRmVGdXFtaktnVmpVOW1DZjF2dzdxUXRGcXNObGdQQStS?=
 =?utf-8?B?OEJlRnVKZVVTRmx6TEQwQ1IvQ1RWV3dwd1IwVnhJMjBjVkF6WUlPdDJQZXc0?=
 =?utf-8?B?Wk9QRGhMYUlBTW1qQzlwT0hIM3BZNXF3V2FSeW9RRHVEd21TYVRKdG5YRlg2?=
 =?utf-8?B?SFdRS1JpUnNNK3dYOEo3aE5hS3NmQXJnbEN4aG5MWFE2TVlnb1plbjRZWlJv?=
 =?utf-8?B?RDc0NWJMSXRPRHdmMzNjMUVjbUgrMFFYZGNCN20xLzRCN1VJVlNLY3E1RTlq?=
 =?utf-8?B?U0VNbVJ6bEJhKzI1c3pOZFhlblc1aTNQbk00N05QOElPdEdTMnVEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24600b32-28e3-4c83-dba5-08de84fca93a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:43:04.2506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulPh4ktvrBw1cT6jlpWcy7OrOLDTfTrC4h32Vc289zNe799L4XDhuaYwbUcoecA9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
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



On 18-Mar-26 4:52 PM, Stanley.Yang wrote:
> Add amdgpu_regs_pcie64 debugfs node to
> read/write 64bit PCIE registers.
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 113 ++++++++++++++++++++
>   1 file changed, 113 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 6fdcd9c78324..e15b3aa02919 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -622,6 +622,111 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>   	amdgpu_virt_disable_access_debugfs(adev);
>   	return r;
>   }
> +/**
> + * amdgpu_debugfs_regs_pcie64_read - Read from a 64-bit PCIE register
> + *
> + * @f: open file handle
> + * @buf: User buffer to store read data in
> + * @size: Number of bytes to read
> + * @pos:  Offset to seek to
> + */
> +static ssize_t amdgpu_debugfs_regs_pcie64_read(struct file *f, char __user *buf,
> +                    size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = file_inode(f)->i_private;
> +	ssize_t result = 0;
> +	int r;
> +
> +	if (size & 0x7 || *pos & 0x7)
> +		return -EINVAL;
> +
> +	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	r = amdgpu_virt_enable_access_debugfs(adev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	while (size) {
> +		uint64_t value;
> +
> +		value = RREG64_PCIE_EXT(*pos);
> +
> +		r = put_user(value, (uint64_t *)buf);
> +		if (r)
> +			goto out;
> +
> +		result += 8;
> +		buf += 8;
> +		*pos += 8;
> +		size -= 8;
> +	}
> +
> +	r = result;
> +out:
> +	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);

autosuspend also marks last_busy, it's no longer required to call it 
separately.

Thanks,
Lijo

> +	amdgpu_virt_disable_access_debugfs(adev);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_debugfs_regs_pcie64_write - Write to a 64-bit PCIE register
> + *
> + * @f: open file handle
> + * @buf: User buffer to write data from
> + * @size: Number of bytes to write
> + * @pos:  Offset to seek to
> + */
> +static ssize_t amdgpu_debugfs_regs_pcie64_write(struct file *f, const char __user *buf,
> +                     size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = file_inode(f)->i_private;
> +	ssize_t result = 0;
> +	int r;
> +
> +	if (size & 0x7 || *pos & 0x7)
> +		return -EINVAL;
> +
> +	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	r = amdgpu_virt_enable_access_debugfs(adev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	while (size) {
> +		uint64_t value;
> +
> +		r = get_user(value, (uint64_t *)buf);
> +		if (r)
> +			goto out;
> +
> +		WREG64_PCIE_EXT(*pos, value);
> +
> +		result += 8;
> +		buf += 8;
> +		*pos += 8;
> +		size -= 8;
> +	}
> +
> +	r = result;
> +out:
> +	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_virt_disable_access_debugfs(adev);
> +	return r;
> +}
>   
>   /**
>    * amdgpu_debugfs_regs_didt_read - Read from a DIDT register
> @@ -1544,6 +1649,12 @@ static const struct file_operations amdgpu_debugfs_regs_pcie_fops = {
>   	.write = amdgpu_debugfs_regs_pcie_write,
>   	.llseek = default_llseek
>   };
> +static const struct file_operations amdgpu_debugfs_regs_pcie64_fops = {
> +	.owner = THIS_MODULE,
> +	.read = amdgpu_debugfs_regs_pcie64_read,
> +	.write = amdgpu_debugfs_regs_pcie64_write,
> +	.llseek = default_llseek
> +};
>   static const struct file_operations amdgpu_debugfs_regs_smc_fops = {
>   	.owner = THIS_MODULE,
>   	.read = amdgpu_debugfs_regs_smc_read,
> @@ -1606,6 +1717,7 @@ static const struct file_operations *debugfs_regs[] = {
>   	&amdgpu_debugfs_gprwave_fops,
>   	&amdgpu_debugfs_regs_didt_fops,
>   	&amdgpu_debugfs_regs_pcie_fops,
> +	&amdgpu_debugfs_regs_pcie64_fops,
>   	&amdgpu_debugfs_regs_smc_fops,
>   	&amdgpu_debugfs_gca_config_fops,
>   	&amdgpu_debugfs_sensors_fops,
> @@ -1623,6 +1735,7 @@ static const char * const debugfs_regs_names[] = {
>   	"amdgpu_gprwave",
>   	"amdgpu_regs_didt",
>   	"amdgpu_regs_pcie",
> +	"amdgpu_regs_pcie64",
>   	"amdgpu_regs_smc",
>   	"amdgpu_gca_config",
>   	"amdgpu_sensors",

