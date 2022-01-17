Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADCBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 07:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD7C10E5A2;
	Mon, 17 Jan 2022 07:24:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D987910E672
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 07:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irk4OIGsaTiqrVCtO+D4LjTAC8TWTZMEZ5HHO0y9srnycYOGMr3azPEpKz3xf7zqaB/EM2KcJZDKHJBNMnjxYLr1u++exYfcSyzaKsCoaOwxXpxXnv4+HH/IHEQ0IcP0w0zj3CBsNcYQmY4TlEf27NtPuulrIzXc+u4EXYed3Kx8/gBY7dLOo7alUOnJvM+I7hmkrktQtEMyS9ZyTbJT4g3LjH/SroaDKbmbGDT6EcRZdJQa5bLT0UNbK4nfhe8IOzYyDNhzJUteyXhEt5sN/LUC54wYpe/MgS6FfqEznzdkDhSqQN/cZ+WNVWUd7l7efL3zqoea51Qdki51QPXUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhlKB3NblNDp/dV6L5noA/EsL+mmYTmoa1IqN8mH4jg=;
 b=ilsvXK5Sm5N24J4iwX3C9YWxP66ghCVKjyY54UEKuXuCcEPvt9rXUdME0+VoADw7J+ziVBzxnlygRKSooTyPHWyIZXidOWyLImBPrh7EtVMlD1DBdFiSPXCJYs0h17UNO/rVo3xBe10mb7qoM8nHf4DgsbL+ml93fMe8xU9yaDuK8KxA7fOSZFFUab/c/brkdfCPCpg+HXXFFghuG7tzTVvo23dqttzpEvVhEiGMegRtnCq3tL9Eb8/n4aW0X0xDgRkcRKNKCpZrPHWIvxbjFYtH2/pmevzbwQkJU7w6HVEmT7WqnHYcQs8EPLQV0weg50dVVY8kaJaJfuw4jUo+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhlKB3NblNDp/dV6L5noA/EsL+mmYTmoa1IqN8mH4jg=;
 b=1QFQRLWxrIgHrt5q7FkpQIk/BstjCVKggeSbz9XBT7x3k5mNE7i3gYERFKiMQ8plKdUg7/YC46EzeoO0aq+8DL3TrY79QgfgWAuqqH98qsQjy46LEf0z2SNvoJ2kNsxqObWlkXlmg6qKTIPBFEWcldxjVPqX2HpMpt9sDMLIIT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MN2PR12MB3968.namprd12.prod.outlook.com
 (2603:10b6:208:16f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Mon, 17 Jan
 2022 07:24:49 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 07:24:49 +0000
Subject: Re: [PATCH] drm/amdgpu: limit the number of dst address in trace
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220117063202.27628-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a6b4c6e9-3186-cbd5-88f8-96a0be8f1ce3@amd.com>
Date: Mon, 17 Jan 2022 08:24:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220117063202.27628-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0111.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::17) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ca7f1a9-27dc-46bc-1754-08d9d98a71e1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3968:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3968CD52295E44DA5F2DFB1D83579@MN2PR12MB3968.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrrC4o2VjFMB/BMVzHurDmmBt2J7zoTKN6321dFPXHI9hOqzPOa3D5Br4RHq5BjfjFMQsZMxQfXuoNDPeO8uhCkTG78hfFsVszzjw98OHDUth9ByH6r5xAUdKkb/8HQnCk07OPJrmTkzxPnc7AErTXcghWzHSWbz6WRl4A0lHdh/G7Z2E0L/ziJ5aegz6oQ4K3xaEU6EUiAEJj2QapKSNjd2hqDeZBVbKpPWLf4u3yja/lH95nOplsO6mdEAa92f90IhBdvGcaYxpfI+AEXr0adyFbKOU+te7DVr1DaAj94XyazL1XbE3hJyQyKVZWmEz/+c7hXSbs4j+U63Sx9Ns8el8wz7vhd9ILx4ctl3U+bDFqNzsSFsgm9at9wrHT/DxYadW6PA4LdhsWjQA9mjLakZGQvoEO7FQwfTP8SWgFqXuKvApvsYqCLgKrBsR/62fuiTroeLB0cxbXcAOq30aHCNblvoKXjtnAMzgyiC+kuEOx6vAqul/A6x+SuDziqH/4CtixH1jBlYGu5gVikXZ6oZhqE7pMRSykWL3kkczcyUjCpuC+xT5UzbcdX2n7nrtrOIVoIYqwRwl33IrEWMK91b27VAFJLOpWZDnBp5XQzkpAWmmhkl4k+LjVmQOWTDd+Dfc9p1R4nLgrele0qS1avcwV1+zsgvwEXp1q7pPS1m7rrDVxyrh9NjvTsRT2TwQnGMIHN0S1EcgqKLrNBjbVl9s7/BS2dAuNCxbBfW0DtziKhkc1LU840r95htnUJO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(83380400001)(38100700002)(6512007)(66476007)(4326008)(8936002)(26005)(66556008)(186003)(6506007)(2906002)(6666004)(6486002)(508600001)(316002)(31686004)(31696002)(66946007)(5660300002)(36756003)(86362001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnpnaDl3dkZFR2k0T3ZuZTVMVERGMlZsRHMwT2Eyd01tRTNma1pBVC8yeng5?=
 =?utf-8?B?bTVvT0RYN1dzVzdvdXZWVXZCNW1XVk5ZeTV5dzcrR3JqWGtveDNoMDlyNEZ5?=
 =?utf-8?B?T0FDWTl5YnZyTDJRRW1OcjJZb0s5WWF3K3NWUU9ma2lFK2N1czJVOWxkL2Jv?=
 =?utf-8?B?cHp0cE1HWVptei90NVZoRzBkeVRtN0Z6aHRVYUdQWDhnMGUxQzlEcTZWSjRZ?=
 =?utf-8?B?ZmtiWS9hWHZBc0xuWlV1a0hodjVpRkFFZTBJTEE4NG5ZZHZTbVl3MFJSN1Zy?=
 =?utf-8?B?OEVmb0Q1dWg0S1ppa3NMcXRrUGdzTngvbHlQSnpaNXpxTXJkdnFsbzVVZHNr?=
 =?utf-8?B?MFl0UUVqNW9iN0JYRkNUUUtUV3Fha0lHNUdWRnNjLzUxZUorLytEQm1rdUJL?=
 =?utf-8?B?ODlLbnQ1NEtRL2FUZmJodVphSHduRlNwek9qUXhtR2cyOG1XNzFTYmxYZStN?=
 =?utf-8?B?anQzdUNqOTYrYS85N3EwSUFOTkNvK09MNTZ5WVpsWi84eHJxVGpzRGtaeW91?=
 =?utf-8?B?dHZJdnAra2JZY0V4SjFXTXdHeWo2b2M0cWphREdVSmFkZW5IUHBST2UvQ1JW?=
 =?utf-8?B?enZiYkZUM0JmTGpsMGZmeTVDTFhiQzc3WVpoOEx2dmVLdDJsK3U4ajU2OGxn?=
 =?utf-8?B?dXNqVXAyVVdKaUsrbmk0V0lkZUNlUXFrK05jOVZuZXdrTG9VQmpqOGVNY0hQ?=
 =?utf-8?B?eHZ6UFljUzlzUzhkQTBpbXFNb1B6b0hSUnRZenpzR3RidHNIUENZUGV2U1Zk?=
 =?utf-8?B?TEFpN1dLZkYxMkNJaE12SkhqUExIRjUxWFU3S1lXZjRvbWNBL2dTRXJqVGRh?=
 =?utf-8?B?T1I3NlZZN1I3c0V2Ly9McW5LY00walo5VGJyZXBUV2Rsa1pwdWxsZGNBTHhB?=
 =?utf-8?B?MElQNis0SjBpTzlmbTlWVHpFRGhMUERLbjhxdS9EU25wZDhlRHBHdE1CKzNE?=
 =?utf-8?B?UWFPMzF3bXp4dlF2eFQvZjlteHovQWNzVFVpKzVDaUJpTVBUeEtqM2ZjVGpn?=
 =?utf-8?B?TWh3NzhIQzBZdW1vNUl4WUFLcTRVTkZDYXFyaDRjdHk2RjJneFNsQVdqSWVI?=
 =?utf-8?B?OW5mc0JsRHVEQ09KUitDZjN4QXdjSEdLNmRLeDFLOTRpdWlzTXJyNzJIOEtk?=
 =?utf-8?B?QXVRRWVWYzlmeFp0azBmU08zOGc4MjlRZDVmTnlyaENwNzNqUytyUko2N3R4?=
 =?utf-8?B?dkFoRVpSYUE0TFRMU1BwK1hQRCtydGtRd0t4SlRDdlJocGdFUW5hclRiVUpp?=
 =?utf-8?B?VksvWllyZmhVZklENHg2bTJQWVgrUjFvbjVEU2JLS1RyTERsbHI4aVJkckNy?=
 =?utf-8?B?cExhNWtwRVliZDhxeTFkNUZuYXJWSVRSQUQ5OVZzK2twUEYvUVM5TW9pRThx?=
 =?utf-8?B?WmNPNkVFVVZXRWFJcGk1a1BKSlB4blRZSjBzRlE5bmdsK3pyaGFsYzZ3SGRo?=
 =?utf-8?B?Y1d2dm1MSkVYT2p0N2ZrMGVyVjZWUTNlWWp2ZEhrdTBhUm84TG9tV3dpemhs?=
 =?utf-8?B?ZWtEUzVJUE1mc3FMUTYxY2ZvRjVXT2hjTGlLL0JLVFJaVWhLSndqTkFwaVE2?=
 =?utf-8?B?L1pRejY2ekxDOUdObzhhREtVNkoyWmZPMWVDZjhTWXNoK3orUms0a29LeWFG?=
 =?utf-8?B?WVF6MnhNWFZIcDlkVjlPKzdhME1qN0ZOWkxFbjIxaVkxNkpCOWZMTnVIWWZD?=
 =?utf-8?B?MXJFMnl3a3pHVENwV1RkMEN2em9xWkZGSXhQZElGUjFkYVlHRWdjaTc2dTlp?=
 =?utf-8?B?R2VIdVJWZjNzUWJZcFlDMjFOaFM4R1VuY0VEZGhZbVMrV2VyRzRoSlVxRm15?=
 =?utf-8?B?QVNFcWhDb01IZGRDWnVDdy9xa25wUlFUTFVBbmlQZ0d3aE0ybXlTR1NpUm55?=
 =?utf-8?B?YmhpUHdQSHdmdUdtMVVYREp1WlU5Uk1JL1k0ZXRSYlZRRVZ0ajJzQU5ZVWow?=
 =?utf-8?B?U0hqRm9rZnZLV0tHSmZad1U2MFdNL0ZnNDlaZytJbXFZdStGeEV4aTZkb211?=
 =?utf-8?B?YjE4Z0RmSUE5V3hqOE1TOGFKRjBPcGdSb1hnNzR5eGNsb0g3WXhLaVkyTkht?=
 =?utf-8?B?TzI3SThCaXpHcXd6SjlyUEl2bDBvWHl1NkRETnhKNEgvaEhTK3JVeUd3Wm5p?=
 =?utf-8?Q?DiLM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca7f1a9-27dc-46bc-1754-08d9d98a71e1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 07:24:49.1114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8m1C89mSzrDBxiSkeNrqGTkBIEDflDVQJqG84rWS9CjdyJtIt1dfSNOhb44Mjh5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3968
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 17.01.22 um 07:32 schrieb Somalapuram Amaranath:
> trace_amdgpu_vm_update_ptes trace unable to log when nptes too large
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0e7dc23f78e7..f367fcc5c535 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1634,7 +1634,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   			nptes = max(nptes, 1u);
>   
>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
> -						    nptes, dst, incr, upd_flags,
> +						    min(nptes, 32u), dst, incr, upd_flags,

You still need to remove the same workaround in amdgpu_trace.h.

E.g. something like this:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d855cb53c7e0..a48b34d4ce31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -358,11 +358,10 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
                         }
         ),
         TP_printk("pid:%u vm_ctx:0x%llx start:0x%010llx end:0x%010llx,"
-                 " flags:0x%llx, incr:%llu, dst:\n%s%s", __entry->pid,
+                 " flags:0x%llx, incr:%llu, dst:\n%s", __entry->pid,
                   __entry->vm_ctx, __entry->start, __entry->end,
                   __entry->flags, __entry->incr, __print_array(
-                 __get_dynamic_array(dst), min(__entry->nptes, 32u), 8),
-                 __entry->nptes > 32 ? "..." : "")
+                 __get_dynamic_array(dst), __entry->nptes, 8))
  );

  TRACE_EVENT(amdgpu_vm_set_ptes,

Regards,
Christian.



>   						    vm->task_info.pid,
>   						    vm->immediate.fence_context);
>   			amdgpu_vm_update_flags(params, to_amdgpu_bo_vm(pt),

