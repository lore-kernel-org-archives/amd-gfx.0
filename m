Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D34C678D5
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Mar 2023 03:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6705F10E02B;
	Sat, 11 Mar 2023 03:45:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8B210E02B
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Mar 2023 03:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuGpV8wLhv2mix6WxtMJgFS8sZFfx/26otOFZhkZxyFDSJfF0G88CxcTliRYD3byVQZzg8g3BiFB3howPUcFF/qqJwikQOPsxAbjn2FxbuYhjSzGGKRYp59LRC48oyoYUaTJQn5w2wfuJr9NWadiFPLJnGIF96/CZc15QvDT886ohm1uuhM+lP5XeIpuOi2v4Co5RfrXawwxmujR+kuxt3HftfEiMf6JMWbSMXgbzk4jXZn+91rggveSAky0goNKCmf23RC51c/QPrjbVVXmDhRA5PjVl41AJZIxy5Vikr0wV0F7xPD9AJfGQEJ1RmIoLT09SDgFp4nEBW7aG+okIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pAcMu1bYQqlAMuN7mPIJDvkEHOGm4AKNYIPl2PGE0E=;
 b=aUdXXXUJvoe7uQn1OOisJNIypdXMyHj8psmRi4s5KL9R3ybZdxwtUxuwKuxDzC3NMoxVtehEWz2zpAHi/Hd+Q7auVodFs3qhydTuJWUD+NwR8Q+SnsAXMxZxA5W0qEVh1tKtTSS3Scb2yZXaU90FOFerUwnQ0IgKUR9Xu+Jx0JGItskJzkzLqF65tcHmx7h01txLth0WnBj2/LaYJhVnTREGzkUdQnnROI7QYCcWX9PbOHAHVQ0LYma697GlfeH2DXMgQfGsxvJjXrrTbvm/ukFPMnm1Brw2QV532bPNgGZBAh1PWDgBA+pnY/LhL7aC3aV5tDekXBN6qxbvCFhStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pAcMu1bYQqlAMuN7mPIJDvkEHOGm4AKNYIPl2PGE0E=;
 b=x1QmC1WveOCa/+qhbRHYc/uBa/ZDolchUbblfU5sJau56Ok0FVJWSwARjTqDNECNMSHLa7w5kZYXt5/Nqc7aMdaACFJtb1O6HPiFlxjuO6oFzKfIph5BJH1IwzTuRsPZvUZewECQzLMa0g5uvvLxMi7cTvAzn2wI5TO4C2OOJWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2510.namprd12.prod.outlook.com (2603:10b6:802:28::26)
 by DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 03:45:47 +0000
Received: from SN1PR12MB2510.namprd12.prod.outlook.com
 ([fe80::e7d:e95d:e6fc:78fd]) by SN1PR12MB2510.namprd12.prod.outlook.com
 ([fe80::e7d:e95d:e6fc:78fd%7]) with mapi id 15.20.6156.025; Sat, 11 Mar 2023
 03:45:47 +0000
Message-ID: <a17b7c77-09a8-5129-cd1b-3b0ddc2c1510@amd.com>
Date: Fri, 10 Mar 2023 19:45:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 1/2] drm/amdkfd: Move TLB flushing logic into amdgpu
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
From: Daniel Phillips <daniel.phillips@amd.com>
In-Reply-To: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::44) To SN1PR12MB2510.namprd12.prod.outlook.com
 (2603:10b6:802:28::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2510:EE_|DM6PR12MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e695fb-7036-4bc1-c98f-08db21e31930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1FMBOnYlcuKMKDy2p6JHBfO1VoisNkEiamrs8WUzmV5rmt2OJ2cEzB/Fgu0+G0xaQg4VEQ9+OYhSem+oPHWbMtqeo4l85l8iLnnZGhLIwrxhfrosg6hSGJpClBHDHr50USjf/l0LaTNK+DEUvKnVGzkzqpO19S0Xj0RYJRJYG5VGr5rPZLRHoAwwUPMHVbpvGjqodFNZP56a8gPsuOI5FRFKJeyxGCI8yaFHqM9psUh1YDDdqkKhQDwC3ixo+alTzRdp+LFXZh8RYotVFvxzkZf3VMoqfKk1yV2fMWo0sA/bWyEjEtjCpWE428z/zMtLUbMNBXTsudUhG5mm9Reli50kg8JYaFHFaNBv3SjCFDM5DwMgv2/ViOR/P2O53to6HLPASOqHIXWVAkQ0t4Kmybheluvo/aRzQhIzafBqdiKl7MQTbVHpqdBZaGoqMFXEZGdGLMeMXT0WrZ5bzSkPW1oS9CnxGtLoatn4HkbBEgbk/mB6jcB80WocGpG5TSiOXl8c8+2W8hOLCl2ZpUWhFUPzqEl1Y7i85Re24LWBmi90WIdaSNAwo++aSjdgRCEqR5Cdbtok1r2RBBd5fyIWcNOXxwG7RPJj38qFGrQ+4vMxGZtTOsYFf6T1IYKCinrbn77msP79Cw0ozRhBzk678qwKNrgGHw/fnvbBvik55bNrKhu9Lteyywz0V+s8gqsb9Fb4Xuer80Qrxp0QN91mIBMGhPj1d5SiGUMd/kWv1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199018)(44832011)(66556008)(66946007)(31686004)(66476007)(8676002)(4326008)(41300700001)(38100700002)(2616005)(316002)(6486002)(186003)(26005)(6506007)(53546011)(6512007)(31696002)(36756003)(558084003)(8936002)(478600001)(5660300002)(6666004)(2906002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnAwd2NsQ0JtSHdSRjJmSUc3V0ZhbEVCak52T2JCSGtsajlTY0dHemhRKzhw?=
 =?utf-8?B?MEhMd1VQcEJXNlNIc3B5aWkzd0l4Q0lTbVJZZHZsL01kcDl4T29GWG52Sy9G?=
 =?utf-8?B?VjgxclhmY2c0UHpZaXJYTHN5MGRpSlFBZ3ZDcVlnbmtWVkhERUlVVnk5K211?=
 =?utf-8?B?Y3pqdGpjRjE0NEdLVGVwRldra1FNR25UTXV4MmNFQVJLWFFEeE1MZUliSVNw?=
 =?utf-8?B?VlJOZ3VveFlVdDM1VUxjWlRMdGZrMUtzaDR6OEFXSTJ0RjMxK1NXSVhUU2lU?=
 =?utf-8?B?cHZJZUhKRFp2cXFteXBFak5kdEdGVHZ4Mjl3VUxJSmxDa0JCeFNQTnF1SHBZ?=
 =?utf-8?B?Y3NrUDRoSDUxaWU5RGJxUnZxNndRUEFHMFc3TmxWVGNvRkVkaVVxZG9pVGlY?=
 =?utf-8?B?NzhiZXVuS0w4UzNFZHVqV1NCMnNTWHFIUDdZdE50WE5UWG1lVzU3N3l3bzh6?=
 =?utf-8?B?d1pCdHVXRTdpQ0tZWkRTWG1uQ1g5cnV0M3RmZXdVRS9aaG5CYnZDM0xRRjZM?=
 =?utf-8?B?dHNvZUpGM0N4NjdFaFN6bGNtOGNLNlg3Y2lESVNpK2FFbjZMb2Nxd21wbE5I?=
 =?utf-8?B?NWRydnQ5WVVzSFBDRjcxaVNkOXBVZVFVMEVIVW9uTkZlSnByMmhLWTdmZUpp?=
 =?utf-8?B?dlRnZlk0VFl2UnE0T3o0eWo1QWVLUzJhL01aZHRjTjJEd01yU05yenBXTEhL?=
 =?utf-8?B?ZGRHZ1R6Y2NELzdOcFdXOCtpZjBEclQvK2hzS1dyUmdlQ1ZLbzE5eWtxc1FJ?=
 =?utf-8?B?bzZkazhkUzRYVmZ6d21tT0VMTGUyNXdnMkFhOWhHOGhHRFdmUUY1MXcvYTlm?=
 =?utf-8?B?emlPK0Z5Rm9yem9icHBFUGYzMlhacXhVK1gzRXF1Y25aaTd0ZFUwSkVERGF2?=
 =?utf-8?B?eTdDOTZTRVM5K1FmeDFzdXFqM0w3M0hFTjFyWlJSMVovZGl4YmFOYW5tNEpL?=
 =?utf-8?B?RHFFMVhMeVZQeHN3T3FPOWV3dlZUZjFOYzVJTU1ZK2RCUHhRbCtSVjJLZ1Zz?=
 =?utf-8?B?WTJMYjdVY3BZUmsvYTBSYkw1WXV2cWxWSWQ4bHJwYUNNWjlWdDhNWWFNeVlm?=
 =?utf-8?B?dFhOWi9ZOEdoTTd2QUlWSlAyVnZsM0E0b3RueFlPZDRtRGNCUzQ1V21HeTNs?=
 =?utf-8?B?ZWUrOGgwcnBHMFlGenBTZnllZmJ1N3BqTFBGWkg3TjZsemF3NWErSkMyUEdW?=
 =?utf-8?B?VXpsSTJtQzE5cmYvKzBBKzUyV0MvN3lOZ09ka0VoOUxmcEF6TEJ0S3hGbWRC?=
 =?utf-8?B?dm1QT1dMRW5OSDdMMVY5eEhYT1E3TDZxYk52SjZSL0pvOFVCWmE1TWU0NURm?=
 =?utf-8?B?d0lDcjVSWnIzRjA1NFdpdXJlYU9GSG1KckhJdVhDQTgyODBRajVpOTh2TnBo?=
 =?utf-8?B?bXJZaVVQRGRDbWFrZGszakYybW5CVWtVdGFMQVBXUDlmb0ZxUzRjdkF6c0dy?=
 =?utf-8?B?Zi96eUZoa2pmUVk3aENQcGVhU3YzaVlUWTZnMXl4dkpnZUJhVFZPS2p2SUtp?=
 =?utf-8?B?aXh1U09GNllZNWJ1STBLTi91T1h3a3NTQWZOdXFIaWJSd1hIOGN4bXRWZFVr?=
 =?utf-8?B?REJ6OVNZaUlXMjd4NjhUWisxcDIrR0QreTgwL3R6NEpvSU5aK1E5WlVwMkRv?=
 =?utf-8?B?KzBMK29xQjBWcFRIVXdkbXo3M1ppMkNjVXExNWcwZE9KbVJ6RFJCQkdkT2tW?=
 =?utf-8?B?MndxZ3RwaHNQajdWNVhtSkp5RkVGSzFicXJIRjhtaVJmZG5mZmJxbzZzVEo1?=
 =?utf-8?B?U0FNN3RVYlQyaGliQnRpeG93ajdLOXlkbDlZN1dVUGJDdG51VEpIU3FpL3Uz?=
 =?utf-8?B?OHY4aGwwSTQrSGFQWkJEcFpqem5SbktTamoxZWhmUFdzSDhGVW1Vd1ZZK1JE?=
 =?utf-8?B?YzdEMjdHMHZJczZHUS9EamFWekpHNGZ6VU1nQXQ3YjArMlM0NENjdk81MVlR?=
 =?utf-8?B?c2E5NXBkSXF0N3FyTVNIOTgwTE5ITjNCNnIzVzhrY2orQ3NFb3F6RW13Ynk0?=
 =?utf-8?B?Q1BWL3lpRlBZYTg3WWtta1NoNlpmSmtHaHRMVzJ3MGFQRG9pZ2lOWThkcStF?=
 =?utf-8?B?dTRKRzRSUFhLU0VTNHlIUytpZVlkSkhiQktkc0RQUlA4SGdRbWhtd2Y1NEs3?=
 =?utf-8?Q?YRxdjQjHewtH6IOuIJ22wWPIp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e695fb-7036-4bc1-c98f-08db21e31930
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 03:45:47.1196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hMF29L1+keHLo/oMJWByXZ2mbavipT5W502Qn4bMAjlnEMoDp9bGT/UgIP3h77i3URTJ9OIGBylU23qfWNABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/10/23 14:16, Felix Kuehling wrote:
> +static inline void kfd_flush_tlb(struct kfd_process_device *pdd,                                                        enum TLB_FLUSH_TYPE type)

Whitespace damage?

Regards,

Daniel
