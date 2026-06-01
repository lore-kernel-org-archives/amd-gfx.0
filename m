Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4ABCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 13:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A57B113368;
	Mon,  1 Jun 2026 13:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ymkafHlw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6039D113367
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 13:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCKLccZQixW4AXrJ6ILvU0crJe7WJ4xvoDUIIG3SnBLL6/uiZLalBUtNDL8jwEUq2S9OVTTrrfHTq0vbfp7uN+fHUWl6Ok1LgF9AEnW+1NgEA+SPQeD+Cz3eqAXTOLt4tkb3wWJCb+nd356MReacGClQcgMiXZ1UMviA5HTFxqukTV3bRmkaGn5dLBY94s0mPw4RhPZSyVQe/2eaX+GiFITDwaZxgbwMwuYKtxqD1yroZm1vddAeguaxgIY0w2G0MCwujR7BjBfWHL+OZY7GI26T+owvDqmdkFwJbausbOSfd1HjqChutY/6gbQ8/50NO2ZPV0iEqBPVNxW6Bvwkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaRWOCucWCy9xMT6vH368jSG8r4Ha4lBRzAa9gDiucE=;
 b=o1b66c9vGvwZEvf2Hr7eUGKKx0T+R3yOaTWND2U8e6cACwzrUKoHZgViykAtTyHvLS2xgR/fEOFsj50m5Bvs/z5Nj85MCRvGN2vkgNdiWAvUi7uFftV8sJhjhGnqSmiBEFZ4zCWN4G8VxB+gtbtdoK1SwhbWEl6/hFcZeD/8mP3H70hpgv22VTMTLxOuKZvxegXLlNkffgfKF2aR089x4SJ42u+9nWuMKNmobJ3NemrI9NqVjVhlHwje+lF0IQOpYTuyb4P0AYDxvPKcnoVta37HOSgss/Mn1mILY4ZmTKV97sSW2I+1Q06yUrvBdNejIqbmmlCVCzQUEtQxdzXAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaRWOCucWCy9xMT6vH368jSG8r4Ha4lBRzAa9gDiucE=;
 b=ymkafHlwo6OLMKKf6ZQQV4lMbQmBnlMpsu+bnQRoMSG+HlZi9q8AalzBuNvLlTp1GpNSUlyy+flpwg4PJisGTmqcIIIoLA7BDQy9Zaz6rnYYFMJFI+LkQEix4V7llje2sBJe9Fq1VHZupupV6jhIqxA2i3FZWGl7uxd0N9k+lxw=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:42:35 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:42:35 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
Thread-Topic: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
Thread-Index: AQHc74ODgiK2wpH6uki+rukYIp8+/bYpVHkggAAmnYCAADxzrg==
Date: Mon, 1 Jun 2026 13:42:35 +0000
Message-ID: <DM6PR12MB29729736F9A8FEFBFB2DCDBB82152@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260529155425.418803-1-asad.kamal@amd.com>
 <DM6PR12MB2972E0714BA89B7B178CDB2882152@DM6PR12MB2972.namprd12.prod.outlook.com>
 <e1adcfe9-9ea7-41d8-afee-eebdc5347d1f@amd.com>
In-Reply-To: <e1adcfe9-9ea7-41d8-afee-eebdc5347d1f@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-01T13:33:50.9563668Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|SN7PR12MB7129:EE_
x-ms-office365-filtering-correlation-id: b917efd1-b387-49c5-83ef-08debfe3a340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|11063799006|6133799003|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: kjExNws0V+VVKB+Vm7VYFIEgiG4qcOLgIhrultVJhy78/UnrsYVssO3UOh6qYpfGDEFuZseNpzPCaieHwlvZUj9nLPbZRYHxL904JH0AZoGHl36d8ohY8LAw+AyAIGRBkql5+49fNp7eI3WVlY3h9lbkRLIiID5Hx4RKN/sD5jkngTBvNxaq3OiHuTJ3osGzhb6yHlOGz3buzrxWqprstvO/L6CsqdV/s1cCPLmv1IRsIYf+X2mWi3qlypdsktCH3DTPr72f/EgQShQw2XFPODB5ZJcNbWt+qSwng9yBUom2h1y66vIPwfJSa0QKAU2ZkvH/tKSP/Haxfdy2SzUsmjnYsl52wkiarRRvhztIYDQ9t0JONYHJmlGDCHQqCV5aWFIXb0dc+SKkhx6OB82FBON1RiKdlqHekCC5PfpN/A33xJXmJG9nzKR/evz4No2tz7J+eGQWGmCj8p0RuNNv7KnB53DJCPMRm+cXak0Cg5MiuX3c7amIzP5C+RqtBRnTxLUFlsOmVxNP8yrq0zUtpXFo/LwJv2SOAXz9tZQDzDFoKHADI20ya1eF0vasxCYSew1bHPDhQGI47XhCKVJXrDZqywQ0KRWf7YfGlnmRnmJ1niQPru08o8Lx5rC3dMlPlFw6Va3xud3hx4U1GW7HpNEFY0BqngG9HdGrZVvvD2E3TJ0ruGQfPtTmL98IUriA1CLZJMnHcGNqjXcUJQrfJ/tOa7TBBdSKG9Ic7NVOvpW8LIxyjU6lxAwgqIx3+//y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gq7Yuxyi19dwGTsG1YgQp/3Khkvb38X/fOHu4dQBBcXs0orx6JrjQuYfaiLn?=
 =?us-ascii?Q?13A45cKQZHLIcS/QHIuPku7h+B0/gVYN2R9CiRYW7mmLhWzCKPd6SRCHJw15?=
 =?us-ascii?Q?M9/kR4NhFZneRrRI/QOLC6vq73d24xw/EITzZJxGvOEnRLCCUM/axFtnR/VF?=
 =?us-ascii?Q?UcvnFTnN4RvidNrLHTg9lFmpCaRg2Cnyqghs1uIWzHU8dEFjjHBwL6QpHP62?=
 =?us-ascii?Q?wcvAflMn7J3zlQnGsHv5prxivjyt0rsnvNtBHeQL56KH+6ZmB0lbAFnGf4A9?=
 =?us-ascii?Q?6e9nunEfC3j40YWDmtqsEVC+43MkHe6NBtNG/zRFoZ+PXeeuGOeM2NEVEr+b?=
 =?us-ascii?Q?NvwFvDRgQFsDN9V4IfLCU2z6k+4JaOz2YxhVk60I+h9QFDVLsmRqLCSASF33?=
 =?us-ascii?Q?TSa07jA2AUBBhYFPNQgLY4NabXo5rTu+cOEPAVJDSAPdSEYjMnXIjA6Dt7TO?=
 =?us-ascii?Q?2uXp8TsfaW3OJlAAIQyc4FBxTm53Jk9G877Opr+fQ54ms6uAqUm2oDyX0vwz?=
 =?us-ascii?Q?CRCftzyR583iuEWhis/rudi1XLM1TBw8xyR8rr8VowxWvWEWZb0I9jo4P7Av?=
 =?us-ascii?Q?eCnoUMWU2ep1ZrPcXIQzXt53X13/YYIGOktmyBqtvqjC9LOlsRF2yEzduV+c?=
 =?us-ascii?Q?/rlAjAlcYAHz0c/8Tp0ZCQOKP9OFlXUL4YKFVjyM3Rlfq7ZxdAa/pANblkgE?=
 =?us-ascii?Q?SEA+roxZjsod8LzxFdaY1m+FcwFkm/KCu61kmjUvOxp8wocnZnkkTj5jeJgS?=
 =?us-ascii?Q?4DQR7qty0NTWAaLzbr1ZFyduFxAtMVJZhEQqrPTe9DeWbGZ2E2ZDUaP6Rcsz?=
 =?us-ascii?Q?NPcqwylc8/MJ3012fGoZH5NshSZCAUwg+zxzkFiw8jQFvcYOsSau/hwArddd?=
 =?us-ascii?Q?AnKgF/wpOjogkMmcC6mpfVcZt/dIVGV7+ltEVLkKCNXM2ejYFFqoyP6zzpax?=
 =?us-ascii?Q?NGKJJH9pzXe8foZpUJF6F20ybmPxDsqOhu1gRj2aGDE4IHCmD+U5+r3UU8f8?=
 =?us-ascii?Q?9EjxfGxeNVArcHvt73/R1vTQvYAiLiNsFGTTOPGWFGYSivnExzA56YbnDjEz?=
 =?us-ascii?Q?wEFortvVWfyUXOGoWGRsgSwjjE11bNqA4dh38MJfAmji1IcnK0mH2npJl9ox?=
 =?us-ascii?Q?j5xLKrDpS1L1zeSzd3eP/fXpOsD/hKPRSgkCuJEzH3ECYVEYH/GSFXtK6hBT?=
 =?us-ascii?Q?FoCumi8fIAxoVmXMN89ODf4N9eAENBQLStSybZbr1BhCbeylq2UvNPjIMM54?=
 =?us-ascii?Q?Y4i9I8NYIN4gf2gE5q1Gnf9tQ+l9PHg0IFb9Edg4dcOvM/ozVKVY/DVw1tIh?=
 =?us-ascii?Q?aX7DFA5+L4M+zxCPe7EPabL+UCXXU0FRmczk5PAoocOmzAfqr2VcquFzLe85?=
 =?us-ascii?Q?ClsEtxdtZHcfQ8MhabPEVGelykXT9hfDCrHQSqIyyXk6MOLxOW0PYqLQwm2f?=
 =?us-ascii?Q?DMsVoABDvaYHnWE+I3Bjtm0h5WACpgIfzmKaggJRZXhsJqVXcs/Ily8NsqTB?=
 =?us-ascii?Q?e8ba2rPJBx5IVRmzW197UsofZX07/xD4AkxZeT8F0ob48qpzxF+Hc8p9Yeeg?=
 =?us-ascii?Q?Y4n2Cu/YbqLYsdF+KVk02G7VfbXDQYCGzHPoRDE5x6CLnm7V7gjzH6mTYY6a?=
 =?us-ascii?Q?IrTNExn3tH6U2ej4juXWM/ZE4i7tORQfQztKO1TdqWX4I72dDGPlcJ4gSDL8?=
 =?us-ascii?Q?qpfzvlJDdqnvTzPvcFb5XkKymzX+ROLd0aBjQSgcyW9ymJ3X6eyWrQJmz8ob?=
 =?us-ascii?Q?1LWC7b6PJA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB29729736F9A8FEFBFB2DCDBB82152DM6PR12MB2972namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b917efd1-b387-49c5-83ef-08debfe3a340
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 13:42:35.0377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4O/ENFLVsNPSaLFXmETnfanh1K34qyrlT0TuV3pW3jTUun91V8ustsrFH1yrOxKb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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

--_000_DM6PR12MB29729736F9A8FEFBFB2DCDBB82152DM6PR12MB2972namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

After per discussed , the patch is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, June 1, 2026 5:57 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad <Asad.Kamal@amd=
.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>
Subject: Re: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZ=
E



On 01-Jun-26 1:15 PM, Wang, Yang(Kevin) wrote:
> AMD General
>
> Hi Asad,
>
> Your patch doesn't seem to resolve the issue you're facing; I  think the =
correct logic should check the return value and the size variable
> What's your opinion?

I think stop printing if buffer is full seems sufficient.

The expectation is that size out param shouldn't be updated if the
function returns failure.

Thanks,
Lijo

>
> Here is the pseudocode:
> ret =3D amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &si=
ze);
> if (ret < 0) {
>      continue; // for next clock item.
> } else if (ret =3D=3D 0) {
>      // Check ret and size/PAGE_SIZE here to meet the requirements
> } else {
>   // go out to return.
> }
> Best Regards,
> Kevin
>
>> -----Original Message-----
>> From: Kamal, Asad <Asad.Kamal@amd.com>
>> Sent: Friday, May 29, 2026 11:54 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
>> <Shiwu.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>> Subject: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
>>
>> Stop appending OD sections in amdgpu_get_pp_od_clk_voltage() once the
>> sysfs page is full, instead of checking every
>> sysfs_emit_at() in SMU helpers
>>
>> v2: Drop the prior series that checked sysfs_emit_at() return values in =
every
>> SMU *_emit_clk_levels() helper and smu_cmn_print_*().
>> (Kevin)
>>
>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 60db9b66d08c..03c95621fe2c 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -866,11 +866,15 @@ static ssize_t
>> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>        if (ret)
>>                return ret;
>>
>> -     for (clk_index =3D 0 ; clk_index < ARRAY_SIZE(od_clocks) ; clk_ind=
ex++) {
>> +     for (clk_index =3D 0; clk_index < ARRAY_SIZE(od_clocks); clk_index=
++) {
>> +             if (size >=3D PAGE_SIZE)
>> +                     break;
>>                amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index],
>> buf, &size);
>>        }
>>
>> -     if (size =3D=3D 0)
>> +     if (size >=3D PAGE_SIZE)
>> +             size =3D PAGE_SIZE;
>> +     else if (size =3D=3D 0)
>>                size =3D sysfs_emit(buf, "\n");
>>
>>        amdgpu_pm_put_access(adev);
>> @@ -3915,12 +3919,17 @@ static int amdgpu_retrieve_od_settings(struct
>> amdgpu_device *adev,
>>        if (ret)
>>                return ret;
>>
>> +     if (size >=3D PAGE_SIZE)
>> +             goto out_pm_put;
>> +
>>        ret =3D amdgpu_dpm_emit_clock_levels(adev, od_type, buf, &size);
>>        if (ret) {
>>                size =3D ret;
>>                goto out_pm_put;
>>        }
>> -     if (size =3D=3D 0)
>> +     if (size >=3D PAGE_SIZE)
>> +             size =3D PAGE_SIZE;
>> +     else if (size =3D=3D 0)
>>                size =3D sysfs_emit(buf, "\n");
>>
>>   out_pm_put:
>> --
>> 2.46.0
>


--_000_DM6PR12MB29729736F9A8FEFBFB2DCDBB82152DM6PR12MB2972namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
After per discussed , the patch is&nbsp;</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Best Regards,</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Kevin</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<div id=3D"mail-editor-reference-message-container">
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif;"><b>From:</b>&nbsp;Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, June 1, 2026 5:57 PM<br>
<b>To:</b>&nbsp;Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Kamal, As=
ad &lt;Asad.Kamal@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@li=
sts.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Ma, Le &lt;Le=
.Ma@amd.com&gt;; Zhang, Morris &lt;Shiwu.Zhang@amd.com&gt;; Deucher, Alexan=
der &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit=
 at PAGE_SIZE</span>
<div style=3D"font-family: Calibri, sans-serif;">&nbsp;</div>
</div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div class=3D"PlainText" style=3D"font-size: 11pt;"><br>
<br>
On 01-Jun-26 1:15 PM, Wang, Yang(Kevin) wrote:<br>
&gt; AMD General<br>
&gt;<br>
&gt; Hi Asad,<br>
&gt;<br>
&gt; Your patch doesn't seem to resolve the issue you're facing; I&nbsp; th=
ink the correct logic should check the return value and the size variable<b=
r>
&gt; What's your opinion?<br>
<br>
I think stop printing if buffer is full seems sufficient.<br>
<br>
The expectation is that size out param shouldn't be updated if the<br>
function returns failure.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;<br>
&gt; Here is the pseudocode:<br>
&gt; ret =3D amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, =
&amp;size);<br>
&gt; if (ret &lt; 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue; // for next clock item.<br>
&gt; } else if (ret =3D=3D 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Check ret and size/PAGE_SIZE here to =
meet the requirements<br>
&gt; } else {<br>
&gt;&nbsp;&nbsp; // go out to return.<br>
&gt; }<br>
&gt; Best Regards,<br>
&gt; Kevin<br>
&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br>
&gt;&gt; Sent: Friday, May 29, 2026 11:54 PM<br>
&gt;&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt;&gt; Cc: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Zhang, Hawking<br>
&gt;&gt; &lt;Hawking.Zhang@amd.com&gt;; Ma, Le &lt;Le.Ma@amd.com&gt;; Zhang=
, Morris<br>
&gt;&gt; &lt;Shiwu.Zhang@amd.com&gt;; Deucher, Alexander<br>
&gt;&gt; &lt;Alexander.Deucher@amd.com&gt;; Wang, Yang(Kevin)<br>
&gt;&gt; &lt;KevinYang.Wang@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com=
&gt;<br>
&gt;&gt; Subject: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAG=
E_SIZE<br>
&gt;&gt;<br>
&gt;&gt; Stop appending OD sections in amdgpu_get_pp_od_clk_voltage() once =
the<br>
&gt;&gt; sysfs page is full, instead of checking every<br>
&gt;&gt; sysfs_emit_at() in SMU helpers<br>
&gt;&gt;<br>
&gt;&gt; v2: Drop the prior series that checked sysfs_emit_at() return valu=
es in every<br>
&gt;&gt; SMU *_emit_clk_levels() helper and smu_cmn_print_*().<br>
&gt;&gt; (Kevin)<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c | 15 ++++++++++++--=
-<br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 12 insertions(+), 3 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt;&gt; index 60db9b66d08c..03c95621fe2c 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt;&gt; @@ -866,11 +866,15 @@ static ssize_t<br>
&gt;&gt; amdgpu_get_pp_od_clk_voltage(struct device *dev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (clk_index =3D 0 ; clk_index &lt; AR=
RAY_SIZE(od_clocks) ; clk_index++) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (clk_index =3D 0; clk_index &lt; ARR=
AY_SIZE(od_clocks); clk_index++) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size &gt;=3D PAGE_SIZE)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_in=
dex],<br>
&gt;&gt; buf, &amp;size);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (size =3D=3D 0)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (size &gt;=3D PAGE_SIZE)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; size =3D PAGE_SIZE;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else if (size =3D=3D 0)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_pm_put_access(ade=
v);<br>
&gt;&gt; @@ -3915,12 +3919,17 @@ static int amdgpu_retrieve_od_settings(str=
uct<br>
&gt;&gt; amdgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (size &gt;=3D PAGE_SIZE)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto out_pm_put;<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_emit_=
clock_levels(adev, od_type, buf, &amp;size);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size =3D ret;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; goto out_pm_put;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (size =3D=3D 0)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (size &gt;=3D PAGE_SIZE)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; size =3D PAGE_SIZE;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else if (size =3D=3D 0)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; out_pm_put:<br>
&gt;&gt; --<br>
&gt;&gt; 2.46.0<br>
&gt;<br>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB29729736F9A8FEFBFB2DCDBB82152DM6PR12MB2972namp_--
