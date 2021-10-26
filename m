Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D178DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 13:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6998F60EB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 13:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6998F60EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11FE6E432;
	Tue, 26 Oct 2021 13:29:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E52B6E432
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 13:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYai6a8T1YcjznTFmE4LKXEqSgqZD64BgltKiFsgS6nOCzmdJ93LWB32msrwLaBXlEu+IwodFH5i81dB3rfMozXFvL8brpaAq6idMNKab5PelcW1JvY2OqGWLZZGOBK1wOYyORHRWjPiV2eqEtsv9r/8dsjwkUzhI3QFWrwjMUPt6F4lpkeRRUAg3k0aVsYEl6MnOJJEDahVBnmhCCQJ1VuVtJlCNaVHX7oV8AvZAQx5lQrRAydTWjWCN5up1ufgbBtcU7C66Oaknj/25UrP5wFcgyDVQjxnPKupRT9o2/6Cbp4AwnWFqEdN+7FnqIGlenayUocISth9Js1onFpc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si0YrdsL2IhqexfXOzYwrj1h0YuLu4sZX7YxzwtbPVo=;
 b=fX3U066M+tFOlbRuwXZduWYBuT/N6uf/alQA+QS0YO7jJT3SU+vt8hP4kkD2y3UFffbLrSh0xqZxHc281q6vkBzt9EXb7UAJo8mHfmNe7RObW7MgY/+P2UKfZtvyhxTWOGO/HHzVzSZ7CyFdnqdlHnn+EWf5M5fYtwh18OSl3Uiy1CmHL0WS1wBBGC9G/S/dg4w0oRKV5/OT7lkjzLDAKxDQ1GkHVCegu8JTSOOWZ234omGzMGhgTEUj4Gap3Q+TPpLCT22geNtJMrO/vKpN9LYudJ1AMdRk9YOvTlQj1SeWwJclR/8eOFRX0M05nHNS++SMFgRxahtXkRCteCg07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si0YrdsL2IhqexfXOzYwrj1h0YuLu4sZX7YxzwtbPVo=;
 b=MIIxAGhkWztsnrltDdnTUSl8cexjh/laYUQECdc9LppPVzV0+GPOTo2XuXWoXyjxzwSHVRb8xPFOKBhX8n7u/PVrD85DDQkoW35Vr7Vg1poJOw6FJzEGyFtyWKC3o3kq81h69Q5aHGu5e5eBuof7GDiRs1/PG0652JnoRD8qBKw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Tue, 26 Oct 2021 13:29:29 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%9]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 13:29:29 +0000
Message-ID: <6f604281-c8ad-5e9e-4a7a-78d7153be9ff@amd.com>
Date: Tue, 26 Oct 2021 09:29:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] drm/amd/display: Fix error handling on waiting for
 completion
Content-Language: en-US
To: Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, mdaenzer@redhat.com,
 contact@emersion.fr
References: <20211026110740.152936-1-stylon.wang@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <20211026110740.152936-1-stylon.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::28) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [192.168.1.180] (198.84.165.113) by
 YQXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 26 Oct 2021 13:29:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abbd307f-4542-47e4-65c6-08d99884a383
X-MS-TrafficTypeDiagnostic: DM8PR12MB5398:
X-Microsoft-Antispam-PRVS: <DM8PR12MB53981F3E17C9BDF7E6017DDFEC849@DM8PR12MB5398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09ZbGzxPJbWphEd3Go+Rg6H79NmnDCfkA3TNXEBTH97W4h7O0KeWDpPbDpxA/6DTFzbZ+fXKdljs2Rc0jiSPM7Gl7dF8CFSJXuhS3AsqfgEjnFy3YHJGhtFlQYXJpxl5Y4lpcmziZ8ChZyIAU53T63lu0ldFGkdXyFB2J60Q7n9alSiuHab/0XO5p/GJzUvyTyi2ykuEN7RGRAGAGJ2PQgub2pS5SBLLsAlRF0ph56XtEp+uH2CsqMVFL11f4Rejt4za2bTbyZ5CFU3qAM6jcUZWylAVWjifBRvuxc6uPsRW7SYZ2ScdPg5KnC+HexMHyHIfY+FAXg7wWwHh52hGZ34mq8To0jYCnkwCkNlgUHvf6AWFvQy+FPZ6oyCnNqf73vebMNYZJlSQipIk6nKd87/WeW8IyKlBHCqJDB/uWj6P17UdwcCJuzIr++6SzLsOELZAx211MX+q1SrHXiT8UcIPvvyr1jAcqkArQDLqCV1XpS/0M4OrRTKsGLgFOUra/5ArpfcK9+1hIrlfi0CaTlCPUMc2yC8TgCqNnaFqIKBtHo3R8hLJs4pdAalP6we3jiy2FFxNwss2FaLSI6zYsahd/gx8bmUJ6kbkZsqYTYpO2Nm7VvKaiAB0XKWvR79sHuw8UBKxPRRQYe1RS4YHAoEvgZHAIiCD2ZFSEj31PzcUvzHgJt47OZXkTAo+gKXpLxAATFpkW1/kMq7UI6ilTsHYmep+4dmGKWAdmhePrfrOWa+CwVMH1RqmiX2z1bJy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(53546011)(2616005)(956004)(8936002)(36756003)(508600001)(31686004)(6486002)(4326008)(2906002)(8676002)(16576012)(186003)(86362001)(66946007)(66556008)(26005)(66476007)(83380400001)(4001150100001)(38100700002)(5660300002)(31696002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXVDNkQyTUNTMzRPRExQVFJuMzMvL2k1azdwTEhhL0xkazVSV0ZETXNtMmpJ?=
 =?utf-8?B?RDhGQ3B0M0Z0Rzhmb2dGRUc3cjZtSmtrZnR2WTJpVDE3NWdkY3JpbEpFSmgx?=
 =?utf-8?B?dUlZejFNWFh0aklveFdOMjYwdkFiMVh6dmZrRHRJUFo4eHN1VUtNM3JETnhz?=
 =?utf-8?B?blpCSS9ScklHRSt5RWVkVGpPbUg3c1BLVHdRd2pHQnZ1dVlEWUM5Sjg3ZzZT?=
 =?utf-8?B?Y1dRcFNndUtjajYvWVE5U0NGejBvSm83UU9BVURZQkp5YkVaQlF4djUxQ3N5?=
 =?utf-8?B?T3A1M2U1c0toOXRQbUQ5NXE4dEpIYnhCeitBejZ2ZFV5N1lLUGVXQXNDYkdi?=
 =?utf-8?B?S01CNCthQzFSOGtXOTVHMVF4RnU0Yk9ZeDk4cWJZTmZRQ2NlSG9NZ1d1UE9I?=
 =?utf-8?B?YXNneXlhdURHS3FMQkhTNHBpMkZ4cG5BWHdGMFgxcEZDNTdVQ1gyZHdndmZS?=
 =?utf-8?B?VmNpcG9PTmNHU3pVeEFDNlh4d0xOSHhTK3VXaGQ3U2dsbWx4K0YyZUhpbzlR?=
 =?utf-8?B?WWhjU081NnFCbXNBbkhsVFRYV2ljSnBGL1VTSy9CVlFjNm1vNUtRSTBvM3Br?=
 =?utf-8?B?YkNZQVBlM2JJbnRxVWZjOWg5ejZrVEgwZ0NxMmJtOVJHUm1hWUNXYk02ZlAw?=
 =?utf-8?B?TlNhbUVtRUxwMEhXTStFQUFqRnA2TURZZjFGV1lPUklSejVXT2NtNlU3Y3NP?=
 =?utf-8?B?eUFjaDhuamxGK3FOTGFLQ1RxSlNSN0xuL25qOEl3YVkvTkRyazJnSWQ5VnRj?=
 =?utf-8?B?VFIyZUNqcXliSWRNT2NUN0FxNnF6cDlBYnVYbFRTOVNXQnBBTWFEK296Vk1w?=
 =?utf-8?B?a042YXlKdVJBMkRmRkFRTGdBRXpPNTdQNzZHQjBNUDF0bFhxc3Z6QjFnaDBt?=
 =?utf-8?B?TmUrcEM3Snc4Sm9HUUlVMWQ3dnFXNThNWEhvWkZtbXlXM3h2cjJwdDh4OU5M?=
 =?utf-8?B?MUMrQ2NFK1kzRk9TN3ZGamJ1UnNMMGtzdENId3NIb1BwdFc0YzZlUUovUmox?=
 =?utf-8?B?NTJUL1hZdHlieUI3anIybjlzNlJHeEFUclRjV0dORDZJWVpwRFJGSkZwcnNT?=
 =?utf-8?B?T2hLVUtROXp4WFZLdlZFU1JyUDRITzhTYVVrdXhDSGpMU093T3QvcTY0NFlq?=
 =?utf-8?B?L0tiR2RsWlBpT1lxRmdRczN1SDBZelZpY2RqblVueEN6eFpRbnZNTUVqTGYy?=
 =?utf-8?B?dG5mMkdBZXNJVkQzQnE2ZXFySWlVMXFpajZRb0p6dkV2UEF5WXN2cUhhd2E0?=
 =?utf-8?B?cElhbFo0VEIydEs1YnpyYWgrT2NjeFFJaVRVSDdqalE4NEdGaTllTnRPZ0VJ?=
 =?utf-8?B?TjNQSWFFU1VSUFJxaEE0OWlJZE9TRkFra2JGaWJ0Z0cyNDR6a0dQTjd3RE5z?=
 =?utf-8?B?cVZPbWJybjlISjNJU25zN0p5R3RuVndHdUFTc3Vjd3pzeUJKUVZBYjFlRUto?=
 =?utf-8?B?T1dmSEtOMXRJVWVqcStVcEdaSTE0QVpBTE5zU3dqZHJqekFnWFdrMWo5RnM5?=
 =?utf-8?B?dTFEOXpOMHVCVDFveXZvU1pEdml2UDU3ZFU2eHczRWVCZFFoakV4UEtTR2pW?=
 =?utf-8?B?cnpTR3ZYQ0xjYXV1QjJKZ1BtUCtmWnRUOFJNekxxQTVvcDQrZ2phdnFCczZ5?=
 =?utf-8?B?a1hpTkVYTzRxL2laWlVnakpGMTQzOUFxWWRTNFYrVURxTTluREZRUTJ2OHgw?=
 =?utf-8?B?N09EaHBvZi9Zc0FoL1lQYlVNTWdPQ0NRMnVINmRHWHpLaTRuWkJTcFBxTERs?=
 =?utf-8?B?TGVwSHhLY1c5UXQ4T1J4Y0NzYzloZTBzcFVocUMxa3Zvek9jTnRUUzI1REha?=
 =?utf-8?B?YkYrRmNsNkUzVlJlS2Jkbnk1Q3dsSnJHN212cHVUVnkzSDEzL2Njc1RkTXFS?=
 =?utf-8?B?MUJoaGtsT0V3TXF3TmZ4Y3hYWmdzK29jY2R5N2NUc0JUb01CdUVxcWQrbERF?=
 =?utf-8?B?KzRGMEpnV0daRmdSRDA2TnIzNFFwSjg3SmxvcGJXeXNlMnJMMXlhL3BHWDQw?=
 =?utf-8?B?OXNtWkZxSFVaaHNYZTl3WS9CRnJzYkxZRGdEQWJmZ3hWZ3BMV1d6SU9QUFAy?=
 =?utf-8?B?UGgwYk82dER0TFdER0lHVjJMNHQraDlkRCtmMllqSXcvODl2U3FEZ2dBVGlz?=
 =?utf-8?B?T1VIR1JQRVdpVkU3Q1ZER2FzaFFkUXQ5amFxUUhFNTQ1NVdodWRvcXZIQVcv?=
 =?utf-8?Q?vktgqzP/mocI3+p+EzHqvn0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbd307f-4542-47e4-65c6-08d99884a383
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 13:29:29.7949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WoVzLhG2Hj2JuPoucCGJvX467bt8bcbKnrHzeVezs10ObfmDQ9/OjXdrbC++RkIEvF3oCMLahiWQ9Qy9CWGDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
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

On 2021-10-26 7:07 a.m., Stylon Wang wrote:
> [Why]
> In GNOME Settings->Display the switching from mirror mode to single display
> occasionally causes wait_for_completion_interruptible_timeout() to return
> -ERESTARTSYS and fails atomic check.
> 
> [How]
> Replace the call with wait_for_completion_timeout() since the waiting for
> hw_done and flip_done completion doesn't need to worry about interruption
> from signal.
> 
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>

I think this is okay, but I'll write out how I think these work here in 
case anyone has corrections.

Both variants allow the thread to sleep, but the interruptible variant 
can waken due to signals. These signals are a secondary wakeup event and 
would require use to restart the wait and (probably) keep track of how 
long we were waiting before.

We want wakeup only on completion, so we should be using the 
`wait_for_completion_timeout()` variants instead in most (if not all?) 
cases in our display driver.

This probably has some nuances that matter more for different variants 
of UAPI, but with this understanding I think this is:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Now, if we could revive that patch series I had from the other year and 
outright drop `do_aquire_global_lock()`...

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4cd64529b180..b8f4ff323de1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9844,10 +9844,10 @@ static int do_aquire_global_lock(struct drm_device *dev,
>   		 * Make sure all pending HW programming completed and
>   		 * page flips done
>   		 */
> -		ret = wait_for_completion_interruptible_timeout(&commit->hw_done, 10*HZ);
> +		ret = wait_for_completion_timeout(&commit->hw_done, 10*HZ);
>   
>   		if (ret > 0)
> -			ret = wait_for_completion_interruptible_timeout(
> +			ret = wait_for_completion_timeout(
>   					&commit->flip_done, 10*HZ);
>   
>   		if (ret == 0)
> 

