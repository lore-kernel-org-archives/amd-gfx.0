Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCE5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 16:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F0610E2E2;
	Mon, 24 Jan 2022 16:32:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF6D10E2E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGjl0EWy+1uA3J9ZYqU8af9s+kdksAsSZCO/1TPeJl17WPUnv3i4YSSD6DL3509K4Jbyoix5tnfloiovCXAmb7ByDvXVjZGGzfye/k5XbHSfCtqyGIYT+ZVjOdXgGw/5oaWyROj0QHC4q0nGslRmpVu6pRV6W2HZeeWMaquznwkipFOAA0/zvekQQJsTN+2ehOkaALa4kkyIrpss+tnqdOK5j6TVAvcLWXwBMrafy46dONyrhVpT1lY+QjTrUpHRRYkS6l+0EGyOklbPfEZJNsyveDbSdl1RyutD6QmqXiXFGtdQ94dc/fZn+Nth7hPyvnoJ1CYlmputC3iusf/LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca6xOQjsMoONsnxqOZnpkHayHBM+QL4mQak8c3Cn2VU=;
 b=WKhZPqby2kZ+leY9Zii+YJvMIjRT9OqJaLWxb9r+NMf8cSB3+ylIAZL0bj6sm7nUnXQDyHHVZBCIoehnneNx0g7SnJZ7q5C3IHRJy7FHKsTEqZu5CqLV0agUClDrjjD2mH1mrWmv/bjcgALHwFDkR770dxynHsGVKBh0CuoE2muoBsoeHueChq0+K3flMI3+BrH8JCFGlf1P1qOhb7G77DQ2ns7llVnv7HAJtvv6bDOrrq5CkONI2cx2raaZQ1VPGswWzZ3jMKktKniph3qkzGpiIUipB0zqaI9EWQFAHU0AAfaIqJSloSSqoT24KiS9CVwvfTxEiVqVYJPW2FLhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca6xOQjsMoONsnxqOZnpkHayHBM+QL4mQak8c3Cn2VU=;
 b=IJz8QA+NknZ7OhG/33v3FKYXALbjsDCE3hNarqy9COHvoYdJsT5rT3ArTFczxd7VssUcqZ3A4eYS4VXYL4PMtWREsw0pf9iy/849ZcoA/YF+ABUtDKzVxiZhPCkL7/hHXQQMnCTKQaP0EkQ4z9642b1INi0WGXSa+QSJgml5aM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 16:32:49 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:32:49 +0000
Message-ID: <e3a18180-7c02-c10d-157e-8c4b6c6736cb@amd.com>
Date: Mon, 24 Jan 2022 11:32:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5702ccbd-006f-49fe-7791-08d9df57288f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4123911DC44691D4FCD970EAEA5E9@DM6PR12MB4123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t79oloOcSsGTbxzW2+o/REB3MLmqoYuugwNQAGSFSWaWA9Rgp4DalyhqJFnAHw5EL9dPVFkirtUdAMGZEwdvRB0jc+xOzwvWYJ4cpJksSXWBAKG/kVRkj9W4J8DdKc6GeuqBDi3+iajBUWT/5wcelSQ3BlL9OKnqakuVIk0PzAUR3A0eq969QlZU5lUwYVZHMxleyibDLq5MBYn/NLkFB7CE34rPrxO7qr3MILmOQqLDxmdSNZ0Wxdac+tWmD7QYE6hVqbEaDAbIyQrIxqsN8Pz5AWn/Z7GRvCVkWFJMnA+ZgR+fbob+mSlmw/8V2R438xxFMJxwTn5AiqBs6Y7UfbDtVw+lq4/R9fe60dWknwo3CsX4twH6e11RzwcFK6g6QkQyWvjHJFD+zpzhxx8DznQXLQ2n1Q+QSmH8TWddhOKbyILNms58nvKDTtDkuxA7CFuxm8ZV8/GE/F2QDpwDuAQz5npG/csCIGpcTFG+xsmRx/DvUyWLvlLMQK7NbvRZpVdf5X57CNkCLrbW4MZ12xnd2sdUFhOYhUT550t6grrm1kJ2kSaR33ZgO3yKlWuX5GVYcZOhxjf0psoLQB1yGwSgwHqe0//2YHKjbp7rp/V7xVRbe1eOsJJvVUfnjDlVmlHL5LDnNFvVVm7AvAdskEAcD1BYuCTkwmbba4iWwjzM++kn+5iVV7bINNFjgULp5p8hQimPWLTqg5vSvOKrjcC3tMuwO8z18MeIxyi/6FNz8HDOyecFz6L3lXHddv9Bmng0Ph4q2Fx4iUF5MMlO7WWsVAlum26vtHatS+I8Yh1RGGJzlUZwP/NNTO2/TVPK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(2906002)(6666004)(66476007)(508600001)(44832011)(83380400001)(966005)(6506007)(66556008)(6512007)(4326008)(38100700002)(86362001)(6486002)(66946007)(8936002)(5660300002)(36756003)(110136005)(54906003)(186003)(31696002)(31686004)(2616005)(316002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2FCTFZlNXN5Q3daTU0wSG5mSEpIOUNmVVllR20xYTVUNUdJV1ZuWHozbU4y?=
 =?utf-8?B?aFNLN3UveEp6STlYOHZNT1RVYlhGeVpnSThteExNa3dxazZqc1JVcnl6Rlda?=
 =?utf-8?B?dlpaMGlKcExIWmhYbWFUaTFLNDRRYnRFelkrSEJDek1EY25LS0FSM2FKaWM2?=
 =?utf-8?B?OGFOLzZaNVR0Y2ZxN0NJcHRXM1lLdWhWYThCOTY3MDNhTXk4S2VwVXNHT205?=
 =?utf-8?B?Z2VYR2tpVFEzb3lIL2MwanpDNk5wVkRZUkRjOHEyOUE3YXQvODdtQzVnaWE3?=
 =?utf-8?B?WkxxZDRQaEN2ZmlLQTBTaVRxVzVtT29pY1FUL241eW5WTzJCUWs0NlRPdU42?=
 =?utf-8?B?VGlNYjNhaHJIZ1pyV3VlVVdOci9WaGdjRnZhTjB6Z3dhakcrNFI4bmpoZEto?=
 =?utf-8?B?MURuWWxiQWdPQ3BQWExWYVhSRWs5SkZLcUZZaWFySC93MmR5ZjR0U2l5Mmxl?=
 =?utf-8?B?NXE2YnJPMHJTa1JJemJNK2tuTjRiOGZKTnpMUDhidHhKTFBha2VJL3NSK1pN?=
 =?utf-8?B?UUhRR3E5WEkxUUNURzI3Nyt2RUp4MzZuR2QwYnFza0ZlQlptbkpQTm9sRHNS?=
 =?utf-8?B?Mi8rOFp3UGtxOHdPWEVlanlLcWdGMENJTUNHNWlRUnNJdFA4TXowMUV4dnNO?=
 =?utf-8?B?SHNPbFRuL3MydG13anBwM0FtZ1htek5laFlaNlZvWGF6TTN2Z05Hb3pDK1BR?=
 =?utf-8?B?MUM5US9DMDI4S212b3lGdVB6WWsxRk1nOW1ZTkovNkg3L1JoOEJCd3RUQk9s?=
 =?utf-8?B?Qk9Hb0tONlRuTVBkc1haYmdFM2hjWmZoTHlSODlBTTY5OS9Zb29aSWFlWEh3?=
 =?utf-8?B?NlNsLzN0cTUwaHBCUGlUUEREVzA1cVlsNURNN09MUElZc0E4N1NXRUdBbHVJ?=
 =?utf-8?B?dU5mNyt6a21zR0NGazVOZ2I1eFhuR09qejFMZVpsRWtDcEZ5bWNLZHVMY2Vl?=
 =?utf-8?B?S1ZzMmxlWUFUdDRURndkY3RDODc1MTBsT1R3eUJUbnUwUjIzSndlKzR3cytE?=
 =?utf-8?B?eEpTTE9wOUtyOHozOHRycVQ0N094T09UMVNoNldXbWM0QXNLUURWVy9UcEpQ?=
 =?utf-8?B?MlVsUjd4bTRDOG5ZTy9JSVFiQ2lJdkcvVk1wT0xDY3FKZHVCbSs4UkpBMWxz?=
 =?utf-8?B?NnNSQXozd1ZoS1JJK3Rsa01UZ0NQbkJieWN4Q2lQaGM0MmFmR1NPcFowSEhV?=
 =?utf-8?B?Zkg1OFoxUFc2NmlHdUVSalJ6eERQWnRucXJCelB1bXZtcGFhRDVXSUVnNGhM?=
 =?utf-8?B?VVJldXFpZHBGQyt0Rmdsc2dzWmFmeHE2NG5aRDUyblZOSGRDS2JUQml1Tmty?=
 =?utf-8?B?WVVSazgyZ2pRUFRsSXB0dEVrRlh5V3BlM0FCVnVpNk1EYWRrdzBYOUd1QXlL?=
 =?utf-8?B?VC8xTmtha1FsZis3ZTFsMkpPZS84dTRSSkhNTDBEVFFvZjU1bXNOeDhISkl5?=
 =?utf-8?B?Vng1R0ExQmxtSU5YTVZ5WXdFR1VkdWw5bnFrSXlOTWpXNlN2R1NNdmZGeVNk?=
 =?utf-8?B?bDVsaGFXNW52dEU4ZktXNngzV2FFVXpjVThyZ3hrVFNxQjI2bVVYbTZSY0Vz?=
 =?utf-8?B?TzZsYjE0dWNxb1JJdGwxc0RpUGdRQjhNTHVPbzF3MHROUS9UYy9pZlRNMXp3?=
 =?utf-8?B?YTF4dnpScHh0eGJxRHhzREVwNUE5ZHpkQ2x6akpYSThld1M2SXlHR05SKzFx?=
 =?utf-8?B?Mkdia2dwNTZDeTZLZ3lxVUY2ckFNL0Vha3BGMStSNTRiVnNOdUtDYnBDTnFm?=
 =?utf-8?B?SmhCNmlpZFA1UEdQbXQyOWJ2dVhBQ2trdnhOazljTkREcnFGUmpIT0NnUUlI?=
 =?utf-8?B?cDhud0F2MHpiNkJZWjg2MkxYTVNzUFBUZENXNWgwaml0c3lkVXBrVHJYOFpV?=
 =?utf-8?B?d3lkOGZXbG10NStKWXR6d1U4Q2c5Ui9LNzBZTjlsd0RJWWxRNHhRUUxLMHJC?=
 =?utf-8?B?UUR2eWE4S24xaFoyMXZFTnZZS29aWHREWnFRcTRFTTdLc1ZJZmdJUHZZZjlx?=
 =?utf-8?B?WHVvRHNaVVp1MUIwWTd0T0xOM1VUdHordEhaanNXSGhzcU5uZ3QweSt6NFM5?=
 =?utf-8?B?WS83SDFkNXVkZEw4ZkJTd2xTbDBEa2hlRThIc3lJRjVVbThFbFc4MFNDblpX?=
 =?utf-8?B?d05MUGk0R0l0eVBIQjFCK3loZmJZYlB3d0VRTW9ZSGo4cTkvbXk5MDVHd0Fz?=
 =?utf-8?B?YUpBam9Zd3dxM044MVZUb3VZQkxaYTdQNWdzdWJaK0lLYUw0Nm5iUVZrRW0x?=
 =?utf-8?Q?n5uQ1qrKyqMAh7UFaiRJ5QtANn01xwl6J4nNyO9BGs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5702ccbd-006f-49fe-7791-08d9df57288f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:32:48.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9/bz65hD+LyvHKjEEoqg9I/oZOs3ZH2lzmKBZS6InmXY/XwCbAzxCW8BYzo2cGLT8irNIHozYpmDtEJvSLUVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

You probably can add the STB dump we worked on a while ago to your info 
dump - a reminder
on the feature is here https://www.spinics.net/lists/amd-gfx/msg70751.html

Andrey

On 2022-01-21 15:34, Sharma, Shashank wrote:
> From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00 2001
> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Date: Fri, 21 Jan 2022 14:19:42 +0530
> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>
> This patch adds a GPU reset handler for Navi ASIC family, which
> typically dumps some of the registersand sends a trace event.
>
> V2: Accomodated call to work function to send uevent
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 01efda4398e5..ada35d4c5245 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>      }
>  }
>
> +static void amdgpu_reset_dumps(struct amdgpu_device *adev)
> +{
> +    int r = 0, i;
> +
> +    /* original raven doesn't have full asic reset */
> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
> +        return;
> +    for (i = 0; i < adev->num_ip_blocks; i++) {
> +        if (!adev->ip_blocks[i].status.valid)
> +            continue;
> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
> +            continue;
> +        r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
> +
> +        if (r)
> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
> + adev->ip_blocks[i].version->funcs->name, r);
> +    }
> +
> +    /* Schedule work to send uevent */
> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
> +        DRM_ERROR("failed to add GPU reset work\n");
> +
> +    dump_stack();
> +}
> +
>  static int nv_asic_reset(struct amdgpu_device *adev)
>  {
>      int ret = 0;
>
> +    amdgpu_reset_dumps(adev);
>      switch (nv_asic_reset_method(adev)) {
>      case AMD_RESET_METHOD_PCI:
>          dev_info(adev->dev, "PCI reset\n");
