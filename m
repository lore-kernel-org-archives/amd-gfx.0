Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7C4C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 23:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8326F10E97D;
	Wed, 29 May 2024 23:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZkpxcY9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E593E10E97D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 23:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNToVpJifZSRXDarVcxYg3osBlucsujMyytn2GBA/rrN+36Pdsi5RX0UFN7R4D9i7/++FAxw/Dgf6T880slOxBvahumwtla8oT7d0fsRR16Dy6oScXYc1dYquF628y+OmiQsrKBB+dcm/ONMYVHRd4cQGiIaMIjhLKEX1yf0csyc2fnynp26JCUhrHUP9baPvFAEh12cIZQi2qYLe1vd2jPsWF6idHOcJ6HBCUsLbJk2w8JaYMQ+NdRJwmuMXnSL7pJ/sMBp+pBz1FPJhL0beZCAsAlOHeLu0LPSD8eaidSEH6mXCGnL5fEPujb+yheCvdoSnY6gokUlV3RBlP6Njg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3QVsuAtfDPoG13j+9GwL/qWhtyXM+k5igZlt0tzRnw=;
 b=jzp7FFdNuUX8oUCtXsLv/oB5sJWgboQYJqFCGQy+Kau5yFr0i+4InjeiQeHK+e/JZ5xG8yyyuFmgVqpZDGezHPQuQHIoxTkce74n3SBcDe/oNm9rS8dZ7W+iBi0A9+WdBLmfH9OudVKoo6hlQdBwnOy8lOj2jTJ4Yo+1trKwK2iA0oNlGq45DsQ342DbBk2Q7qDP+Lxda4hL7oFZfo9XByZcz5q42rHvKHnUDUA5uDpqNhx7BuAZ5pURi0l+whJoUK7xrvx2dsc6B1lJUvd81+zpzmaCY2tCWBWVa77n/BqTK5b/sEc7loIRoQTXkB8QIRrmmWeoM0r+o/+BylYBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3QVsuAtfDPoG13j+9GwL/qWhtyXM+k5igZlt0tzRnw=;
 b=BZkpxcY90CHi8KDLnfXsehEZ18tjC96tt/enJYbhni2RcTUVP8b797tQPz9UfzD+Fs9BeGJv4r/Hmgs2ncsMK92TSRNmCrEYt93DKWHIWd8XN4Yeqe9MKtNdUz4ntjqKWZ73C6g9/jaMVoFPRcKcoHr0ZizuUUOdxVraVN2K/0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 23:04:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 23:04:41 +0000
Message-ID: <d7715590-edb4-42af-ad08-175fc9aca048@amd.com>
Date: Wed, 29 May 2024 19:04:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] drm/amdgpu/kfd: remove is_hws_hang and
 is_resetting
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com, Likun.Gao@amd.com,
 Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-5-Yunxiang.Li@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240528172340.34517-5-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6d8e38-4b7f-4a71-b2bf-08dc8033b8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THByVG44TDJUMENtbU16aFcrK0oyakJOejFLbGJkWjA4aUxQZFpqa055Tm5Z?=
 =?utf-8?B?WGZ1NlYzY0YrbFFGWVR5ZGZtaXV6dmFsYmVlbnBhcWkrUEdiSjc0SmgwWHBU?=
 =?utf-8?B?WjRKcS8xajREU2pTQi9Pb0MyTVorWkI3Uzl4WTJ2cW82RGxESmNoRFFoTEht?=
 =?utf-8?B?STUzOGt6T3R0MVFqTHNKcGNpZzVVUlRqZVpLMktwZmF6dHhzRk1xeEpsMjFK?=
 =?utf-8?B?eG5nNnprQlFRb3dYamFPUU1iaWZoVitsUHp6RjRCQ0N3MXRyWDZMcXF0bG5n?=
 =?utf-8?B?R1BuQ1EyZW0yNk1KcXY0T3pMem9ycnFBMGZNM0pPV0NvNS8xQk5rei9nUW1J?=
 =?utf-8?B?dUJ3NUtoamFDUGtiNGVhQTF3UkR4ay83VFB6azRUNTJEV3UrWnJqZFNLazJW?=
 =?utf-8?B?ZHdVbDRZTG96aUdYWDVYY0VScFozTENSUVBnVXF3ZS9icVJteTc5ZTlMNEhs?=
 =?utf-8?B?N0RhRUVtYllJbWdHbWpmbWM0YXZ5blNETjJUNGpoTkRuMGRoNmtpMGNBY1Yr?=
 =?utf-8?B?WlVrMnJiV1JkR2xuUXJ5K0JOMHpBditscG0yWml2Z1JncHgzQS8yekwxNEVM?=
 =?utf-8?B?a0lqMTExZGVXT3FiNkxBa0QxNGhWUzhnUm4zNFlINEVMN0lJc1lFR3FscVI0?=
 =?utf-8?B?TFF4d0R0NU5xeWphZ3JpbHJqcFIyUU1lVEJEdUdLODcwRGFQVEZoUVh4OVNy?=
 =?utf-8?B?MkNIQ2VySmVEMFdSSEZtdy9UY2RwNTZqQi8zVStxSDdiMkgzbGRHUHYxNU5X?=
 =?utf-8?B?VUpRc1F3Tm80RHA3dk4rTmlMOTJCRkptVEFHbHk5QnlTZVZYMGxYVXN3dlNK?=
 =?utf-8?B?K2s1N2NzUGwvRjZ4YkFIc05rNkFsb1dtaFhwY3F6TUNJb29QZUYvVmNaRjA5?=
 =?utf-8?B?TFJkRzNBRDZwclRtQURUTXdNMGNIV2VOZGVIYkx4ZmgvcDBUaFQwcDlQbzNP?=
 =?utf-8?B?bWxqdFVyNDg1MFl1SW9JcjREVmd6NXFWdmd5K1YvZEIxKytVUnlEUUJlNHc4?=
 =?utf-8?B?R294dFN3djZzNC95Q2lrV0lUdm40YStWdlNiUnRVU3JFZXhZMnNOSGxlSy9k?=
 =?utf-8?B?NHpuS3U4R0NVVGgzYjlzd1hOc1M5WDNzY3N0dC9OUVc3MjJiQzhKVTh4bXBS?=
 =?utf-8?B?WWlDYnpkSk13d296cHB1SFVWdHFqK1hRYTVIL1Z2alQ3MzF0Y2lHaXRhOTdR?=
 =?utf-8?B?UW1ndWhXMk1iSjZzS3I1UmE2eUorSXNJcmsxOFBRckZuWERoVnVreUFMVzA3?=
 =?utf-8?B?dzZWbnpoUTUzMW1vMWFiZHJEVlBpbk5YS2t0eFptYnRsMGlsVDlmaE9VN0h5?=
 =?utf-8?B?RWN1RXkrVVJyNjhkdzlubjdIMmZnL0cydWYveERHRkVaK0VGbGk2S0gyMXdi?=
 =?utf-8?B?NnczUUtyQ01FdnRBSFh6SFg4d2wwZHkwQ0xpTERLU1VtRVJaMXIyZ01kdDF0?=
 =?utf-8?B?VU4yZUl3Rk5CR09IZG0xVWdydVVTRnBGdGQ5R3BvcnRNVVhpSFB2OFZMMDFo?=
 =?utf-8?B?cno1STRlMmZvNWFLcVRtRnpaZ3M1cmZMSTQyT2U4Z0tRa1RreGl3YkdRZDFF?=
 =?utf-8?B?L0ZyaFJpanJoako4Rk41SDBJQ3U2Q1kwbUh3WEY0cGhmdzdlc0FYNDNGVFY4?=
 =?utf-8?B?RW9MU09KNkYwellPdld3Skl4cjBmTjVDek41S2MzU0hyTjBVTWgyRFFCcktL?=
 =?utf-8?B?VWx4T0VqRDZmKzBHTmRjTzRYZWlIUlIzZGljcXl0bjIvcysyZXJMS0hnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZzN3A2d2tYYXVCc3RJVzVQM29HaEJ0N24zclpEWjFXUjJXYTVyVjhxcHhm?=
 =?utf-8?B?ZXhBNkV5QWJ2dUJlS2JSWUg3cS95bjJJTHFDdXJPenl5eU5WUXNuRmRBQ0JR?=
 =?utf-8?B?SnlJdkFHTGo0YnZZZkZOREVZbDR0Y1EvUTZMZEVCbG02b1VmaHZXNzZlcUli?=
 =?utf-8?B?dUxoQjZ1N0JXWENSTlpYSy9nTHVLZ3FLdUVML3gyMmpFR005YkhMZTY1WTVQ?=
 =?utf-8?B?WkpwemxjdHRwUWJibXV3OFFDa0hxREpVYkJPeVBpZDdPT0VUMzlCVE1Nb2xK?=
 =?utf-8?B?WDNxV2E4Q2tXVXFoRVlRTml0dnF5SWlPUVFFU2ZIK09Zb2tzcFhNOWFlTGdV?=
 =?utf-8?B?WWFUdkRUbjlJTS9lY3JEaWg3WjRpMEFUYUNiMjlvWnJZWWhXc0ZmN3h6dG11?=
 =?utf-8?B?QVBuREt4N01sRkJEaVNhb3Ywa3hJQjdnWmJ1YjdIWGhxOFgxVWNVMzg0VTdx?=
 =?utf-8?B?emJSV1FpbzhBck1FZDhpUlkzd1UrYzliai9oUUMxQ09kdzIzRFZ0OTA1MUtN?=
 =?utf-8?B?Slo0WmhuYnhmSCs2cUFrajhtSlZJTzQ5SFZFdTVTY3dxdmF6TXZ4NU40N3g0?=
 =?utf-8?B?RGRETS9aUjhkZmlmRHM1RmlzQkdLNmdzMWVJbnpuU0Vobi9DWW5meDhueEdR?=
 =?utf-8?B?T3FZc3djSXZWWVFoWDBwcVdnbFlBNnlDQmtXRU5Bd1JrVDFJakhLZG1VbTY2?=
 =?utf-8?B?VFkxckRzSDhmZi9HcHA5U25aS0hGanVVUzkvRlA4a3FkeXRNZ0N1eXNFRU9j?=
 =?utf-8?B?ai9QcEZYaytsMzVSeGlnVEkxdk5zajZwNlV2dkd1cSt1WHkzbjJYK0tzL3Qw?=
 =?utf-8?B?OHZlSlFkSGlJZy9aVUhUZzhkcUw3Q3o2Zzhkb2ZDTVlhTTVYQVR4Sjc2UStE?=
 =?utf-8?B?UGxWZmZXYjJSZVdHakt6bkpuQXVFcndTL2hMOG5lNVRKMEpYQXg1SzVaN3Rj?=
 =?utf-8?B?Vmp6Vm5nUzFRUU5UelY5d2lqTW1xaFpEcC81b0lTTll4cjFoN2tDbUdybEN2?=
 =?utf-8?B?MnE4VCtwMlFmS1QrV2R0dEZiVWEwc1F5ejdUWHJqM2xKL2VNNVBPMlNhbkNz?=
 =?utf-8?B?VFQxT2thU3k2YndnT0d0NFV5TzcrbS9vZ214Vm5SeDBSNkRkNzJCdjFaYkEz?=
 =?utf-8?B?clRPZ01CSVkyajFCakI5dmZzdG1LaWk0eGhqdFM0WktUS0VVVTBaYUdiNU5N?=
 =?utf-8?B?V2lyRmpKcENvamVac3gzQllDRGNKQlJ2MXJGSncwRTlsZmFkTEFxV1NJcHBQ?=
 =?utf-8?B?R2pxamZDZ0l3NytadFVJYXJCSUdlSU5pZGRldlFwQlc0MU5tbVhiRCt6MGMy?=
 =?utf-8?B?Rm5NcFdVOGlOeVRqNG1aWEJ0dnd4MzczOTMvRXlLaDBSYW1uL2tUYzl5bnh6?=
 =?utf-8?B?TzdEUzgzd0VZb2VBdjJFVDVjcUx5eTNaaWd3N0E0U1dJbzdZWVFMcnBsaW5S?=
 =?utf-8?B?N0FOWGlhMGI4ZFA1bjg0OVB0Wk52NVBMNmxOVlRBNTdhUE9TTGlySm9raTNt?=
 =?utf-8?B?M3F1bVVVS3IvdndIcndVOHQ2WEN6R3pjYUtLZmwxUlRpRmJGVEljYk0ySHpz?=
 =?utf-8?B?VjI4R0xiYWRqd0NybEpmRmtWRzJ1NlVodDNHc21Pbkorek5MRE5tNys0YXFr?=
 =?utf-8?B?anRCNXVzWWlLUkFuVjNKN3ZYMFRmUGlnNHFGVE1mRW1oT0JBR1RRb3lxQVBx?=
 =?utf-8?B?bk91TnhsZDVBUEJnZEt2VGpVTmhBVkh3Z1BRcmpYWEhtRFpoTk8wK29pYlVt?=
 =?utf-8?B?V251SXFXdEhQMHNiREpWVjdOZXg1S0U2MWRCZk1XRzJkTHY5RDJuQlRpYWtp?=
 =?utf-8?B?a09XdkpVU1NMOG9BNUgrSjNZZEk4ZnltU040Yk9mWWlCTzFKbkFFb2IyeVpP?=
 =?utf-8?B?dTgrK2JncmJONjV2T3lra1dBWDhoQXNNYkxaQzFyaUFzWUoxc0VRcTlTZHp2?=
 =?utf-8?B?Nlg1RC9qenI1SmpkWFJlWnU0VTY0S2ZBTkdlb1lqaXBaZm15TkNoOEhxc0xj?=
 =?utf-8?B?U0hMYjNvNjh3N2lRR1JzYW94b3pCb0I0anVDR2pSdURUa211L0x4SWpQRXRK?=
 =?utf-8?B?dDZ3a216RHB2ZmxPaEl2VFF6NUZ1Y0RIN0tRd2kwaUpURm50eUY5dTBvU2VZ?=
 =?utf-8?Q?kt7F6ltRMOyTtF+9f7JJwLDTk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6d8e38-4b7f-4a71-b2bf-08dc8033b8b1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 23:04:41.1320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zT1uGykLSfS3jFLLqLTAqUicY07zxNIMitjRx0wiXlTid9P/Dnqa+ZY+mAjSQz1+nusnjO+slLOTyfEfACHO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
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



On 2024-05-28 13:23, Yunxiang Li wrote:
> is_hws_hang and is_resetting serves pretty much the same purpose and
> they all duplicates the work of the reset_domain lock, just check that
> directly instead. This also eliminate a few bugs listed below and get
> rid of dqm->ops.pre_reset.
> 
> kfd_hws_hang did not need to avoid scheduling another reset. If the
> on-going reset decided to skip GPU reset we have a bad time, otherwise
> the extra reset will get cancelled anyway.
> 
> remove_queue_mes forgot to check is_resetting flag compared to the
> pre-MES path unmap_queue_cpsch, so it did not block hw access during
> reset correctly.
> 
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

The patch looks good to me. It's been years since I worked on HWS hang and GPU reset handling in KFD, and at the time the reset domain stuff didn't exist. The result of this patch looks a lot cleaner, which is good. If there are regressions, they are hopefully not too hard to fix.

One thing I could see going wrong is, that down_read_trylock(&dqm->dev->adev->reset_domain->sem) will not fail immediately when the reset is scheduled. So there may be multipe attempts at HW access that detect an error or time out, which may get the HW into a worse state or delay the actual reset.

At a minimum, I'd recommend testing this with /sys/kernel/debug/hang_hws on a pre-MES GPU, while some ROCm workload is running.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 -
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++++-----------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 11 ++-
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 +-
>  .../amd/amdkfd/kfd_process_queue_manager.c    |  4 +-
>  7 files changed, 45 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index fba9b9a258a5..3e0f46d60de5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -935,7 +935,6 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>  	for (i = 0; i < kfd->num_nodes; i++) {
>  		node = kfd->nodes[i];
>  		kfd_smi_event_update_gpu_reset(node, false);
> -		node->dqm->ops.pre_reset(node->dqm);
>  	}
>  
>  	kgd2kfd_suspend(kfd, false);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4721b2fccd06..3a2dc31279a4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -35,6 +35,7 @@
>  #include "cik_regs.h"
>  #include "kfd_kernel_queue.h"
>  #include "amdgpu_amdkfd.h"
> +#include "amdgpu_reset.h"
>  #include "mes_api_def.h"
>  #include "kfd_debug.h"
>  
> @@ -155,14 +156,7 @@ static void kfd_hws_hang(struct device_queue_manager *dqm)
>  	/*
>  	 * Issue a GPU reset if HWS is unresponsive
>  	 */
> -	dqm->is_hws_hang = true;
> -
> -	/* It's possible we're detecting a HWS hang in the
> -	 * middle of a GPU reset. No need to schedule another
> -	 * reset in this case.
> -	 */
> -	if (!dqm->is_resetting)
> -		schedule_work(&dqm->hw_exception_work);
> +	schedule_work(&dqm->hw_exception_work);
>  }
>  
>  static int convert_to_mes_queue_type(int queue_type)
> @@ -194,7 +188,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>  	int r, queue_type;
>  	uint64_t wptr_addr_off;
>  
> -	if (dqm->is_hws_hang)
> +	if (!down_read_trylock(&adev->reset_domain->sem))
>  		return -EIO;
>  
>  	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> @@ -245,6 +239,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>  	amdgpu_mes_lock(&adev->mes);
>  	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>  	amdgpu_mes_unlock(&adev->mes);
> +	up_read(&adev->reset_domain->sem);
>  	if (r) {
>  		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
>  			q->properties.doorbell_off);
> @@ -262,7 +257,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>  	int r;
>  	struct mes_remove_queue_input queue_input;
>  
> -	if (dqm->is_hws_hang)
> +	if (!down_read_trylock(&adev->reset_domain->sem))
>  		return -EIO;
>  
>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> @@ -272,6 +267,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>  	amdgpu_mes_lock(&adev->mes);
>  	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>  	amdgpu_mes_unlock(&adev->mes);
> +	up_read(&adev->reset_domain->sem);
>  
>  	if (r) {
>  		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
> @@ -1468,20 +1464,13 @@ static int stop_nocpsch(struct device_queue_manager *dqm)
>  	}
>  
>  	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
> -		pm_uninit(&dqm->packet_mgr, false);
> +		pm_uninit(&dqm->packet_mgr);
>  	dqm->sched_running = false;
>  	dqm_unlock(dqm);
>  
>  	return 0;
>  }
>  
> -static void pre_reset(struct device_queue_manager *dqm)
> -{
> -	dqm_lock(dqm);
> -	dqm->is_resetting = true;
> -	dqm_unlock(dqm);
> -}
> -
>  static int allocate_sdma_queue(struct device_queue_manager *dqm,
>  				struct queue *q, const uint32_t *restore_sdma_id)
>  {
> @@ -1669,8 +1658,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
>  	init_interrupts(dqm);
>  
>  	/* clear hang status when driver try to start the hw scheduler */
> -	dqm->is_hws_hang = false;
> -	dqm->is_resetting = false;
>  	dqm->sched_running = true;
>  
>  	if (!dqm->dev->kfd->shared_resources.enable_mes)
> @@ -1700,7 +1687,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>  fail_allocate_vidmem:
>  fail_set_sched_resources:
>  	if (!dqm->dev->kfd->shared_resources.enable_mes)
> -		pm_uninit(&dqm->packet_mgr, false);
> +		pm_uninit(&dqm->packet_mgr);
>  fail_packet_manager_init:
>  	dqm_unlock(dqm);
>  	return retval;
> @@ -1708,22 +1695,17 @@ static int start_cpsch(struct device_queue_manager *dqm)
>  
>  static int stop_cpsch(struct device_queue_manager *dqm)
>  {
> -	bool hanging;
> -
>  	dqm_lock(dqm);
>  	if (!dqm->sched_running) {
>  		dqm_unlock(dqm);
>  		return 0;
>  	}
>  
> -	if (!dqm->is_hws_hang) {
> -		if (!dqm->dev->kfd->shared_resources.enable_mes)
> -			unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
> -		else
> -			remove_all_queues_mes(dqm);
> -	}
> +	if (!dqm->dev->kfd->shared_resources.enable_mes)
> +		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
> +	else
> +		remove_all_queues_mes(dqm);
>  
> -	hanging = dqm->is_hws_hang || dqm->is_resetting;
>  	dqm->sched_running = false;
>  
>  	if (!dqm->dev->kfd->shared_resources.enable_mes)
> @@ -1731,7 +1713,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>  
>  	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
>  	if (!dqm->dev->kfd->shared_resources.enable_mes)
> -		pm_uninit(&dqm->packet_mgr, hanging);
> +		pm_uninit(&dqm->packet_mgr);
>  	dqm_unlock(dqm);
>  
>  	return 0;
> @@ -1957,24 +1939,24 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>  {
>  	struct device *dev = dqm->dev->adev->dev;
>  	struct mqd_manager *mqd_mgr;
> -	int retval = 0;
> +	int retval;
>  
>  	if (!dqm->sched_running)
>  		return 0;
> -	if (dqm->is_hws_hang || dqm->is_resetting)
> -		return -EIO;
>  	if (!dqm->active_runlist)
> -		return retval;
> +		return 0;
> +	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
> +		return -EIO;
>  
>  	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
>  		retval = pm_update_grace_period(&dqm->packet_mgr, grace_period);
>  		if (retval)
> -			return retval;
> +			goto out;
>  	}
>  
>  	retval = pm_send_unmap_queue(&dqm->packet_mgr, filter, filter_param, reset);
>  	if (retval)
> -		return retval;
> +		goto out;
>  
>  	*dqm->fence_addr = KFD_FENCE_INIT;
>  	pm_send_query_status(&dqm->packet_mgr, dqm->fence_gpu_addr,
> @@ -1985,7 +1967,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>  	if (retval) {
>  		dev_err(dev, "The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
>  		kfd_hws_hang(dqm);
> -		return retval;
> +		goto out;
>  	}
>  
>  	/* In the current MEC firmware implementation, if compute queue
> @@ -2001,7 +1983,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>  		while (halt_if_hws_hang)
>  			schedule();
>  		kfd_hws_hang(dqm);
> -		return -ETIME;
> +		retval = -ETIME;
> +		goto out;
>  	}
>  
>  	/* We need to reset the grace period value for this device */
> @@ -2014,6 +1997,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>  	pm_release_ib(&dqm->packet_mgr);
>  	dqm->active_runlist = false;
>  
> +out:
> +	up_read(&dqm->dev->adev->reset_domain->sem);
>  	return retval;
>  }
>  
> @@ -2040,13 +2025,13 @@ static int execute_queues_cpsch(struct device_queue_manager *dqm,
>  {
>  	int retval;
>  
> -	if (dqm->is_hws_hang)
> +	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
>  		return -EIO;
>  	retval = unmap_queues_cpsch(dqm, filter, filter_param, grace_period, false);
> -	if (retval)
> -		return retval;
> -
> -	return map_queues_cpsch(dqm);
> +	if (!retval)
> +		retval = map_queues_cpsch(dqm);
> +	up_read(&dqm->dev->adev->reset_domain->sem);
> +	return retval;
>  }
>  
>  static int wait_on_destroy_queue(struct device_queue_manager *dqm,
> @@ -2427,10 +2412,12 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>  	if (!dqm->dev->kfd->shared_resources.enable_mes)
>  		retval = execute_queues_cpsch(dqm, filter, 0, USE_DEFAULT_GRACE_PERIOD);
>  
> -	if ((!dqm->is_hws_hang) && (retval || qpd->reset_wavefronts)) {
> +	if ((retval || qpd->reset_wavefronts) &&
> +	    down_read_trylock(&dqm->dev->adev->reset_domain->sem)) {
>  		pr_warn("Resetting wave fronts (cpsch) on dev %p\n", dqm->dev);
>  		dbgdev_wave_reset_wavefronts(dqm->dev, qpd->pqm->process);
>  		qpd->reset_wavefronts = false;
> +		up_read(&dqm->dev->adev->reset_domain->sem);
>  	}
>  
>  	/* Lastly, free mqd resources.
> @@ -2537,7 +2524,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>  		dqm->ops.initialize = initialize_cpsch;
>  		dqm->ops.start = start_cpsch;
>  		dqm->ops.stop = stop_cpsch;
> -		dqm->ops.pre_reset = pre_reset;
>  		dqm->ops.destroy_queue = destroy_queue_cpsch;
>  		dqm->ops.update_queue = update_queue;
>  		dqm->ops.register_process = register_process;
> @@ -2558,7 +2544,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>  		/* initialize dqm for no cp scheduling */
>  		dqm->ops.start = start_nocpsch;
>  		dqm->ops.stop = stop_nocpsch;
> -		dqm->ops.pre_reset = pre_reset;
>  		dqm->ops.create_queue = create_queue_nocpsch;
>  		dqm->ops.destroy_queue = destroy_queue_nocpsch;
>  		dqm->ops.update_queue = update_queue;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index fcc0ee67f544..3b9b8eabaacc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -152,7 +152,6 @@ struct device_queue_manager_ops {
>  	int	(*initialize)(struct device_queue_manager *dqm);
>  	int	(*start)(struct device_queue_manager *dqm);
>  	int	(*stop)(struct device_queue_manager *dqm);
> -	void	(*pre_reset)(struct device_queue_manager *dqm);
>  	void	(*uninitialize)(struct device_queue_manager *dqm);
>  	int	(*create_kernel_queue)(struct device_queue_manager *dqm,
>  					struct kernel_queue *kq,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 32c926986dbb..3ea75a9d86ec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -32,6 +32,7 @@
>  #include "kfd_device_queue_manager.h"
>  #include "kfd_pm4_headers.h"
>  #include "kfd_pm4_opcodes.h"
> +#include "amdgpu_reset.h"
>  
>  #define PM4_COUNT_ZERO (((1 << 15) - 1) << 16)
>  
> @@ -196,15 +197,17 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>  }
>  
>  /* Uninitialize a kernel queue and free all its memory usages. */
> -static void kq_uninitialize(struct kernel_queue *kq, bool hanging)
> +static void kq_uninitialize(struct kernel_queue *kq)
>  {
> -	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && !hanging)
> +	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && down_read_trylock(&kq->dev->adev->reset_domain->sem)) {
>  		kq->mqd_mgr->destroy_mqd(kq->mqd_mgr,
>  					kq->queue->mqd,
>  					KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
>  					KFD_UNMAP_LATENCY_MS,
>  					kq->queue->pipe,
>  					kq->queue->queue);
> +		up_read(&kq->dev->adev->reset_domain->sem);
> +	}
>  	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
>  		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
>  
> @@ -344,9 +347,9 @@ struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
>  	return NULL;
>  }
>  
> -void kernel_queue_uninit(struct kernel_queue *kq, bool hanging)
> +void kernel_queue_uninit(struct kernel_queue *kq)
>  {
> -	kq_uninitialize(kq, hanging);
> +	kq_uninitialize(kq);
>  	kfree(kq);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 7332ad94eab8..a05d5c1097a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -263,10 +263,10 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
>  	return 0;
>  }
>  
> -void pm_uninit(struct packet_manager *pm, bool hanging)
> +void pm_uninit(struct packet_manager *pm)
>  {
>  	mutex_destroy(&pm->lock);
> -	kernel_queue_uninit(pm->priv_queue, hanging);
> +	kernel_queue_uninit(pm->priv_queue);
>  	pm->priv_queue = NULL;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index c51e908f6f19..2b3ec92981e8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1301,7 +1301,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev);
>  void device_queue_manager_uninit(struct device_queue_manager *dqm);
>  struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
>  					enum kfd_queue_type type);
> -void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
> +void kernel_queue_uninit(struct kernel_queue *kq);
>  int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
>  
>  /* Process Queue Manager */
> @@ -1407,7 +1407,7 @@ extern const struct packet_manager_funcs kfd_v9_pm_funcs;
>  extern const struct packet_manager_funcs kfd_aldebaran_pm_funcs;
>  
>  int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm);
> -void pm_uninit(struct packet_manager *pm, bool hanging);
> +void pm_uninit(struct packet_manager *pm);
>  int pm_send_set_resources(struct packet_manager *pm,
>  				struct scheduling_resources *res);
>  int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6bf79c435f2e..86ea610b16f3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -434,7 +434,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  err_create_queue:
>  	uninit_queue(q);
>  	if (kq)
> -		kernel_queue_uninit(kq, false);
> +		kernel_queue_uninit(kq);
>  	kfree(pqn);
>  err_allocate_pqn:
>  	/* check if queues list is empty unregister process from device */
> @@ -481,7 +481,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>  		/* destroy kernel queue (DIQ) */
>  		dqm = pqn->kq->dev->dqm;
>  		dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
> -		kernel_queue_uninit(pqn->kq, false);
> +		kernel_queue_uninit(pqn->kq);
>  	}
>  
>  	if (pqn->q) {
