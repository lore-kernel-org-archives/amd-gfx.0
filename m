Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE9C761A6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 14:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BB010E49E;
	Mon,  3 Apr 2023 14:15:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B1510E49E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 14:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmenxE7e5qzTL3HAGjPe/YgFyCwC0QtWwgIZs6Tz2C6WBSur6TElGCzISq2M60nqvSPBqRw7K1ENNyvmLaqIu9VYQx2+2LYd/ibVJoV5AVCXbLDo1rybzO+sk33ezsEdAVmDFsj4+2L+LFWpWivXLxDuZokmAj75wcIRsUUsD84so152gOa1NaY8QUaIiBCYJ/69yixirTXAwsU/UIYIeOJoNDbKL14i/S93SWDJK28PmnDz5+eMopnkojj8MQzk69Hm9zJr386jVCalMWfLQTi64kx8hGG1PAjCJuaYCfeZhMkmzQsI9isA4fgkXYduXr4AUhX/wNemy/EwY6Qnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmB3z3m4sZURBmaxAghsSubyMLXp+5RtSFVO1dW2Mpc=;
 b=TuBO1IdpJ4LMtIUsUhAfhLatptFt2khIVUO4FPnT8sqXdPbLJ3vAsy1/bnGPTti0H3EjCODqDC2fO7W8fsyjYGkJXueNINi+On8WQcO35R2ZMczwta6K4FZwNhirNWlmycO8sdVvV59aeWVGw1DbVHvW7z9XURY9wPPD6aErwnE7+IyPXiTiXd1QjDbZl+hFC2pM+NlimU+BOurIHNZjI1F0zpYCuA1K2GO+MGIM7bVSQqnX5lbsFLaG8EMe0x9t80zHUh4ovj4HglPSGf/Gu5SdAWFD7pzPViSAVeUyCVCjfGgqtmgH8ZMUus5g9CwfWvT7tAQ5zjRI7WIBHzMWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmB3z3m4sZURBmaxAghsSubyMLXp+5RtSFVO1dW2Mpc=;
 b=eOPiEZ3JBEwSnJs8TplpEU3USIGRTz6k+qThRz1Uz/3QStLsdi96uXCHcTVJFQeNoxy9BeUpSCAlMxAIvUq1x8DkAbkUf3DyTAKOF5+XhdO2pWcreifc/lbS4VZ7rTtTOkMZi9dfPZw7lH/UGVfzyreMglayDsbjQM237KRsW3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 14:15:21 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 14:15:21 +0000
Message-ID: <58d31076-0bef-8e8d-d0a1-03a2a4394ed1@amd.com>
Date: Mon, 3 Apr 2023 10:15:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230328001119.1363691-1-alexander.deucher@amd.com>
 <cf5a5181-4c3c-10ff-1dff-36a34658cea7@amd.com>
 <CADnq5_P0VdXL=SC_2MWGHHOL+KZfrbkrvS=ko9sDnHbgocAhmg@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: simplify amdgpu_ras_eeprom.c
In-Reply-To: <CADnq5_P0VdXL=SC_2MWGHHOL+KZfrbkrvS=ko9sDnHbgocAhmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0284.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::12) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4501:EE_
X-MS-Office365-Filtering-Correlation-Id: cebb0c45-1b02-49c2-0a61-08db344ddbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sahMlVvPEDMk389797i/jNknt6C8iFeoUurW5XjQlgDZi067MONlXxfstzr5yanWsUXOLk73m1a3T0e3WkysyroQ85BJsXxdp2uKo1mOBkL2eVM9ZUsBTFkRT+xlfOYYL9OFPpax/wbmoVuewuEE8ib6aRxUtNJ/P1yVvEobR7kJQByZxn9b1yopt+JgnWr5u7taTonIBA9L/+3nekEHgF5xb5ccUr7ntLGjLlzZvFjVPQC/B7+3yT5Zs+nrNeh5mxRnfs7+rxGezK/FXc+XYsc2d+HdPW+h8xyEAPZ6iN8mVTtPmhRw4T/UeB460IB3Kd7v70VffpJI1hcjwI+VIZEu2CKKKQCjwiLOMNJzV/uVtE5EK0r4FuqZBd8wNIb+5+cvTYlD52eppXEah/Z+dFGWNs6Jhal5ASMdizbCJ06gPASVYb+cn5r6z/+fbw6mVsFGWSYC+9DMJ+ykMSQWKO+AFH6VFGD3p2e9mCscRD0Hw9SfjRoJ5Pt4D0hNW+tyjDShuP+V+0GxRaLtWV8Y0qcre/arTzm9esgI0VoAJaWko84di6y3XGKl9pMNyHsOv2GtDuc3upbQrPgpDSR9KfGHduQnhXBjZoGsd+qAI3DZMSFnl9UAjuY7OWsou2a/iwrRZIXeJlXLbOxhyOMj3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199021)(53546011)(6666004)(186003)(26005)(55236004)(83380400001)(6916009)(6506007)(2616005)(478600001)(41300700001)(8676002)(66946007)(66556008)(4326008)(316002)(6486002)(66476007)(38100700002)(36756003)(2906002)(31696002)(86362001)(8936002)(5660300002)(44832011)(6512007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RitpRk9xUWhaOVVNZkI3alBnNFNJRTNXSzVZSXVmQk1wM09ZTGpIS0lTRkU0?=
 =?utf-8?B?QjJIZ1BWSkhZQVBVNUlrajdsY0FQOHYxcVpabVRjZXFSOE5XME0yaDMzM3Ni?=
 =?utf-8?B?Vlo2M2hpNllMdXpTZHRRZzlKVWdhNlhZL1RHT2JXVjIxZkVhZ2s1Q3JtMkRV?=
 =?utf-8?B?bHhieEdBaWRsQ2xhdUxuUDBubVRoelRvN2FoOS9vN2xSOHNTcGtzbEhvdWdk?=
 =?utf-8?B?OEZjRFFHN0pFTkMyK1FBelpVL0t2a05Wak4xSm50cllxZDIraER6M2RiKzMr?=
 =?utf-8?B?SERNUmh2RlRSWGNYS0lEWGlVa2RRWWtVZFlwWXRPRmhVeDczcjlJa3hDajlo?=
 =?utf-8?B?TEZ3Q1kxbVQrUnlaNkR1UGJOV09nOXhzUVhJUTkwN1IxYU9pT3hqWndwbXRY?=
 =?utf-8?B?cEI1S2JtOFdNNXBScVFmRE9oWlE5NEdzVGl2elJLMDZsZ3VNQlJtcnp4Y3l0?=
 =?utf-8?B?VXRHd2hxWEpjSU1BSHBoVWN5cFZjZjhPUTI2MGpYNXl4OFpUcG1rTDhGU1Fy?=
 =?utf-8?B?TVg2cWtxZGNBdk81UytFbWE0cHM3SWUwc3g0MVFUQ3VmN0dNa0RTWWZzWTR2?=
 =?utf-8?B?UC9iaVpDM243enR1RDFoaUhwTkNvYmk0RUR1MFJGVXdIWlY5MHpHWlErMGlP?=
 =?utf-8?B?cnJSbUdiSjQ5UklxRXVGa0VITE5KSGJ5bFpBcDVVaDNNeW03SDIxWnprQlVV?=
 =?utf-8?B?enJmNi80L080ZWI2UDlBK3dxZ0VSb2JyRXVEVVpKeC96dFpTWENmTXhkY1Ez?=
 =?utf-8?B?UGU3ZWxjVzdKQ0kzTDdDSlZIYVJ3bjc4MWdmQ0g3ZkpBcFFNRm9FSmZZc01l?=
 =?utf-8?B?R0FhWHZZaC9sY0NJNFpUMVBXOEM3cG5LdHozMUlHWmZjajlCdTNoYlVLT3RY?=
 =?utf-8?B?dytNbVlMaTgxa2JYQS83a0xLVVBVaDJzaC9ZektxcmMrV3Y5enJDRjlaUkow?=
 =?utf-8?B?cVR4bjV6VmMwajIwazE2UjB6NThzZjhmQjhrRGtzMWlFWHNvVHZGd0pWODZS?=
 =?utf-8?B?MUhQQUpkemZoNThYTDlNeHU1QU1xMm1Ta3pkRXZGWmViNEthMzJGVmVQZXVG?=
 =?utf-8?B?K2IzN3liNUF3ckpGZ0dERUpJSlhiNTNPUWEwSGQ4OS9yZWU2ZC96MkpGRjFM?=
 =?utf-8?B?VDdYanFJWXUvZk4yRDUyTlBnNUJ3bU01cS9tdVoxVlE4cS8wQXBxZUlxRm9v?=
 =?utf-8?B?cDRzY2U0UmZML2pSZ2lFZU0xbjZHd01DUGxicUZEWEx1dDdzYkhMQ0c2MGlX?=
 =?utf-8?B?eTFwWlQzOU5VbE80K0FoVWREMHFrc0JaSDlmT2hQbm1aMmNYbGFNRHRrM2ta?=
 =?utf-8?B?SDJ5TGVZRDdEb0NPb1FUREpPM2lqME9qQXgvdUszMWNWamcrL3FPYTUxZlc2?=
 =?utf-8?B?UFBkTDdhUFdHVXBRTjAyQ3ErSURMOUFmTWFoWi9NOWxmdVVmcHVqajBCUW5I?=
 =?utf-8?B?QjFDQk50UU0rbTJKYTQ0NENNNnBrQWptRm51bldiR0llSmUreGJOakpHelFV?=
 =?utf-8?B?Qy9Ld3hlcU8zSXZOM1psZUdJU1JwajNyWFlNZjl3QVljai8ybmtYRnp6dXQv?=
 =?utf-8?B?Y3RRVHA2QUF4Wm9vWWoxMWVXbEUvd1NVM0FqSGFvQXY2QzJnTU1rNmVmYUYx?=
 =?utf-8?B?dnBwNVMwa2ppYjRRVDdVZHVDbnhoa1YyemRFU05qb3NRMkJRSEFIZGxVaVg3?=
 =?utf-8?B?WjRHQlA4U1g0czFvbEZqZHRlVTY5YWx6Vjh2UGlkNkRWQ2tmQXorVGFnSjAx?=
 =?utf-8?B?QVhIdmZmWFdUdnhXMy9mdDVmWi9FN0U2TjkzSlVSYVF3UmtYK3ppc01nNTla?=
 =?utf-8?B?K2ErcXZpWjlBNC9QMnNEWVdkVytuWXkyQXpRZ2xUWEs5clcrQytNZG1hQXlS?=
 =?utf-8?B?TC9XZ0xMeStsK3JhSElvdlc0N2RWUlE5ZXFUY2pXQm9aaU5RekwvY2NsbHRL?=
 =?utf-8?B?dGxReHRwRXkwb2lxdXdoUCthTC96bncxWTFRZmg3MFg4eE80M21CZlpEWEta?=
 =?utf-8?B?UHF4TTB1SVE4bjBkTWRnalYxLzJJYm5nNHdBdUo3TVlRMXZ6cXBHbFgwMHhv?=
 =?utf-8?B?MUd0QlhybHZ1MS9ZblcwZFkrTmdHTldIY1VTSkgwOXpsWjZRMVV1cEpHU3g2?=
 =?utf-8?Q?5aOyFHu7k32VyvqliPNKMluWb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebb0c45-1b02-49c2-0a61-08db344ddbe6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:15:21.1277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb+BnY5Cw3j0ermWdtHTcDBbm/4khH5xePHKIq9/DlcH99oZtilflG5I5mglxxJ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-31 15:30, Alex Deucher wrote:
> On Tue, Mar 28, 2023 at 12:30 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> On 2023-03-27 20:11, Alex Deucher wrote:
>>> All chips that support RAS also support IP discovery, so
>>> use the IP versions rather than a mix of IP versions and
>>> asic types.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 72 ++++++-------------
>>>  1 file changed, 20 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> index 3106fa8a15ef..c2ef2b1456bc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> @@ -106,48 +106,13 @@
>>>  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
>>>
>>>  static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
>>> -{
>>> -     if (adev->asic_type == CHIP_IP_DISCOVERY) {
>>> -             switch (adev->ip_versions[MP1_HWIP][0]) {
>>> -             case IP_VERSION(13, 0, 0):
>>> -             case IP_VERSION(13, 0, 10):
>>> -                     return true;
>>> -             default:
>>> -                     return false;
>>> -             }
>>> -     }
>>> -
>>> -     return  adev->asic_type == CHIP_VEGA20 ||
>>> -             adev->asic_type == CHIP_ARCTURUS ||
>>> -             adev->asic_type == CHIP_SIENNA_CICHLID ||
>>> -             adev->asic_type == CHIP_ALDEBARAN;
>>> -}
>>> -
>>> -static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
>>> -                                    struct amdgpu_ras_eeprom_control *control)
>>> -{
>>> -     struct atom_context *atom_ctx = adev->mode_info.atom_context;
>>> -
>>> -     if (!control || !atom_ctx)
>>> -             return false;
>>> -
>>> -     if (strnstr(atom_ctx->vbios_version,
>>> -                 "D342",
>>> -                 sizeof(atom_ctx->vbios_version)))
>>> -             control->i2c_address = EEPROM_I2C_MADDR_0;
>>> -     else
>>> -             control->i2c_address = EEPROM_I2C_MADDR_4;
>>> -
>>> -     return true;
>>> -}
>>> -
>>> -static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
>>> -                                    struct amdgpu_ras_eeprom_control *control)
>>>  {
>>>       switch (adev->ip_versions[MP1_HWIP][0]) {
>>> +     case IP_VERSION(11, 0, 2): /* VEGA20 and ARCTURUS */
>>> +     case IP_VERSION(11, 0, 7):
>>>       case IP_VERSION(13, 0, 0):
>>> +     case IP_VERSION(13, 0, 2):
>>>       case IP_VERSION(13, 0, 10):
>>
>> I'd add the rest of the proper names here which are being deleted by this change,
>> so as to not lose this information by this commit: Sienna Cichlid and Aldebaran,
>> the rest can be left blank as per the current state of the code.
> 
> Fixed.
> 
>>
>>> -             control->i2c_address = EEPROM_I2C_MADDR_4;
>>>               return true;
>>>       default:
>>>               return false;
>>> @@ -178,29 +143,32 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
>>>               return true;
>>>       }
>>>
>>> -     switch (adev->asic_type) {
>>> -     case CHIP_VEGA20:
>>> -             control->i2c_address = EEPROM_I2C_MADDR_0;
>>> +     switch (adev->ip_versions[MP1_HWIP][0]) {
>>> +     case IP_VERSION(11, 0, 2):
>>> +             /* VEGA20 and ARCTURUS */
>>> +             if (adev->asic_type == CHIP_VEGA20)
>>> +                     control->i2c_address = EEPROM_I2C_MADDR_0;
>>> +             else if (strnstr(atom_ctx->vbios_version,
>>
>> In the code this is qualified with atom_ctx != NULL; and if it is,
>> then we return false. So, this is fine, iff we can guarantee that
>> "atom_ctx" will never be NULL. If, OTOH, we cannot guarantee that,
>> then we need to add,
>>                 else if (!atom_ctx)
>>                         return false;
>>                 else if (strnstr(...
>>
>> Although, I do recognize that for Aldebaran below, we do not qualify
>> atom_ctx, so we should probably qualify there too.
> 
> This function is called after the vbios is initialized so I think we
> can drop the check.  vbios is fetched in amdgpu_device_ip_early_init()
> and ras is initialized in amdgpu_device_ip_init() which is called much
> later.

Okay, so we can guarantee that atom_ctx is not NULL at this point.
Add my,

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

And if in the wild we see that it is, it'll be an easy fix.

Regards,
Luben


> 
> Alex
> 
>>
>>> +                              "D342",
>>> +                              sizeof(atom_ctx->vbios_version)))
>>> +                     control->i2c_address = EEPROM_I2C_MADDR_0;
>>> +             else
>>> +                     control->i2c_address = EEPROM_I2C_MADDR_4;
>>>               return true;
>>> -
>>> -     case CHIP_ARCTURUS:
>>> -             return __get_eeprom_i2c_addr_arct(adev, control);
>>> -
>>> -     case CHIP_SIENNA_CICHLID:
>>> +     case IP_VERSION(11, 0, 7):
>>>               control->i2c_address = EEPROM_I2C_MADDR_0;
>>>               return true;
>>> -
>>> -     case CHIP_ALDEBARAN:
>>> +     case IP_VERSION(13, 0, 2):
>>>               if (strnstr(atom_ctx->vbios_version, "D673",
>>>                           sizeof(atom_ctx->vbios_version)))
>>>                       control->i2c_address = EEPROM_I2C_MADDR_4;
>>>               else
>>>                       control->i2c_address = EEPROM_I2C_MADDR_0;
>>>               return true;
>>> -
>>> -     case CHIP_IP_DISCOVERY:
>>> -             return __get_eeprom_i2c_addr_ip_discovery(adev, control);
>>> -
>>> +     case IP_VERSION(13, 0, 0):
>>> +     case IP_VERSION(13, 0, 10):
>>> +             control->i2c_address = EEPROM_I2C_MADDR_4;
>>> +             return true;
>>>       default:
>>>               return false;
>>>       }
>>
>> --
>> Regards,
>> Luben
>>

