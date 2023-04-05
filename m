Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3328C77B6C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 21:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C1EE10E237;
	Wed,  5 Apr 2023 21:49:03 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E3410E237
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 21:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWEfoN9dSjRwl8gGLn7iaQBTmuBRGbV0ExjVZCgDhFKkwqchipVbI68GTJZLo3rfq/fOkx/PjkRu27vfLp5PDbYzO5HyHsSE//aYsFSuKrlqMQXOigrNO1KMSO7mHQbu6hy7XCHZClP8EZFSvcR5GtjE7M0RqzElNG2rLB1VlGHksDuiuIzJHjx8zzSwqV65R7tz7Y2y7pR3vejB3ia1g8ixJWLBwr9rAX8xIK18LTAj8aFyX25gnGKTDWy9ewUCiLkNzdtc/xTNU5md+SGDufQ1PhhpxD52hrfr2pn5kHyWjeGUGXjzTBR2YDaZF7h9JAVoVdIHhasIbziUC+i02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4mXbz/87QArkP7G2UIBSexcxGce5ZyzOsOwL9Ebbgs=;
 b=COv0Pmh868AxwxvDYiitjHjmxc5y2/xJxdWhsHJg34LmYS79yxP1oTLZ1MTQMhdoA97JkrgY1p3UY9asRl0g+wD7oemPAM9NUICkfddGbZzOmmXjITmuWV4QlNilyhYZInE5nOAr41WL0XSKBG5IPe4g/ojefxQZTjMuYXqkXkW1DL7jL0mZ7zG8pywxiWklf1rr17m9yxKs+a8mzuntEA9m32kbQXlEY5l14fFFxiuYInf9PaG0i5XjBzMDQ+rZppoeAS36nVST69O9hH9d62jEKCD7ajCFF8CYhg8yEKGd+uZUjhFXF70x0oThTnkkaqzyFZ7ej+G6Ni5OLmBm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4mXbz/87QArkP7G2UIBSexcxGce5ZyzOsOwL9Ebbgs=;
 b=ny3LVxpiciwnPDfp1Adn5pDW+pjNsRdtcRX6Q7s0FxXe9lcayz+T0UA0BpbQgwvXn+sbBqoBsQu5Gqg+3WxzqZaQ2+ahYDRVfeVDlGJ4w4YlvPW6a1vmhbWZqfMbQgdIN9x9dstnnQbnfXzWybvYhMbXEyzWEWa+FoIivRNsa8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 21:48:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 21:48:59 +0000
Message-ID: <e9548a5d-35ca-b1a6-02e5-7dce6c7addb6@amd.com>
Date: Wed, 5 Apr 2023 17:48:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdgpu: Update invalid PTE flag setting
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230404215923.3739152-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230404215923.3739152-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL0PR12MB4900:EE_
X-MS-Office365-Filtering-Correlation-Id: 170688ab-9485-473b-4f7c-08db361f8ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzRsmtnloHzvr2W0VXAfsvw/1aJBkBF/w2dRsCgGqTELz+laYRYI+Bz3CM0cTQ7jOvdpcWHj6az/mYZYfj5WJLDRoTm4zBfwmk/doyqqvvLvHxH+N5s/CkZqpmHHwhRjsHk8dsKvquwTLfv/KU9cU8S7J/RXET8LeP1CcP8JQxTS2RDP82A38Gujwkw82d4Z7BnTqtWO/0dv7TmqRXJuh0k+imhFp4GWElzs8nPKSiHTCI6xey7QNark6a/fvdr1kTS+XtmM0mqKxNYqQd00a9ZsEQsS7sQiejTaOgs89Qj4L3yoonyzWnwdDqYwrt0Y/EuO5is7pi9cKWFDNdIQovPgzahPg154qLaklameuy+1ugQ8W46Vs8pkoRR1HnKYPjIs5wwT48KwS4VDhKS0S5z/IQR5Ta5BO5qobrGVXd/w8spC8mnzq7CL/mu+9usj6aHAZn2ffw4rb4XQlNMadWPNDwfEVPOcsS0i7ruRUY44eL/HDGNN0hhH7svDmhWmvO5LF+vT91uQoylQup62SeuuTXC1nUIWEvJdAwxrh5CoUF9eAvuSU6hK1lD68BqOqPzPB4Zl9JrjyS4pJmsJqrzjByCJ402apmvJSGrs1agPYY1FkqhBE9gmmW6Fq28UtarLG3p7F8PFtuw/x+GhlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(36916002)(4326008)(478600001)(66476007)(8676002)(316002)(66556008)(66946007)(41300700001)(8936002)(44832011)(38100700002)(5660300002)(186003)(6486002)(53546011)(2616005)(6512007)(83380400001)(6506007)(26005)(31696002)(86362001)(2906002)(36756003)(15650500001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlRYditFZmI0c01HSWRoWEJLTzhoTHQwYU9hRXRGTktJbk5KdGFCcVJYemw5?=
 =?utf-8?B?UXcrY1VxQS9PcE0yaTdObDNDVnRyWUp2SDRobkVpSFJxM1NYSERtV3g2dFdt?=
 =?utf-8?B?ZzUvOEFXYnZnVlRQTHBnbThSSnkvNTkvNjcrZzZwanFkVXJYVWxFVGkyMnhw?=
 =?utf-8?B?TmZGS0ZSeGNsZHZtMEhMY041TFBYVlJaeEhUeno2dnhDZEk3NGZkMGtXWENF?=
 =?utf-8?B?K3p0OHJMK0xrVkZmdTkzUUZrNHR4THJtWFJTRm1LUDFOVGpZeS9kb1cvSGNr?=
 =?utf-8?B?YThhTzF0K1dHZ2NydnFiT2xoZFg0cEtWeTV5VENPU0M3aFExVjE5bys2Z2dr?=
 =?utf-8?B?UnlUY1h5aEI2cjhKcDhOSnB6czRYenNUM3FxRHJSdSswWUlPL1hWTGI1cURy?=
 =?utf-8?B?c3hPRUpIN0ZvL1lyZWU2UUVTSGoyWnRubmVGL0pIVi83WWtROElrd2tJY3dm?=
 =?utf-8?B?ckxLNi9LRTFwTFN2eEJPV0o5OFdzWm00NTFBQkNVK3NkQWVET3dKTTUwWFdB?=
 =?utf-8?B?UkJHcHFiWFhNVUh6TWVsN3VpZmYwL2FOSHRSaDkzZHk3Q0lZbTlyM3hUeTJG?=
 =?utf-8?B?YWdhQWxJWlc4aDFIQlI3bHQwam1veEhZN0Rsam5IYmtPajA0ZHBYN3RLNGRi?=
 =?utf-8?B?MkdIRDgyOUw3NXZSbk5ud0VZNWdqdW1lT21CK1NlMnBnd3c0TklUQXo2cFY4?=
 =?utf-8?B?SXNROEk0V0FyM0pyRjNxTU9PVFJXcDhOT1pjMk0xWDAvU3JzZGRaaUxhUi85?=
 =?utf-8?B?ZTN2eFhsVVZJdG50YTIva1dkblljd21qdC96aGMvbzdxS0dIRmVKUGZsZzN2?=
 =?utf-8?B?UjZLSHh3YmZlZDducEsrbG50cEhEbTFzdWljb0srMUdIeVhVS1p6SzI2UStN?=
 =?utf-8?B?RGgrdzFDbHBYcWQvYXh1cmtuVzRGcUlodjlMcjhxc2NlbW5ZaVdSUkk4Qk1S?=
 =?utf-8?B?czk0RkdKWFZXVm1na0gvRTdMTDY5eXN5T1pmTE5RdkJFdHZXRE1YVU92S0JK?=
 =?utf-8?B?MjZFUzFPMXdNTVVxdWJMY1NucDJNV2tHM0NFNW5sQXlHbC9hcFdZcFgwbmdK?=
 =?utf-8?B?SGxOK0lpbGV0ZXVSWDBma2hvbkEyT2FhOXFKdG5NK2dsTXBlbFR2WnhNVXNv?=
 =?utf-8?B?NGZtVWx1Z21DdFh1eG5lR2plbHlZeDhjcW8vV2dKOGN4NlpWd3lYekdyRFdG?=
 =?utf-8?B?TVFROHo5aXE1bDAzTFJJM3dmRi9GK1ZZVnJSblgxcnNUL05OOTdqNEtIeEZv?=
 =?utf-8?B?YXBWZFBxYloxZTdNSGxCZENNSW42eHpodVBiNUtLREV5N1JGWklxdFRvNGNO?=
 =?utf-8?B?aGNTS1MxcjNDTWNrSzV4Z2RJSmxrZ0JCNE02SElReG4xdW8zc3BjZFdNZk5U?=
 =?utf-8?B?Wm9vV25HOEZ3LzQ1aVowUDFRYVdMNkx3RnNxZFdON2Y3UFhYS3RVNFlPSEln?=
 =?utf-8?B?R0tIZkxxM1Y2cXdZTmhIdkdFa2NvTnpJVXF3MmJ0SVpGRzJnMERFTE8zVU5n?=
 =?utf-8?B?TkFBcVlqaVZoUWxaL1hrTUczd1pyYUw3ei80RHVKRkNmY0RyUlkrMnVnSkJ2?=
 =?utf-8?B?Tm51TjlrLzBJUHdMZHk1dTBpR2EzRHVWakJsVVF6WlE4Z3BsVzRPMHRxNW81?=
 =?utf-8?B?aER3dnFva3lkL3VZWmJXcHBJeFQ1TzNudG1DUXViM29vK0wwRXZyb3cvTWRK?=
 =?utf-8?B?WncyYkIvVnBhc0ZrVm5qYklIZjh2aTUrOEJlZWc4VXdaamNUaXJ0Yy8xQVFU?=
 =?utf-8?B?Mi9GTXdhRnpLNjQwR2xYaXFSQXNwYXpXcDJFSmhRRjh0OXZ5ZGllUzFXdURJ?=
 =?utf-8?B?MG9HcVR0S0craHFWTE1VVTR0SEloaFZ2SGZnZldNdlMzTkZBMDlUdEpRaG1U?=
 =?utf-8?B?aEJNVWpRUVRydFZJbzJ3RDZmMXRhVytESUZKRzhoVWVTREJWRkUwb3V0YXR2?=
 =?utf-8?B?YmVmVTNJdk9Sbng0aGNzbnJNNXZhY3BEdzdYNEs0alMzWmNHRWgxMVVScDBD?=
 =?utf-8?B?TllmdFJsQ2t5RG9ya204aVhOLzhoLzZqS2F5Yms4b1dOMTZvTVFiN2o2dTNS?=
 =?utf-8?B?MkVrd2NDeHYreEJ3OG0yaWZlTiszZUp3L0ViNmZMN3Z0M3AxdXhKcmRIZExx?=
 =?utf-8?Q?U/nW+nRF5ZtxOtx83QQ7Tyb58?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170688ab-9485-473b-4f7c-08db361f8ffc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 21:48:59.2388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+nXdJe3vcUTgW3y2abOJG5ykB0sBsmcp6Uq5z3OBG6M2tUTQbtEAJVV0Voj0F7d4Xyl437J+0J0A0q1G/x/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
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
Cc: jay.cornwall@amd.com, laurent.morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-04-04 17:59, Mukul Joshi wrote:
> Update the invalid PTE flag setting to ensure, in addition
> to transitioning the retry fault to a no-retry fault, it
> also causes the wavefront to enter the trap handler. With the
> current setting, it only transitions to a no-retry fault.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index af6f26a97fc5..5df4f7bb241f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2488,7 +2488,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		/* Intentionally setting invalid PTE flag
>   		 * combination to force a no-retry-fault
>   		 */
> -		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
> +		flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | AMDGPU_PTE_PRT;
>   		value = 0;
>   	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
>   		/* Redirect the access to the dummy page */
