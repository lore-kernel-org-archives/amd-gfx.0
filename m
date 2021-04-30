Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F98FC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E03A613F2
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E03A613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C69A76F4B1;
	Fri, 30 Apr 2021 13:28:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBA06F4B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 13:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJH7+6sLSIIGtxLk45d4ziVqKruBGO61ff8WsbFpsRGtlVvnbk3KYwiOcO+i+gziZnpXOGsf6gpnc+cVR8tnSW28tfGAbQx/G6REPCbU1BgQmCDn9lTzFQ1/m/clBAoqzNFBM7P3VT4YWGF3Es2ITEX7q+cQPAMoJtfBvEdibNiq1zkWpWnicSDW2mLIDLE6CYKWqU3krQrqC9JJPcROheztNrtcADoDf/L+bbEbEemJtEROAE7tE47mD9raJ/UEGtZwsA9/wPuiPNWrBksj6QsfyTnA9FnLAMOfZTmWrCDGpkzoL/cGRaBLr2ui/UgD/N11Fo1Hm0NprUUksjqlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okhz1zwR5kmJSy2KMDsQOFYVwjnijfqdxLA6H9hjqHo=;
 b=iyGUhYxtPbpnnRLY/AvMo2XZoKU4USMQ+JSLw6vZkf1jZ90vwMsGhzDnBuoxZMSLwfh/1PhRaMP8505dnxQ4xMaWSguSsR6jZdoY0aPKjkSVnAuFMfElQRsUNeWgsXZsvAy6eP7xZg+6dKA+JjGOqCG/UyrkNfeTX1ou4amx5GqQmE/Vf2xixYa4dqfXmWGsSnBjaAVJ7hpl00djvN9EhgYj+jVI5am/Gt1qhfcoE88EH9fXmKN8b3/q6YGkPYBOkYNoJiIosq66oIVqsB1EQ1yYba16EdCe5I1kDDXeyp9JT2B7YomKkORkZ68slfrZcizRjSFFwnFf+90e3FoWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okhz1zwR5kmJSy2KMDsQOFYVwjnijfqdxLA6H9hjqHo=;
 b=Ghr3V/ZmPIQJgzQrUwBQ9DqakJAxQCGI4H13IuCcEnlTTPMh2fXyEAEvqC+uKDAqbfoVOcx/xQO37vNCpd7vA4qsGxZCSge3DhOdQVEHVbkqy1T384hcdbM0nnaWqaMvf3fSOIWunaEunWhFs3SNh5MSGE2Z/1kQb87qh0TZdss=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2471.namprd12.prod.outlook.com (2603:10b6:903:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 13:28:37 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.026; Fri, 30 Apr 2021
 13:28:37 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: remove excess function parameter
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
References: <20210430114324.14959-1-nirmoy.das@amd.com>
 <20210430125221.3lo5lvioo7nbrlk4@outlook.office365.com>
 <d0cc8e0a-18fa-8218-0ff0-65d69b7eb76b@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <bdf11c0f-9b1c-d738-f572-8ccb28e45f16@amd.com>
Date: Fri, 30 Apr 2021 15:28:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <d0cc8e0a-18fa-8218-0ff0-65d69b7eb76b@gmail.com>
Content-Language: en-US
X-Originating-IP: [217.86.127.183]
X-ClientProxiedBy: PR0P264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::20)
 To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.127.183) by
 PR0P264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 13:28:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4c5f1f8-3d75-48c3-508a-08d90bdbdc3a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2471FAF5DA737CD3E5D98BB78B5E9@CY4PR1201MB2471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4F9lt3rQp6ciedFFEIilRNy4NgLnHTghm2mrqANgBCkwNWhVcKhYLy6Q3nvdYmMBU7vOPVAE8JubPSm0GlvgapZRbLtjjzUfX0gH5PxPULk359viNWQopfNHP2INxRLy5uGv6jpUzCbqIcgNn6+ZSvx2lHuUsKK0qWVpK7F2eR3ZuJXnri8L0mKfKtjf/Ofb8rQ15GxtBZ+THG9JgP+x6AgEU1ILqr+2pFmznBZjXbM4w4/dc0H5Wp8Pf2w38unndO1fIllI3TtuRbbHgmkKiirmg7T4EtNBBQt9OcY+lBTLFTqgu0LGMf19E1WkZws/1xBQ2Ni5K8iu81N2D7lGCGFd7Ar6nxb2pHl8wxcaJz0fn3bnKDiUOTeqIBUwwXgvtKz6+IQ8z9C1e5yjzzhTKjKzSmQ10T64Hg9QdR0rwEFQg8/aP+kd6XLSoyf2ItrQz2SOLwQuDGL1tCtFyiG2N/UUV5MYXHdoS9qvLY21NS0P2p1RHKNdZj7btcR8hTKhsarjE00Plpy/H295fJKW5wNDI/5E3XO/8qI+Ai2Xrh7U071XiPBa4qKeeJIt+j1sA4rh87aV1HppJj8tEM5tDoN3utf/ky4jIcAC11pNcoHLz9yTIyrVQoDRFRsTTBKRi6Lv0XaMW3jBF/syZJ/9VvXW/it298Gxcu77KCBVwq3VpUdrdZYFtTZPfvX1nokTUNfc4DT0Z1kFBmTETtAxgDDU9eNfF0MJCfljCrERCEDgTEG7FmUrE8tWdV9wVj1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(36756003)(38100700002)(16576012)(6666004)(8936002)(66574015)(966005)(166002)(316002)(45080400002)(83380400001)(6636002)(956004)(53546011)(31696002)(66946007)(4326008)(110136005)(31686004)(26005)(38350700002)(5660300002)(6486002)(16526019)(478600001)(2616005)(52116002)(66556008)(186003)(8676002)(66476007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?sNcjLA8fE24OZ2/uYgLhbb8eA/WNxsWBwqECAv3CRPxr0EY6TPHGZA7T?=
 =?Windows-1252?Q?8Dqut4H7FsCQrKC0+nZ7SV2zZpgLGFUkaEes6YFeS2rhbLrxfrZMhoj7?=
 =?Windows-1252?Q?SlLP1OlDdavgpLjVuouGuB2E9H3SFS+Aibu6fHqVzV27YP2498w6NeR5?=
 =?Windows-1252?Q?sgPMHipKHilfqHl2ghS4mcBSbS5NpuZOO4W/ISZwSXu8q9kwTCBmAAs4?=
 =?Windows-1252?Q?6En2havNaGtUCDg+Y4LR0XbHIdmMHJS3GWwwLeROLuTjtmER2G43665f?=
 =?Windows-1252?Q?v7ryYGofeL7gOu82o29Ak11nH2VKmoQvDh3zI6LtOnOMFqpFkRsFyU/E?=
 =?Windows-1252?Q?8lUo3fzIEcBw9HF5VE2+AUshB1EGEJmaMSukhXLjh3LOIHG2hSrRhqDZ?=
 =?Windows-1252?Q?76gT7rPhyVa56UysuvsNphYGm3x36uZq8INz6xiIX5n/crc/eJ8zmzvX?=
 =?Windows-1252?Q?jjGYhN9T2PvPSHJ0SHhMJ6zwdAAvHcOXN8nBonEraJzvhiiPpL8jDB6u?=
 =?Windows-1252?Q?zJzHAaMd2aiXH5Wj7qN/9wXjVA+ewIyEqQg+O9DGIrwbuiuOFdzcjtfe?=
 =?Windows-1252?Q?R5TgY+5q94ul2oNhPPTPxyydeMU5K9SpHAj+dGPyMI4Z6Tv4r9h8QVaI?=
 =?Windows-1252?Q?wHKWQmDseAMrRUedpIuwUTm+foRwvS4CxOOCCZzI2L4cYakC2hjs9h2g?=
 =?Windows-1252?Q?FwpZofRknRXD9vj59jDBb4FNbtf2+Lxu/rrBhmtFiZkMoqcXRZXVfMJB?=
 =?Windows-1252?Q?HuVGI3tg4LDDEoyo5RnxUF6RTOF2+doKRXBukR2BG5wPEaYwSArx4nrO?=
 =?Windows-1252?Q?ssfpS01PoIsIpgGYYbY3pEjBGoqTH8seGQ2eox6rwbyw83O9wHZ6uUZ2?=
 =?Windows-1252?Q?GUcRHh3r3P1xAqK1pHdIAc6zUg9QuEwPhffzw88+6bpT6pgTxx65JTpy?=
 =?Windows-1252?Q?puynoR8FDUJHfxLa9ufwBIUDvWMcSnZEVrIsRRJdxeI1LfYYEnee3wtP?=
 =?Windows-1252?Q?JP7OZb+QEjgocnok99yyUKkFdj0FRazoq4aAs06hbSyCmwXdeDyiMq+c?=
 =?Windows-1252?Q?JhRT+IOeziK1kteRXcIDvXE/hyv9+pbGJF5DKYJrBXIS7F+iXt0GktnX?=
 =?Windows-1252?Q?gGICNy+vuaDOtuNVt+rfmkeZQGjw4EsldT/stwZ79AcvfcM+Wa2641yw?=
 =?Windows-1252?Q?7fzuxkReYQg7zVozxtj/rfOEJIhmyavskV9FwlN0RvuudlIQiwrSVGXy?=
 =?Windows-1252?Q?lvpbC7CBWC/dA+ZD/s02dT4tBYKyzKyuzmqQdVw5jwDUUZ6xZm8c32kk?=
 =?Windows-1252?Q?qZw84GW3u520ae20NDHTsL4xQarPXxyZxZno22dGLLtKbXaQD/ikap9a?=
 =?Windows-1252?Q?hteW2MUk7liUUsxueH6kvx8JNDQ+5udt5gNpdThCGQOEX8ZMqjfb1/oP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c5f1f8-3d75-48c3-508a-08d90bdbdc3a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 13:28:37.2657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr+DUSdayFSRjbZlcWd1oTC+C+a5nR3CgjZbXqjsjS+Qyn9gjUcQnrOullsXD+I6nO2A7/IMYfJrxpO5CRNLJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2471
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
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1135453859=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1135453859==
Content-Type: multipart/alternative;
 boundary="------------25DE35BF477A2EBC1E80D449"
Content-Language: en-US

--------------25DE35BF477A2EBC1E80D449
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit


On 4/30/21 2:56 PM, Christian König wrote:
> Hi,
>
> Am 30.04.21 um 14:52 schrieb Rodrigo Siqueira:
>> Hi,
>>
>> On 04/30, Nirmoy Das wrote:
>>> Fixes: 49020fc1f5("drm/amdgpu: cleanup amdgpu_vm_init()")
>> Just for curiosity, do we need the Fixes tag for this?
>
> It's indeed a bit overkill.
>
> The purpose of the Fixes tag is to mark bug fixes for specific patches 
> so that backporters of feature know that when they picked up patch A 
> they also need to pick up the fixes for patch A.
>
> But since this is just cleaning up a recently added warning in a code 
> documentation we could just push it without.


Thanks Rodrigo and Christian, I will resend again without Fixes tag.


Nirmoy


>
> Christian.
>
>> How about adding the warning/error message that this patch fixes? I
>> think this can be useful for other people searching for a similar fix in
>> the git log (I do it sometimes).
>>
>> Thanks
>> Siqueira
>>   
>>> Signed-off-by: Nirmoy Das<nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index dae51992c607..f2513be72980 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2796,7 +2796,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>>>    *
>>>    * @adev: amdgpu_device pointer
>>>    * @vm: requested vm
>>> - * @vm_context: Indicates if it GFX or Compute context
>>>    * @pasid: Process address space identifier
>>>    *
>>>    * Init @vm fields.
>>> -- 
>>> 2.30.2
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7Ca88acdf110bc4994ff3c08d90bcd36f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637553798286590199%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tS6NA4FPNYFPCbIdngKshN3I%2BwRwAumgC0vdA50h9l8%3D&amp;reserved=0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--------------25DE35BF477A2EBC1E80D449
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+DQo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD1XaW5kb3dzLTEyNTIiPgogIDwvaGVhZD4KICA8Ym9keT4KICAgIDxw
Pjxicj4KICAgIDwvcD4KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gNC8zMC8y
MSAyOjU2IFBNLCBDaHJpc3RpYW4gS/ZuaWcKICAgICAgd3JvdGU6PGJyPgogICAgPC9kaXY+CiAg
ICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjaXRlPSJtaWQ6ZDBjYzhlMGEtMThmYS04MjE4LTBm
ZjAtNjVkNjliN2ViNzZiQGdtYWlsLmNvbSI+CiAgICAgIAogICAgICBIaSw8YnI+CiAgICAgIDxi
cj4KICAgICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5BbSAzMC4wNC4yMSB1bSAxNDo1
MiBzY2hyaWViIFJvZHJpZ28KICAgICAgICBTaXF1ZWlyYTo8YnI+CiAgICAgIDwvZGl2PgogICAg
ICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjaXRlPSJtaWQ6MjAyMTA0MzAxMjUyMjEuM2xvNWx2
aW9vN25icmxrNEBvdXRsb29rLm9mZmljZTM2NS5jb20iPgogICAgICAgIDxwcmUgY2xhc3M9Im1v
ei1xdW90ZS1wcmUiIHdyYXA9IiI+SGksCgpPbiAwNC8zMCwgTmlybW95IERhcyB3cm90ZToKPC9w
cmU+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICA8cHJlIGNsYXNz
PSJtb3otcXVvdGUtcHJlIiB3cmFwPSIiPkZpeGVzOiA0OTAyMGZjMWY1KCZxdW90O2RybS9hbWRn
cHU6IGNsZWFudXAgYW1kZ3B1X3ZtX2luaXQoKSZxdW90OykKPC9wcmU+CiAgICAgICAgPC9ibG9j
a3F1b3RlPgogICAgICAgIDxwcmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdyYXA9IiI+SnVzdCBm
b3IgY3VyaW9zaXR5LCBkbyB3ZSBuZWVkIHRoZSBGaXhlcyB0YWcgZm9yIHRoaXM/PC9wcmU+CiAg
ICAgIDwvYmxvY2txdW90ZT4KICAgICAgPGJyPgogICAgICBJdCdzIGluZGVlZCBhIGJpdCBvdmVy
a2lsbC48YnI+CiAgICAgIDxicj4KICAgICAgVGhlIHB1cnBvc2Ugb2YgdGhlIEZpeGVzIHRhZyBp
cyB0byBtYXJrIGJ1ZyBmaXhlcyBmb3Igc3BlY2lmaWMKICAgICAgcGF0Y2hlcyBzbyB0aGF0IGJh
Y2twb3J0ZXJzIG9mIGZlYXR1cmUga25vdyB0aGF0IHdoZW4gdGhleSBwaWNrZWQKICAgICAgdXAg
cGF0Y2ggQSB0aGV5IGFsc28gbmVlZCB0byBwaWNrIHVwIHRoZSBmaXhlcyBmb3IgcGF0Y2ggQS48
YnI+CiAgICAgIDxicj4KICAgICAgQnV0IHNpbmNlIHRoaXMgaXMganVzdCBjbGVhbmluZyB1cCBh
IHJlY2VudGx5IGFkZGVkIHdhcm5pbmcgaW4gYQogICAgICBjb2RlIGRvY3VtZW50YXRpb24gd2Ug
Y291bGQganVzdCBwdXNoIGl0IHdpdGhvdXQuPGJyPgogICAgPC9ibG9ja3F1b3RlPgogICAgPHA+
PGJyPgogICAgPC9wPgogICAgPHA+VGhhbmtzIFJvZHJpZ28gYW5kIENocmlzdGlhbiwgSSB3aWxs
IHJlc2VuZCBhZ2FpbiB3aXRob3V0IEZpeGVzCiAgICAgIHRhZy48L3A+CiAgICA8cD48YnI+CiAg
ICA8L3A+CiAgICA8cD5OaXJtb3k8YnI+CiAgICA8L3A+CiAgICA8cD48YnI+CiAgICA8L3A+CiAg
ICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjaXRlPSJtaWQ6ZDBjYzhlMGEtMThmYS04MjE4LTBm
ZjAtNjVkNjliN2ViNzZiQGdtYWlsLmNvbSI+IDxicj4KICAgICAgQ2hyaXN0aWFuLjxicj4KICAg
ICAgPGJyPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjaXRlPSJtaWQ6MjAyMTA0MzAx
MjUyMjEuM2xvNWx2aW9vN25icmxrNEBvdXRsb29rLm9mZmljZTM2NS5jb20iPgogICAgICAgIDxw
cmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdyYXA9IiI+SG93IGFib3V0IGFkZGluZyB0aGUgd2Fy
bmluZy9lcnJvciBtZXNzYWdlIHRoYXQgdGhpcyBwYXRjaCBmaXhlcz8gSQp0aGluayB0aGlzIGNh
biBiZSB1c2VmdWwgZm9yIG90aGVyIHBlb3BsZSBzZWFyY2hpbmcgZm9yIGEgc2ltaWxhciBmaXgg
aW4KdGhlIGdpdCBsb2cgKEkgZG8gaXQgc29tZXRpbWVzKS4KClRoYW5rcwpTaXF1ZWlyYQogCjwv
cHJlPgogICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgPHByZSBjbGFz
cz0ibW96LXF1b3RlLXByZSIgd3JhcD0iIj5TaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxhIGNs
YXNzPSJtb3otdHh0LWxpbmstcmZjMjM5NkUiIGhyZWY9Im1haWx0bzpuaXJtb3kuZGFzQGFtZC5j
b20iIG1vei1kby1ub3Qtc2VuZD0idHJ1ZSI+Jmx0O25pcm1veS5kYXNAYW1kLmNvbSZndDs8L2E+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxIC0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwppbmRleCBkYWU1MTk5MmM2MDcuLmYyNTEzYmU3Mjk4MCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTI3OTYsNyArMjc5Niw2IEBAIGxvbmcgYW1kZ3B1X3Zt
X3dhaXRfaWRsZShzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwgbG9uZyB0aW1lb3V0KQogICoKICAqIEBh
ZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKICAqIEB2bTogcmVxdWVzdGVkIHZtCi0gKiBAdm1f
Y29udGV4dDogSW5kaWNhdGVzIGlmIGl0IEdGWCBvciBDb21wdXRlIGNvbnRleHQKICAqIEBwYXNp
ZDogUHJvY2VzcyBhZGRyZXNzIHNwYWNlIGlkZW50aWZpZXIKICAqCiAgKiBJbml0IEB2bSBmaWVs
ZHMuCi0tIAoyLjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CjxhIGNsYXNzPSJtb3otdHh0LWxpbmstYWJicmV2
aWF0ZWQiIGhyZWY9Im1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyIgbW96LWRv
LW5vdC1zZW5kPSJ0cnVlIj5hbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzwvYT4KPGEgY2xh
c3M9Im1vei10eHQtbGluay1mcmVldGV4dCIgaHJlZj0iaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0
b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdD
bmlybW95LmRhcyU0MGFtZC5jb20lN0MxMTE1YmM4OGYyZTE0NmZkMzFiMTA4ZDkwYmQ3NjhhZCU3
QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1NTM4NDIwNzEw
ODE3MDElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpv
aVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9
TyUyQnFTUkRzMWU1ZUdBN051QlpqR0lqdjV5Skw1NG1NJTJCd01kNVozMkdhYW8lM0QmYW1wO3Jl
c2VydmVkPTAiIG9yaWdpbmFsc3JjPSJodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngiIHNoYXNoPSJWRVh0VjJoSGswQXZCa1RvOTBBcWdQNjhaZTRG
OVhuUHVaSmJQdHQxemJVdWpXc1crOFlnejVuREllWVFuNVdzaGJORkJ2N0hjMGRJN0ZQdG1sOUFT
dWdmNHh3MHdsWkRKSzVaaGJ5Z0JOeTZTeGpCSWowUS9zQ2R2MjhKcnhmd3FhV0YvWk4wb2dmSTRs
NytyaDZLaE5jL1BRVlBQSlE0aUVWODlXWkF6NEk9IiBtb3otZG8tbm90LXNlbmQ9InRydWUiPmh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1n
ZngmYW1wO2FtcDtkYXRhPTA0JTdDMDElN0NSb2RyaWdvLlNpcXVlaXJhJTQwYW1kLmNvbSU3Q2E4
OGFjZGYxMTBiYzQ5OTRmZjNjMDhkOTBiY2QzNmY2JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzU1Mzc5ODI4NjU5MDE5OSU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDthbXA7c2RhdGE9dFM2TkE0RlBOWUZQQ2JJZG5nS3No
TjNJJTJCd1J3QXVtZ0MwdmRBNTBoOWw4JTNEJmFtcDthbXA7cmVzZXJ2ZWQ9MDwvYT4KPC9wcmU+
CiAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgIDxicj4KICAgICAgICA8ZmllbGRzZXQgY2xh
c3M9Im1pbWVBdHRhY2htZW50SGVhZGVyIj48L2ZpZWxkc2V0PgogICAgICAgIDxwcmUgY2xhc3M9
Im1vei1xdW90ZS1wcmUiIHdyYXA9IiI+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKPGEgY2xhc3M9Im1vei10eHQtbGlu
ay1hYmJyZXZpYXRlZCIgaHJlZj0ibWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
IiBtb3otZG8tbm90LXNlbmQ9InRydWUiPmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPC9h
Pgo8YSBjbGFzcz0ibW96LXR4dC1saW5rLWZyZWV0ZXh0IiBocmVmPSJodHRwczovL25hbTExLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5m
cmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0
JTdDMDElN0NuaXJtb3kuZGFzJTQwYW1kLmNvbSU3QzExMTViYzg4ZjJlMTQ2ZmQzMWIxMDhkOTBi
ZDc2OGFkJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzU1
Mzg0MjA3MTA4MTcwMSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURB
aUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFt
cDtzZGF0YT1PJTJCcVNSRHMxZTVlR0E3TnVCWmpHSWp2NXlKTDU0bU0lMkJ3TWQ1WjMyR2FhbyUz
RCZhbXA7cmVzZXJ2ZWQ9MCIgb3JpZ2luYWxzcmM9Imh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeCIgc2hhc2g9IlZFWHRWMmhIazBBdkJrVG85MEFx
Z1A2OFplNEY5WG5QdVpKYlB0dDF6YlV1aldzVys4WWd6NW5ESWVZUW41V3NoYk5GQnY3SGMwZEk3
RlB0bWw5QVN1Z2Y0eHcwd2xaREpLNVpoYnlnQk55NlN4akJJajBRL3NDZHYyOEpyeGZ3cWFXRi9a
TjBvZ2ZJNGw3K3JoNktoTmMvUFFWUFBKUTRpRVY4OVdaQXo0ST0iIG1vei1kby1ub3Qtc2VuZD0i
dHJ1ZSI+aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4PC9hPgo8L3ByZT4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8YnI+CiAgICA8L2Jsb2Nr
cXVvdGU+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--------------25DE35BF477A2EBC1E80D449--

--===============1135453859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1135453859==--
