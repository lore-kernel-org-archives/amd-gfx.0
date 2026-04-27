Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEBDFF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 12:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1A810E720;
	Mon, 27 Apr 2026 12:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rqL7t5yV";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F5C10E720
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 12:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTUH7++6nAiq78rddpr2+C+yS82MJNDS4WDIDVwbFi/HNv3/6e2JGsPU58H9YFfB5gyLPUHkzk6m7hx6+iRVu9Kht+V4JtPIZVUjvleHRaqS4GMSH0EurddrGNUwpowmDOFHUwSwUlZASgwUqKeTqwofCutHC41B6kBNSu3+lCNUMYSkylnYFV5YPIJoWJUP02t7vh+mAZixQzLfRjpfRnFOVAqAxDY0sOGYEKkuoGdYpiPQWX7TGealNvKAVt+kT6FZ1QYphJdc03jlrfLbvajD5TFcZFeBaJc0nfoh3ARXDjpVEM8CX1qPrXjYBlBFpFdeq3msCiFDh+gtSdMdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADf/CEuhlp40Amsfot2zoCRGHYHTJK8nd1OJA2tuzTQ=;
 b=xAjR0S4+1Zk2CO0twE0JF7bU0/0VQbXdqbY5Zy75w1boY4iuFq3ULpXDtGbihqIaikmpfseUKjNNDLSzj6rLXblFYGrKNVNBlb1nz1L3Kn4FJg3gwfhBDPF5Y9Gf0iNvxaMh4IxR5may/bf1E6A8eI0hM8KGNZaFyJbR0JZTN+eUjzoMQUlV+juDKUhQstg7foqrR2VNw4H1EBF02aoqPs++AUNjXIxiBpY4ldpYPqy4lL6KKO9c2EzcsiowP8qNG9s1qv4ew13ccob5ckzkOFL61v2g16R7XgqaF1ULwrYbCwB6b5pl434PTcJgAQAgNUcSDoyQQD3w7tzK5LfH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADf/CEuhlp40Amsfot2zoCRGHYHTJK8nd1OJA2tuzTQ=;
 b=rqL7t5yVSXjcpVIMZOknXsTUbJHtl3rOEGj0Z3clXbX8jH79YxUFhWbzVnMUrF9kiTGyfk2x3D39zWpa0XUnmFeZ3Xzbz2w0rauldJCToor9A6u0zZ5+xSH6IdDO+yVeqQTdV3zBk6nomvM1Wvuqw2aB8dLzH+hoDwBf/XcYRec=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 12:23:46 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 12:23:45 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
Thread-Index: AQHc1hfT+/g/mRxeyUi136i5frsG/bXyhjYQgAAEMICAAAKJIIAAE5AAgAAt/oCAAASSAA==
Date: Mon, 27 Apr 2026 12:23:45 +0000
Message-ID: <DM6PR12MB29722EEFE265BC9704E3558882362@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260427073042.3547935-1-lijo.lazar@amd.com>
 <DM6PR12MB2972472A5F44139A4439029C82362@DM6PR12MB2972.namprd12.prod.outlook.com>
 <b462125b-0cf8-4fff-996c-26a58e48e438@amd.com>
 <DM6PR12MB2972F9AD29542173B6B9A9B882362@DM6PR12MB2972.namprd12.prod.outlook.com>
 <fe6ed465-47bb-41fa-9d3d-5e6c79b83bd7@amd.com>
 <DS7PR12MB60717B0AC6C53245966A41868E362@DS7PR12MB6071.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60717B0AC6C53245966A41868E362@DS7PR12MB6071.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T11:58:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|SJ1PR12MB6338:EE_
x-ms-office365-filtering-correlation-id: 8414881a-0af9-4f5e-c757-08dea457d3ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: t9HWax32/zMS9k0URn1fRwy/asKlKxcIdzRD43fOvZioYNnuOiLehu1CULuFKFTMo1PUF1QICidgb/VJXNlzytvKQwD1lvhz0u+TgCTkIFsmqzJZVu9K88xN3W5tcvLSpKXHw8nwYtfW1r8suh9wAgCXMEY8loI1c9GBcDiAz8NFC40s1Fs+uj289ga3Vh7lOAcg4w9AcJ2aOxPQJCwKdsrCOXfsBfbE3FumF6HHExokFtfFZ0mwNTUpt3//F4AVeXnVG2/0A6DmcW+STH2OpbsYldperCD1/FRmSWMJlNXMtRX1XIJysc9XS1hDZLCUHk8nU0j6TSmDKLfZFTZkRoM2X1ecy7DpUZDh5MalORwu7H67lbKAQhvYz0V2kPSmgGmVthHHndNTd40J2cKHF1m4W+ygylfYt7G1z6ums3TRZB4D3KckbBs8oo35VV56FhS9lHZYWhAO+OSd4EvytXoB/Tbw/UBAvbovpVK5qqQisbZf9KUv8vgDVehz/OKmz4X2cXJfAA1xD2YGdqdDRFzDeGW7PQg4ED6Bg4JxhcKEtHvVFajg0MlvI7pcJRgjARSJ8UTxSgr8JqJFzc+k1STlHYT5Vwt4Ha6AmcMsbKPcc9Qp5fg3c2EEj9RcS2GDPrXVE1R+AMsjn7CzzwhAKN4e+328gyGSknJ9TCnoa3L/q3LU3OmlO3oGMrjlyV3rabvRMQzkZr0TkK8AeA9m8rkzkYjunB5KqMNH/jsqA4y5pFfEkwQ7PI5FzE901K2yMW4oeu2NZT+6l/KsUixiK/ENj6pPFkN54ZLpjxYLNZY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hakvHWFNcOej03+Q1MIIw/KgHQFC8Ivg61RMn9hp4r34isLqgFbxZDX9Qz6F?=
 =?us-ascii?Q?HJ2QzLYcr9Enrtvlif4UcVAnZlwPO58scqGY2vcMYPmrek0irutSNdi5WF4Y?=
 =?us-ascii?Q?aHVEVd9fvyFE4XMRymZvODsKtoWv9X3m2Oup0nyUOtlLqB54oGcHj3cunKUF?=
 =?us-ascii?Q?pYeJTPVxNZ9HII96fl1UE23mhfLuWfYzKP561Y2r+irHj2LMz1od4kKWEPbI?=
 =?us-ascii?Q?xt63BpoURzy1hZGMl6IKkSrXgYhJBO7qR4+Uu56RtKeAJhMe4ZtuUBrHletP?=
 =?us-ascii?Q?Ir6TCHnbtD8XiZ1GuE2cnwAUyDhJF19VvSqbgiJM+whYD+olAGU+CyFrwwLZ?=
 =?us-ascii?Q?+6+0I5uBAF1l0KRDucYh1a1YIWvfg+tbypiZon5CHxPOcjwzos9Pc2hPzt3h?=
 =?us-ascii?Q?tqUeZQuFjhKNjAPWTdu34W54+q6OEMc6hCP7tatEf9XHI50yH3ZZIuvMQGgK?=
 =?us-ascii?Q?REjmuyFwyr6MY7YqtM1+QfcjFCF8nhwwzKxM9PTKoYYf3Ydeippo3YzvBIId?=
 =?us-ascii?Q?TDGkfn4nVjmQxw5R6w5jimv2Lm4b934Fv+rmF1uxbWqINuG5vwqUGAqH6Pio?=
 =?us-ascii?Q?r2W+Tfphter/dNxXN0YbYmXSWPk3dfIDqv+bjtA23rKwe+/egv2TdZ2UAD2U?=
 =?us-ascii?Q?L+o+eoHfmXvcVXr46pJfQG2JL17B77Z3FxSmH/WLiMP60/PNwUR3Tz8Pl5TW?=
 =?us-ascii?Q?1mp7frMYCC0E4xKXArp/yKV3OOhgHyrvLy3q5XEmQGWtF3QH+r65co6bn8GD?=
 =?us-ascii?Q?3gBCVuN3vwLNv6F1Sx161FcwPwtCSxBIb2G4R9PWssuB8xeyRzp9hqMUafeu?=
 =?us-ascii?Q?aWHFzO4CVyYX9K/Zfc2fDkip/CYGviiahtlh7+GHOM4Egpq0lYKTdAD5MOXj?=
 =?us-ascii?Q?ucAKeSz5HqKNZcWxq28rMQxs6AoRb9IK/spkBJznJbhrsMc05Yn/DlwWlnAm?=
 =?us-ascii?Q?rd5jli+P5xGvIozOa+KVWCZEvae2GQyEvKOOllBmSQ4XVyIdG1L8/BzLEIGv?=
 =?us-ascii?Q?kz2o5HeWOcaaSh5FYk+PqGCc4Al1Cm3skaAZT5rOriItB3I59TWxGUJwBYAU?=
 =?us-ascii?Q?DnQUvQaZzb3ZfCnNK95d2jklcJP7xsG/ju5nLhFenka5CPPn3hgz28qkDTfy?=
 =?us-ascii?Q?fXnnIGrCeZ4iT2YPMA/be162tIfoV5Ekrv0BTUDe6Yh4i5Afmk6pJMkBDIwO?=
 =?us-ascii?Q?n5Do7CDJXoilASUIcYDbqqRiuAq5konWnpxuaUT7bEGRo6csWlUANZIkbZni?=
 =?us-ascii?Q?0pUV5ENEl+ey9lRul3NLtQk4F/ZyeOrIudmztFVuqi/Vmp7ILqJZh3mvSAaT?=
 =?us-ascii?Q?HYnJkJ3bsUkR8pty1dJP9G/QsLtqO7yUkPxYGMdtFRfYEluGZ1ZhGc2xIcQh?=
 =?us-ascii?Q?766bmG0qUSlMJTqPsrusbaG+PzSmZd5UD5i6mT6Vvqagta/KnIAugdfQXTXr?=
 =?us-ascii?Q?yLzxyfgMlC9pxE28ElHMmq9bX6z79l+aGN9hc5j001RhH951ggyUjyPD2dsr?=
 =?us-ascii?Q?cqaf8PXPkDXA4R9TU+U29eCmS/j59YfiV21VJy0R4ExUSdOZRBO3DYKGlBB0?=
 =?us-ascii?Q?PoEp8Zuoa4k2cikYefZY6yHxGTbfrv8+ZsqOURyos98AvKmeWwdcZ6z3scHk?=
 =?us-ascii?Q?tqgAoX0ni3OY6JQVb76+2HkopaOjoTKov6TSEsH+lqC2fKmcS1kUGW/JWXUu?=
 =?us-ascii?Q?aTYf6d0E5Ezm2sIoLP0POIio8g7eQpQ+QSuL3v0KJP0WAy6f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8414881a-0af9-4f5e-c757-08dea457d3ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 12:23:45.5244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Et4v11xCHPyznU3wFbRfbFWXo8CIJQQeEx0XBSPihrm2JTC7sYApmq2B1nRgzgzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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

AMD General

Sorry, I need to revoke my Reviewed-by.
I object to adding this custom workaround for SMU v13.0.6 in the SMU common=
 layer.
The concern is that this stems from an incorrect this patch, then adding an=
 additional workaround to compensate for that incorrect change is not appro=
priate.

Best Regards,
Kevin

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Monday, April 27, 2026 20:00
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6

AMD General

With follow up patch already sent to update smu_cmn_print_dpm_clk_levels lo=
gic, there is no more update needed here

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad



-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, April 27, 2026 2:45 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6



On 27-Apr-26 1:39 PM, Wang, Yang(Kevin) wrote:
> AMD General
>
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, April 27, 2026 15:56
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
>
>
>
> On 27-Apr-26 1:16 PM, Wang, Yang(Kevin) wrote:
>> AMD General
>>
>> +       dpm_table->flags =3D SMU_DPM_TABLE_FINE_GRAINED;
>>
>> You need to move this line of code under smu_feature_is_enabled() to pre=
vent subsequent smu_cmn_print_dpm_clk_levels() errors.
>
> I think it's better to fix the smu_cmn_print_dpm_clk_levels() logic for t=
hat - to keep a separate path for dpm_table->count =3D=3D 1.
>
> [kevin]:
> No, this should be an independent issue, and you need to maintain consist=
ent code logic with other SMU functions.
> e.g: all locations where the smu_v13_0_set_single_dpm_table() function is=
 invoked.
>

The issue is because smu_cmn_print_dpm_clk_levels is hardcoding number of l=
evels to 2 for fine grained regardless of dpm enablement status. I think th=
e fix should be there rather than at other places. If the count is only 1, =
it shouldn't keep the hardcoded value as 2.

Thanks,
Lijo

> Best Regards,
> Kevin
>
> Thanks,
> Lijo
>
>>
>> With that fixed, the patch is
>>
>> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>>
>> Best Regards,
>> Kevin
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Lijo Lazar
>> Sent: Monday, April 27, 2026 15:31
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>> Subject: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
>>
>> Gfx clock is fine grained on SMU v13.0.6/12 SOCs. Add the flag to report=
 clock frequencies correctly.
>>
>> Fixes: 7380228401c4 ("drm/amd/pm: Use generic dpm table for SMUv13
>> SOCs")
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 40f0d8a685bf..8d04f6e73fd7 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -1133,6 +1133,7 @@ static int smu_v13_0_6_set_default_dpm_table(struc=
t smu_context *smu)
>>           /* gfxclk dpm table setup */
>>           dpm_table =3D &dpm_context->dpm_tables.gfx_table;
>>           dpm_table->clk_type =3D SMU_GFXCLK;
>> +       dpm_table->flags =3D SMU_DPM_TABLE_FINE_GRAINED;
>>           if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT=
)) {
>>                   /* In the case of gfxclk, only fine-grained dpm is hon=
ored.
>>                    * Get min/max values from FW.
>> --
>> 2.49.0
>>
>


