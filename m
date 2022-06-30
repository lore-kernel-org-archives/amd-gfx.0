Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F189C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D181011AE06;
	Thu, 30 Jun 2022 14:45:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175ED11ADD1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp7sSJR17TNdrVgEbceN6HODTlxk+Je6NBH9OHn/QL3C868/timPB7WS/VUBI2lomB+VQ0Wz7dLqK01KH/JP9xxDLY2HEktiD0Pf/ZdX8H6dRwXLYH39i+ljLUQmNuLkzAwvyg/T8Xz4cnVgB8Yl7ndKXMBnU9a0lBjHcpiOYBo4UguX/r7dCf2NIXwmaDbMTnrmT5xYzrbbZ9X7JFP56HreJyKx9fmrLSPbU53shUYmbzYHbb16bGPxyVbwxiuGRuaHc6+TlOguyZ1GEefCZMlVlnB9mAoWFMgCvDwcdf2J+dcTsSYmsbs++N3OVX25O8YC3m7crI4/SdxDROL0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfnLkVo6zZ4Wy/cZWim4KX8v5+NLEmnHiSzWlQSsd4Y=;
 b=N/Mcu9v5RKrPhvt1vOnd3MfxQEaHvoJzHwUmloH0kCMqs3IqEuD+20NjhZdJHaEV3DIy6jY0xmdWvPfILiyDC0p0YSI1X8S579xO80Z0gvxTWs2qrMlnG7NAoYrl7Nd9QOrpGN/8qIRWlurFFRC5IwpPCs5ZndjYw+dBe/I3m1H/NvgPITGw2VakqI29Mnzu5b0O0XjdDhmQif8hin3GWSsvpzj+tSp/QuC+fBpf9BYz+ubbyAka2G9/2LSp18OckSuPZaUjlqCE1TMT+D5pCSAwzIlQfL94gW8ekvG/NZE7yLFotG5XjkZk2/Tz4iqra8anD/ZZ4O3TVv0hTtVK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfnLkVo6zZ4Wy/cZWim4KX8v5+NLEmnHiSzWlQSsd4Y=;
 b=KeDImsoIxk5t3OjH1QYaP+K8TQ+22QFlNHofA16heNehDLnG6R6j0w8rb1jXhbMFLXv5L/eA5DpwIWsnsjSzi4I1z4Ig3cwsAf+7AKXCS6jDHauEfezA1hyNaLBz5qOyxDsYBDSnDVlYqKgjb110q1tRVpZ1mqRMFfe0Vht6PFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN6PR12MB4735.namprd12.prod.outlook.com (2603:10b6:805:e5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 14:45:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 14:45:05 +0000
Message-ID: <feae516c-b71c-d99f-b481-b195977c52e3@amd.com>
Date: Thu, 30 Jun 2022 10:45:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 7/11] drm/amdkfd: Asynchronously free smi_client
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628145020.26925-1-Philip.Yang@amd.com>
 <20220628145020.26925-8-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220628145020.26925-8-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 526ccf97-03bf-4642-0582-08da5aa71ed2
X-MS-TrafficTypeDiagnostic: SN6PR12MB4735:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9a7OCWZFcTNZAi5s8cRN1KgQahcLStyFpyqGG+64IqIBmpEp/dc4hT49Wps+QlqqzJm3eCcbUSligPQhCMJvsNpUWrapyXo+7Y4MCSa8tPwe08O71EOTJnST3r89Z53KTZrXxS7JK9wQoj6HvR7kCPl9oUgWZlJBma8WS4keydz8VlDmTGraBLIGxAP/QexOdwR6mlx5MdqanSE4akGnfra7WLOTlmKFNcfDFuLzjrrVLpM9N3Gt1rfE2BdxSiyP50PR7BJdxfhqAhcZuW+e4vpgfptA17msojCTGBzgx8P0urJjW/qqOOzxTHWBOOmaGJcqHYQuRs8/EzIVyQV2VjTZY2ugfrJDUV8WPhY+GByrRBa9jyZ5xWxAc8HKD52UbMc23dQ2d09r3AnhJQKjR1xbTNxQFTQrD9HmVKCuac8bU+TRPvBlqUSxjYbqrcZUbh+5T9ObZpdFGrOER1KnyfghpYsxVhlDMiPJH+inTKfK6GDWoC84Gw+WF494XBvssc5B0BHJwaprG+GLeumnGXtmsQMl1MJIs+8/4jvAffFk2j4iELgKBUxa8UGqjECOY6SlME5FK87Y1/HKWVV/N7EDLAR3bqlSFZd9HYu5Jr6sjOIdeZ7jrcQ7cBw34trnF8nxLDx0HW23xLfChsIoxKV41IBQn58wm9R17E0a37i6bRLkZXr2TEKjljzShcqzpC9qK9cogXJPwlZFlioY3pM0Muxl52GwZCEqGnK080Kyy3a5T6O2yzoslVg44UP5v4q9jT/czdwZou9Iy5FZvGydh4IyUtaxB2Gg4T2MB4q1+IKukC4nGiXWxP9/9LJljN9FfiJomPQ654X3DZi+cuBqnoUiL1ae5RgrkxzKweo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(2906002)(5660300002)(316002)(31686004)(186003)(36756003)(8936002)(31696002)(86362001)(38100700002)(6486002)(41300700001)(66476007)(44832011)(83380400001)(66946007)(26005)(2616005)(66556008)(6506007)(478600001)(6512007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUF0bmptTzNEeEo0aHBTWXdXV2I4bmFUc0k2QzBtdW1VVE54UkF5bDNDdGc3?=
 =?utf-8?B?Qm12Nk9IVE82WWNTN3picXVDWkxTcm1nZUNUQXIzQWFPSzUyOGpiamJSYU5E?=
 =?utf-8?B?b1p5WGg0ZDVxSHlJcWxKQWMxU1hLaWJyblNscEY5TVU2RVNXdFRJWWo4TVJu?=
 =?utf-8?B?cVVKbEtFV0RLT2kyZEdzMUtiVXFsRkFSRFJxTWYrd1J2OFFUdk5KNHhpZUpK?=
 =?utf-8?B?dHkraHJaclJ2dUJKN3RvaDNRdzFQL1B0bUM1cER0RHFMT3FjaHJSYkZDRzRF?=
 =?utf-8?B?STlhekpnakZzUzNCY0psNlg4U0ZwdlBXckxCTlptYjlOVWhUd1krREVzTEVy?=
 =?utf-8?B?ZUd3dkNLUzVlT2c1TlNTaHVZQW9FUXc2akorVDI3bzVZbDhqV0ZlbFJNZ0VD?=
 =?utf-8?B?MFhpMk51MG44M2RhR2NycFhQbXh6OTFFbmdCUjYrdkowcXpabENrMzZ3U0Vs?=
 =?utf-8?B?Qk50eXZTbjFZajBMdkRrN3p0bUNYTkRVQjBtcWtLbGpOM3A3VEZ3c29kRUpV?=
 =?utf-8?B?QTVBclFPSk9LaGhJSzRON2VzZjZIVHdONTlLWnlsYTN3a05RNWc3bmhMZHFa?=
 =?utf-8?B?cXluYkFiQ25NL2Z2NmhvdWwycXh5M2NWZGdFNTVNZ1lzT05UajhPai96Q1BH?=
 =?utf-8?B?eUo0TGVmTnV2a1V5NnZrcEMwTVRZdEtYREJtZzJMUVUvM3RITFNNZzhBSUNs?=
 =?utf-8?B?aHpta1hQdno4ckVaWHFxcC8vWVlIYlJFdGtZc1gvSGF2czFnaFMrcmpaSDVK?=
 =?utf-8?B?Kys0MHZ4cjZkVjBrWUZXVUJrZUFxSWcyelF2L3Q5VnIrUS95TUp6SFNCZ1pS?=
 =?utf-8?B?TUlhcGhBR29aUzNDREdMTnhCOExTNUVJbkhQSDB3RW9JMzZIdnU3VkorRWZL?=
 =?utf-8?B?eVV5akFMTkNvRUlnVy9XVXlEelU3RDlKd08ya3lMTURLSGJsY2tWbmU0UWFF?=
 =?utf-8?B?YlM4MlcwaExyc0RxOHVNb2ZJSnVmZFhTZC85UGp5dkhUSWZESFQrcE5TNWU1?=
 =?utf-8?B?SjhsM2c3aFBCM2lxYnl5Q2tKTHhxRXA3UHViZHNveVdvNHp4ZWhGTmlPU2Na?=
 =?utf-8?B?NzMrUVYwV1UrMFpibGc4VU1KZWJicVVCKzdjcnRkSGxvVW9lTHVPNDkvMlNC?=
 =?utf-8?B?SDd2VEhVY0xkVEVHSmdvek9PcEhhay9ZRlZXdGRMNXA5d0Rld0JkRXJOZWhN?=
 =?utf-8?B?QWgvSTF2TkZoaUl3Z0hqeXZmUk9ZSXRRaWZLR2lVcTd2WksxZThnMVNmZlRL?=
 =?utf-8?B?RGR3RkFhWDZIUXJlV24vMXRIdWI4dzlPbHR2cUhSaDBpU3dReXdzdVd4T0RI?=
 =?utf-8?B?eS9XZVB6WFN5blJRMjlDWi9tTXlDVUkxWVJ2TVFQNGhUb2Z3NlhvdVY5ZFNS?=
 =?utf-8?B?WWgya25jTXFmT0JLUEJGakdob2l0S3FFang0N0pmem5KclZHZlpDQ1BCQnd0?=
 =?utf-8?B?RkRFblBpZE10Rk03NTlQTzZwRnZ0SS9zRXdxeWhuU3M0ZkVaaTR2RE5SdEF2?=
 =?utf-8?B?UE9STjFQNS9ZZklIQUp5MGJrc21OcmhaamZUODVPd3RJTERLNmRhRGw3MWdj?=
 =?utf-8?B?d0Z3MHB4ekIxcVUrbDNqY2lUc0FpQXVlR2xMRG1qNzhKaDhwZS8vL3B0elY3?=
 =?utf-8?B?eHNSSWdtYU9xaUVkTndDQWN3c2FjU0JqWS8vcC9oK1Z0MWNhbEhXdzZJM2t1?=
 =?utf-8?B?ajJ2enpJU2dKb1o1bjJ4ZThsaUd1R0g0QVl1SVprencxb2tXTTY2RzU3WGEw?=
 =?utf-8?B?dkVlaDIra003UmJQT3ZQQlZxcTNlNDNZKytLU3pCaHpUQ1dyZDJpb01zQldr?=
 =?utf-8?B?bWoySUthejU4VU5sYmZHdEd1ZjArU3h1K2YzZ2tuSndCVEpUN0phbm5tSEFk?=
 =?utf-8?B?NjgrSExKVFRQcTBKdlZQTzFpNEtoUHZZN2lCaWcySEtvYUkwYzhYR3RTTCtE?=
 =?utf-8?B?T2F5MC9kRm4rcmZrTHoxTzFUVUVRaWxQRVRUR1FSVTJWb2s0d2pPOUIyY0Q1?=
 =?utf-8?B?UXMwYTZOdHgzb010QzRBb2VHL1hha0dLNEJWUXIzRm1sSE5kQW1qc1l5eXBk?=
 =?utf-8?B?QzVzVWkxSFkrQk1aVE9kcjlBdlNhNHA2MHhLNWUzUG96am1GM0hUa3ZwZjJw?=
 =?utf-8?Q?P4lwk+epqeKw7o1hIGLNQoVYi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526ccf97-03bf-4642-0582-08da5aa71ed2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 14:45:05.1027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sx4eIhIOotOlshEfmDToUSXiPdd4ES+AV8Q6aganJhaObOVIsw+KG003xRCc+TGVb7fSJgdVVpT2A9MW9UGtfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4735
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

Am 2022-06-28 um 10:50 schrieb Philip Yang:
> The synchronize_rcu may take several ms, which noticeably slows down
> applications close SMI event handle. Use call_rcu to free client->fifo
> and client asynchronously and eliminate the synchronize_rcu call in the
> user thread.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index e5896b7a16dd..0472b56de245 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -38,6 +38,7 @@ struct kfd_smi_client {
>   	uint64_t events;
>   	struct kfd_dev *dev;
>   	spinlock_t lock;
> +	struct rcu_head rcu;
>   	pid_t pid;
>   	bool suser;
>   };
> @@ -137,6 +138,14 @@ static ssize_t kfd_smi_ev_write(struct file *filep, const char __user *user,
>   	return sizeof(events);
>   }
>   
> +static void kfd_smi_ev_client_free(struct rcu_head *p)
> +{
> +	struct kfd_smi_client *ev = container_of(p, struct kfd_smi_client, rcu);
> +
> +	kfifo_free(&ev->fifo);
> +	kfree(ev);
> +}
> +
>   static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>   {
>   	struct kfd_smi_client *client = filep->private_data;
> @@ -146,10 +155,7 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>   	list_del_rcu(&client->list);
>   	spin_unlock(&dev->smi_lock);
>   
> -	synchronize_rcu();
> -	kfifo_free(&client->fifo);
> -	kfree(client);
> -
> +	call_rcu(&client->rcu, kfd_smi_ev_client_free);
>   	return 0;
>   }
>   
