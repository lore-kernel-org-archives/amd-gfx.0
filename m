Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EA6C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 15:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F4A10E922;
	Mon, 21 Sep 2026 15:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VsnAAai4";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F4F10E914
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 15:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBP2Qp8nr5aRNQJQYqfx5HhfvKQh2Iz65smqDn6vxs6FXnkdatascSmWMuWsKwvmTZjML5WjR71MHUpSvfdVoQeoJAo2PDNqIUQQbNTQ74AtsgoNvnDl9EpoXU5uZWN3eyECuUPHQchqBHH7Iz85cgNAtEXqOn4R2v1NQexSrqRRoPesqCaISWbH9XR8kR1yZRIUbyJulaINyiilDSl33CS+54gfi5N2JIgvnoHuckOTM5Kjno+rh7ovYoFhB4ClCow4QireFwaHJTzCXRTzJ/UuSy+grNvdAg8aLa/9OKU6ljrDAeS4kLnu6x+aX11OyWIxpgDw2U4Nbd8fZaAjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTsm7RImddef5uBA8RWZlWYtwTdtSjQiR+fvwg40Z1M=;
 b=ZT5572+UD0lkl2FWzhfCGjVAM7H+6ewSL93B7r02gl4bZPEJw92gYlgTHkR65VqsUydcfAJwGWbuR90BR/UXbH6AOa6N8mtjqTaLI3wIsfAnp1tbREfFy7jb8OibBs2sO5ZZR4f/+Vzd8kyuPZALQLQ1h47cubs4UDo9aNhjQTV4d9/MnwLrAB51v8JhRREpAXfpguxu5N78lvO3CTeeZNXj5ITOM7oCxXn0NKO6L2uwlI2ijzWsD/EyfYdV1PQXBH2JAN7G8bW/mgTfMhD7EZx2diAbkx3XWwzPUIiImUiz3FLT6ZpvHozIg2eUmxnx/pOHaAOEoXW/QRF3hsFoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTsm7RImddef5uBA8RWZlWYtwTdtSjQiR+fvwg40Z1M=;
 b=VsnAAai4oK57/NXXOAjkyHznbQUr65ej8EB4YeS/n45ya95jegbzqfqP8JDxdrrkj9+EnRde3sPWTEk0RlNOmb6lzpAMMJVhnaIyoxHobwU9WSwrej1+lONlGPd/oMzMiJ3ktWxaOCnOyBhDeah3sINrxcRXbIJnBVz7A9aKNj8=
Received: from SA1PR12MB999254.namprd12.prod.outlook.com
 (2603:10b6:806:4dd::21) by IA4PR12MB469045.namprd12.prod.outlook.com
 (2603:10b6:207:108::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:49:31 +0000
Received: from SA1PR12MB999254.namprd12.prod.outlook.com
 ([fe80::1db3:8b2a:94f4:f5b2]) by SA1PR12MB999254.namprd12.prod.outlook.com
 ([fe80::1db3:8b2a:94f4:f5b2%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:49:31 +0000
From: "He, Siwei" <Siwei.He@amd.com>
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Indic, Vladimir" <Vladimir.Indic@amd.com>
Subject: Re: [PATCH] drm/amdkfd: add dynamic VGPR save/restore to the gfx12
 trap handler
Thread-Topic: [PATCH] drm/amdkfd: add dynamic VGPR save/restore to the gfx12
 trap handler
Thread-Index: AQHdK/Tg+RL3fhm4OkOEGcxcWsuhWbbTiboAgAXJlVo=
Date: Mon, 21 Sep 2026 15:49:31 +0000
Message-ID: <SA1PR12MB999254C203B930C1E9D9DCEDE09F842@SA1PR12MB999254.namprd12.prod.outlook.com>
References: <20260814135720.3575351-1-siwei.he@amd.com>
 <278e2182-a840-4cb1-8e17-ad4495441f1f@amd.com>
In-Reply-To: <278e2182-a840-4cb1-8e17-ad4495441f1f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-21T15:49:30.358Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB999254:EE_|IA4PR12MB469045:EE_
x-ms-office365-filtering-correlation-id: 2bb1a3f5-5664-435b-f286-08df17f7ed07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003|56012099006|4143699003|8096899003|13003099007|38070700021;
x-microsoft-antispam-message-info: uUk00JDiAiuZoK3zNjBGps3LqwGs9wjaXWKpM4lIpnPBzdwEbn60RUGKnwLMvfG5/0EH68r+1B3IuFgTUkFgt8Zko5oiF/xIxggbz9stgwxRzcy6eV4P2C+Fj1dzwWRijuTgoZpOZNIU9BUx0bmgXIRsffwrwOdWRALWIcxMub4OXPnsjdH/LP1cM8+5/wtrKpLMdDXxbpQmvTxVfsmEzZKk2TdDsZTF16HYxIBKdIXIwz7R9arI0UEb6iL/UoEMKlKcN2Sl20Di7CR/o7B+IaDnceb+NAXuwoDgdEtAIcjRLFwQTcb8pVjvHijUPPZjzHcS9j8d1oUuoaMI76/rWoL9ZYD5QLXAYBOw7BK/jOC7rEh8Q1HG85qHWBTEYiFk5SFbAeSpAtPgTQKLLG1Lev9xcK9pFhM6nVFLwHlxcoWhvM6mUXfcKgkatxbHb+FAPNPCpmsC+G1DtuIUM6w1wCTox1umG3YnWaTZTq3fcFG/jTut1AZRAax34GmLqg7KeJ5uI9lfWp5A8JO9JJNm6aQWg0KpoaYJeg9OMVyOdEsJ7OK8hJMu/iw/zprkt9DHWM9lTiYYStU9z0jkFfG9z+5h2W827PMNs1jMoxe3YdOE19MOCPm/ns+Vj38o2ZoI95f4avvEbKoJsIoS83DkRMgs6LNlH6Tf2+9S02cVRR7VZvTlhoB77pf8EkJc9snhAeOmasvGsPYVVBLTrGUW/j4B3/TwaLe6ZYdpUV2uBl8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB999254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003)(8096899003)(13003099007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gUoFNpRSQmtPTvx7CS+UxBwac+sa6sJNA/ztYp25uJGscvlThg4b1UhNoy?=
 =?iso-8859-1?Q?Y8/BGol1bPWeN/N5dyCTzBG+PHddgRCY/WqxKHOUE1/oI7aLgAD2+/0wRL?=
 =?iso-8859-1?Q?HCtwaNqn5E7cWEhXORDjdr1Y0R8TPtBhDxVij7ajjK4sut7rc7hY4JyRWm?=
 =?iso-8859-1?Q?CDeeDn6SGheRVXu2FpssjrysoTY+Dxwdti0smEHyeYZxuMs1vQJEvUqmrQ?=
 =?iso-8859-1?Q?jZvQAeabuiio54t+q+JY7ivFn5Cg7n9lKXgV81djellfbOlm0bfTdZ0H+0?=
 =?iso-8859-1?Q?hYG/iLj+1BlN2ENuxhA5G2m1fWNZVDNcwp4Vy6vvIkEWr1+48zuEcgAYwE?=
 =?iso-8859-1?Q?JcWi31RS5U9wPG9Yc9s67IDwhIO/VpGIzn2X2sKhILNh4e1hVLEL3VBu4r?=
 =?iso-8859-1?Q?bokDAHVQ3Cz5zmEnLb1loxAXrVYphiz4n3tFHC+8OGHWDBUP9LTQpKnYve?=
 =?iso-8859-1?Q?ilqQVbCQhL+i4WNB4ixl3fAQqXBW4gtskAmOFrYasfiYipYjVBxarCsfZv?=
 =?iso-8859-1?Q?enFAbvchiECk0rVcrTNK2SPoCh///1ibquM43hqJNe4qR8Z+gB/4NYDNEn?=
 =?iso-8859-1?Q?XpuiDsTwEqWEaBxS/4uxZECDdR/K8htQRrMb4dm8E8ckomUhrR9p4lCJDI?=
 =?iso-8859-1?Q?P9yJAVPFm0buCv8DiAa0bCOrbTPE3O7O0TUDhxb5AHnpRSRso5Yny9R9AP?=
 =?iso-8859-1?Q?y4HXveWGIhUo9TseukaDCjqkz78vfd/x4z5dbMlny2P3gfmiXha/BUHVDs?=
 =?iso-8859-1?Q?fPtnkDntHfDINSL76z+nQ8Jn+nY288tolwIdpOU9bXqv9bFIeAwxcqHIj+?=
 =?iso-8859-1?Q?3uFs8fgMBmMHmKr4SI730Eo8mSB6sCY51sAmX7JuFaoB+YDa4vvgyCEY1o?=
 =?iso-8859-1?Q?F5ASByT9YhKWLpLS7SB7RgmFoY2EMjF7BFC0BnGoSZfmI5IOHxdToX44Rl?=
 =?iso-8859-1?Q?aHhan6vBtMFQ125QsnMQYEMwbrQSw5LKTgj0ZW6trNZPnBe9CEW5kQiQ7y?=
 =?iso-8859-1?Q?TwqTsEB+vFVuYyjiwHd64AnYBfyuc5LHsI+LRwCZD/yQDkQ2qRkuxMl+c5?=
 =?iso-8859-1?Q?miuOg7CWkxLPuCEdUrwI6X3WRTUFtfCkT6ANYAV7yc1A1mcSlulc0gqFG1?=
 =?iso-8859-1?Q?CFkINAGNAC9hXEFV0F6SxtWaAZ3ba9cMq3KMfP9GGFEYFW2RDC7CEDClFI?=
 =?iso-8859-1?Q?NNrqN/9Ujjx4X5/lOeI19inHlQhWMKixzEJ6f9pJkP2tT/knG7Cqlmhgx+?=
 =?iso-8859-1?Q?BwgOgVtAs0JODNJmFsvwyg6C2YvNo1TH1Rdr0WzZR9HAUpAlY97ZzP+BOl?=
 =?iso-8859-1?Q?c2AX3jx5Y/BLhyL1+pU/cK7bEoHlyZvY48xcZ4QUwivHy+kMdRU3FSFH1/?=
 =?iso-8859-1?Q?vKGoEmHG6DU26VDLQPBWa0NfnGxJj5jy3QJMt9LqPdx1pobKuWvdD6446N?=
 =?iso-8859-1?Q?rFkiR4IYcLJwTrAsTaqwA3JYQyaOXqVSSw3KpgRogx7HS09QO0rMsoCVAo?=
 =?iso-8859-1?Q?kePyT3wVAom3HNaGX0NRhw8qZW6JmDM49gieZXsoeRVMiTXCGPOh32bEbA?=
 =?iso-8859-1?Q?KyQrRkM+7KbG0TpGGv5x4+BG/PsF7r/CEGg4sStay4jBm52j7zsXey4L+j?=
 =?iso-8859-1?Q?PGIOywTEp0xF/sNPRxBxFkdC4jAlG4mJl3Eun+IHBANsJO9PL38m+qaIGF?=
 =?iso-8859-1?Q?+LqHHeDJFeRM/c3rMeVy4cDW/L/jlLRMosbqUOIcjm1CGkcBMzgAQtWbWE?=
 =?iso-8859-1?Q?QJ8HV4cxSsJK0qRPT/zjsq4vq+bPHyIKvIHsVaodpeymOz?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB999254C203B930C1E9D9DCEDE09F842SA1PR12MB999254_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb1a3f5-5664-435b-f286-08df17f7ed07
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 15:49:31.0692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sksqbeqgdez7R/9ngAFYvfgco7HEpkH8omEp71GDEgthoGx7qyX2b67kgyLRqi6RsJSYD72nb9Yjt30ZjPknmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB469045
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

--_000_SA1PR12MB999254C203B930C1E9D9DCEDE09F842SA1PR12MB999254_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Lancelot,

I put some comments regarding your review. I will update the change and sen=
d out another review later. Thank you for taking the time for reviewing the=
 code!

Siwei

________________________________
From: Six, Lancelot <Lancelot.Six@amd.com>
Sent: Thursday, September 17, 2026 6:06 PM
To: He, Siwei <Siwei.He@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@li=
sts.freedesktop.org>
Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.c=
om>; Indic, Vladimir <Vladimir.Indic@amd.com>
Subject: Re: [PATCH] drm/amdkfd: add dynamic VGPR save/restore to the gfx12=
 trap handler

Hi Siwei,

Thanks for working on this.

Comments included inline.

On 14/08/2026 14:57, Siwei He wrote:
> A gfx12 wave using dynamic VGPRs is launched with a fixed 16-VGPR block
> and allocates the rest from a shared pool with s_alloc_vgpr.
>   - the fixed block (WAVE_MIN_NUM_DVGPRS, 16 VGPRs) continues to go to
>     the CWSR buffer;
>   - the dynamic VGPRs go to the wave's scratch, which is durable per wave
>     and therefore survives a restore that cannot reallocate them.
>
> Persist wave's total VGPR count in a 4-byte per-lane
> slot reserved at the front of the dynamic-VGPR scratch region, read back
> through a VGPR lane since scratch is per lane.
>
> Restore reallocates with s_alloc_vgpr once SCRATCH_BASE is available and
> retries while the pool is full. If a context save becomes pending while
> the allocation still cannot be satisfied, waiting would block the very
> preemption that frees pool space, so the wave leaves its dynamic VGPRs
> in scratch, completes the restore without resuming the shader, and
> re-enters the save path at L_SAVE_BYPASS to be retried on a later
> restore. Such a re-save must not overwrite the persisted count.
> The live allocation has collapsed to the fixed block, and recording that =
would
> lose the real count and strand the dynamic VGPRs in scratch. Signal the
> condition in PC_HI bit 1.

Should this be PC_HI bit 16?
Yes, it should be bit 16!

> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 356 +++++++++++-------
>   .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 217 ++++++++++-
>   2 files changed, 432 insertions(+), 141 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu=
/drm/amd/amdkfd/cwsr_trap_handler.h
> index 54fa76f374c9..259b2a4a1940 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -3644,7 +3644,7 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] =3D =
{
>   };
>
>   static const uint32_t cwsr_trap_gfx12_hex[] =3D {
> -     0xbfa00001, 0xbfa00239,
> +     0xbfa00001, 0xbfa00273,
>        0xb0804009, 0xb8eef81a,
>        0xbf880000, 0xb980081a,
>        0x00000000, 0xb8f8f804,
> @@ -3707,7 +3707,10 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
>        0x000c0000, 0x00000000,
>        0x7e000280, 0xbefe007a,
>        0xbeff007b, 0xb8fb0742,
> -     0x847b997b, 0xb8fa3b05,
> +     0x847b997b, 0xb8faf802,
> +     0xbf0d9e7a, 0xbfa10003,
> +     0xbefa00ff, 0x00000800,
> +     0xbfa00007, 0xb8fa3b05,
>        0x807a817a, 0xbf0d997b,
>        0xbfa20002, 0x847a897a,
>        0xbfa00001, 0x847a8a7a,
> @@ -3748,6 +3751,9 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
>        0xee0a4074, 0x010c0000,
>        0x00020000, 0xee0a4074,
>        0x018c0000, 0x00030000,
> +     0xb8f0f802, 0xbf0d9e70,
> +     0xbfa10003, 0xbef000ff,
> +     0x00000800, 0xbfa00007,
>        0xb8f03b05, 0x80708170,
>        0xbf0d9973, 0xbfa20002,
>        0x84708970, 0xbfa00001,
> @@ -3790,7 +3796,10 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
>        0xbeff0080, 0x80767074,
>        0x82778075, 0xee0a4076,
>        0x010c0000, 0x00000000,
> -     0xbefe00c1, 0xb8f03b05,
> +     0xbefe00c1, 0xb8f0f802,
> +     0xbf0d9e70, 0xbfa10003,
> +     0xbef000ff, 0x00000800,
> +     0xbfa00007, 0xb8f03b05,
>        0x80708170, 0xbf0d9973,
>        0xbfa20002, 0x84708970,
>        0xbfa00001, 0x84708a70,
> @@ -3859,9 +3868,12 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
>        0xbf06817d, 0xbfa20002,
>        0xbeff0080, 0xbfa00001,
>        0xbeff00c1, 0xb8fb4306,
> -     0x8b7bc17b, 0xbfa10042,
> +     0x8b7bc17b, 0xbfa10048,
>        0x8b7aff6d, 0x80000000,
> -     0xbfa1003f, 0x847b897b,
> +     0xbfa10045, 0x847b897b,
> +     0xb8f0f802, 0xbf0d9e70,
> +     0xbfa10003, 0xbef000ff,
> +     0x00000800, 0xbfa00007,
>        0xb8f03b05, 0x80708170,
>        0xbf0d9973, 0xbfa20002,
>        0x84708970, 0xbfa00001,
> @@ -3902,20 +3914,37 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
>        0xb8fb3b05, 0x807b817b,
>        0x847b827b, 0x857d9973,
>        0x8b7d817d, 0xbf06817d,
> -     0xbfa2001b, 0xbefd0084,
> -     0xbf0a7b7d, 0xbfa10032,
> -     0x7e008700, 0x7e028701,
> -     0x7e048702, 0x7e068703,
> -     0x80767074, 0x82778075,
> -     0xee0a4076, 0x000c0000,
> -     0x00000000, 0xee0a4076,
> -     0x008c0000, 0x00008000,
> -     0xee0a4076, 0x010c0000,
> -     0x00010000, 0xee0a4076,
> -     0x018c0000, 0x00018000,
> -     0x807d847d, 0x8070ff70,
> -     0x00000200, 0xbf0a7b7d,
> -     0xbfa2ffe9, 0xbfa0001a,
> +     0xbfa2003d, 0xbefd0084,
> +     0xb8faf802, 0xbf0a7b7d,
> +     0xbfa10053, 0x7e008700,
> +     0x7e028701, 0x7e048702,
> +     0x7e068703, 0x80767074,
> +     0x82778075, 0xee0a4076,
> +     0x000c0000, 0x00000000,
> +     0xee0a4076, 0x008c0000,
> +     0x00008000, 0xee0a4076,
> +     0x010c0000, 0x00010000,
> +     0xee0a4076, 0x018c0000,
> +     0x00018000, 0x807d847d,
> +     0xbf0d9e7a, 0xbfa10002,
> +     0xbf0a907d, 0xbfa10005,
> +     0x8070ff70, 0x00000200,
> +     0xbf0a7b7d, 0xbfa2ffe5,
> +     0xbfa00037, 0xbf0d906d,
> +     0xbfa20035, 0xbef00080,
> +     0x7e00027b, 0xed068070,
> +     0x00000000, 0x00000000,
> +     0xbef00084, 0xbf097b7d,
> +     0xbfa2002d, 0x7e008700,
> +     0x7e028701, 0x7e048702,
> +     0x7e068703, 0xed068070,
> +     0x00000000, 0x00000000,
> +     0xed068070, 0x00800000,
> +     0x00000400, 0xed068070,
> +     0x01000000, 0x00000800,
> +     0xed068070, 0x01800000,
> +     0x00000c00, 0x807d847d,
> +     0x80709070, 0xbfa0ffeb,
>        0xbefd0084, 0xbf0a7b7d,
>        0xbfa10017, 0x7e008700,
>        0x7e028701, 0x7e048702,
> @@ -3929,17 +3958,20 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
>        0x00030000, 0x807d847d,
>        0x8070ff70, 0x00000400,
>        0xbf0a7b7d, 0xbfa2ffe9,
> -     0xbfa0014c, 0xbef4007e,
> +     0xbfa001ab, 0xbef4007e,
>        0x8b75ff7f, 0x0000ffff,
>        0xbef1007f, 0xb8f20742,
>        0x84729972, 0x8b6eff7f,
> -     0x04000000, 0xbfa10044,
> +     0x04000000, 0xbfa1004a,
>        0xbefe00c1, 0x857d9972,
>        0x8b7d817d, 0xbf06817d,
>        0xbfa20002, 0xbeff0080,
>        0xbfa00001, 0xbeff00c1,
>        0xb8ef4306, 0x8b6fc16f,
> -     0xbfa10039, 0x846f896f,
> +     0xbfa1003f, 0x846f896f,
> +     0xb8f8f802, 0xbf0d9e78,
> +     0xbfa10003, 0xbef800ff,
> +     0x00000800, 0xbfa00007,
>        0xb8f83b05, 0x80788178,
>        0xbf0d9972, 0xbfa20002,
>        0x84788978, 0xbfa00001,
> @@ -3972,134 +4004,178 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D=
 {
>        0x857d9972, 0x8b7d817d,
>        0xbf06817d, 0xbfa20002,
>        0xbeff0080, 0xbfa00001,
> -     0xbeff00c1, 0xb8ef3b05,
> -     0x806f816f, 0x846f826f,
> -     0x857d9972, 0x8b7d817d,
> -     0xbf06817d, 0xbfa2002c,
> -     0xbeee0078, 0x8078ff78,
> -     0x00000200, 0xbefd0084,
> -     0x80767874, 0x82778075,
> -     0xee0a0076, 0x000c0000,
> -     0x00000000, 0xee0a0076,
> -     0x000c0001, 0x00008000,
> -     0xee0a0076, 0x000c0002,
> -     0x00010000, 0xee0a0076,
> -     0x000c0003, 0x00018000,
> -     0xbf8a0000, 0x7e008500,
> -     0x7e028501, 0x7e048502,
> -     0x7e068503, 0x807d847d,
> +     0xbeff00c1, 0xb8ecf802,
> +     0xbf0d9e6c, 0xbfa10002,
> +     0xbeef0090, 0xbfa00003,
> +     0xb8ef3b05, 0x806f816f,
> +     0x846f826f, 0x857d9972,
> +     0x8b7d817d, 0xbf06817d,
> +     0xbfa2002c, 0xbeee0078,
>        0x8078ff78, 0x00000200,
> -     0xbf0a6f7d, 0xbfa2ffe8,
> -     0x80766e74, 0x82778075,
> -     0xee0a0076, 0x000c0000,
> -     0x00000000, 0xee0a0076,
> -     0x000c0001, 0x00008000,
> -     0xee0a0076, 0x000c0002,
> -     0x00010000, 0xee0a0076,
> -     0x000c0003, 0x00018000,
> -     0xbf8a0000, 0xbfa0002d,
> -     0xbeee0078, 0x8078ff78,
> -     0x00000400, 0xbefd0084,
> -     0xbf0a6f7d, 0xbfa10018,
> -     0x80767874, 0x82778075,
> -     0xee0a0076, 0x000c0000,
> -     0x00000000, 0xee0a0076,
> -     0x000c0001, 0x00010000,
> -     0xee0a0076, 0x000c0002,
> -     0x00020000, 0xee0a0076,
> -     0x000c0003, 0x00030000,
> -     0xbf8a0000, 0x7e008500,
> -     0x7e028501, 0x7e048502,
> -     0x7e068503, 0x807d847d,
> +     0xbefd0084, 0x80767874,
> +     0x82778075, 0xee0a0076,
> +     0x000c0000, 0x00000000,
> +     0xee0a0076, 0x000c0001,
> +     0x00008000, 0xee0a0076,
> +     0x000c0002, 0x00010000,
> +     0xee0a0076, 0x000c0003,
> +     0x00018000, 0xbf8a0000,
> +     0x7e008500, 0x7e028501,
> +     0x7e048502, 0x7e068503,
> +     0x807d847d, 0x8078ff78,
> +     0x00000200, 0xbf0a6f7d,
> +     0xbfa2ffe8, 0x80766e74,
> +     0x82778075, 0xee0a0076,
> +     0x000c0000, 0x00000000,
> +     0xee0a0076, 0x000c0001,
> +     0x00008000, 0xee0a0076,
> +     0x000c0002, 0x00010000,
> +     0xee0a0076, 0x000c0003,
> +     0x00018000, 0xbf8a0000,
> +     0xbfa0002d, 0xbeee0078,
>        0x8078ff78, 0x00000400,
> -     0xbf0a6f7d, 0xbfa2ffe8,
> -     0x80766e74, 0x82778075,
> -     0xee0a0076, 0x000c0000,
> -     0x00000000, 0xee0a0076,
> -     0x000c0001, 0x00010000,
> -     0xee0a0076, 0x000c0002,
> -     0x00020000, 0xee0a0076,
> -     0x000c0003, 0x00030000,
> -     0xbf8a0000, 0xb8f83b05,
> -     0x80788178, 0xbf0d9972,
> -     0xbfa20002, 0x84788978,
> -     0xbfa00001, 0x84788a78,
> -     0x8078ff78, 0x00000200,
> -     0x80f8ff78, 0x00000060,
> -     0x80767874, 0x82778075,
> -     0xbefd00ff, 0x0000006c,
> -     0xf460403b, 0xf8000000,
> -     0xbf8a0000, 0x80fd847d,
> -     0xbf800000, 0xbe804300,
> -     0xbe824302, 0x80f6a076,
> -     0x82f78077, 0xf460603b,
> +     0xbefd0084, 0xbf0a6f7d,
> +     0xbfa10018, 0x80767874,
> +     0x82778075, 0xee0a0076,
> +     0x000c0000, 0x00000000,
> +     0xee0a0076, 0x000c0001,
> +     0x00010000, 0xee0a0076,
> +     0x000c0002, 0x00020000,
> +     0xee0a0076, 0x000c0003,
> +     0x00030000, 0xbf8a0000,
> +     0x7e008500, 0x7e028501,
> +     0x7e048502, 0x7e068503,
> +     0x807d847d, 0x8078ff78,
> +     0x00000400, 0xbf0a6f7d,
> +     0xbfa2ffe8, 0x80766e74,
> +     0x82778075, 0xee0a0076,
> +     0x000c0000, 0x00000000,
> +     0xee0a0076, 0x000c0001,
> +     0x00010000, 0xee0a0076,
> +     0x000c0002, 0x00020000,
> +     0xee0a0076, 0x000c0003,
> +     0x00030000, 0xbf8a0000,
> +     0xb8f8f802, 0xbf0d9e78,
> +     0xbfa10003, 0xbef800ff,
> +     0x00000800, 0xbfa00007,
> +     0xb8f83b05, 0x80788178,
> +     0xbf0d9972, 0xbfa20002,
> +     0x84788978, 0xbfa00001,
> +     0x84788a78, 0x8078ff78,
> +     0x00000200, 0x80f8ff78,
> +     0x00000060, 0x80767874,
> +     0x82778075, 0xbefd00ff,
> +     0x0000006c, 0xf460403b,
>        0xf8000000, 0xbf8a0000,
> -     0x80fd887d, 0xbf800000,
> +     0x80fd847d, 0xbf800000,
>        0xbe804300, 0xbe824302,
> -     0xbe844304, 0xbe864306,
> -     0x80f6c076, 0x82f78077,
> -     0xf460803b, 0xf8000000,
> -     0xbf8a0000, 0x80fd907d,
> +     0x80f6a076, 0x82f78077,
> +     0xf460603b, 0xf8000000,
> +     0xbf8a0000, 0x80fd887d,
>        0xbf800000, 0xbe804300,
>        0xbe824302, 0xbe844304,
> -     0xbe864306, 0xbe884308,
> -     0xbe8a430a, 0xbe8c430c,
> -     0xbe8e430e, 0xbf06807d,
> -     0xbfa1ffef, 0xb980f801,
> -     0x00000000, 0xb8f83b05,
> -     0x80788178, 0xbf0d9972,
> -     0xbfa20002, 0x84788978,
> -     0xbfa00001, 0x84788a78,
> -     0x8078ff78, 0x00000200,
> -     0x80767874, 0x82778075,
> -     0xbeff0071, 0xf4601bfb,
> -     0xf8000000, 0xf4601b3b,
> -     0xf8000004, 0xf4601b7b,
> -     0xf8000008, 0xf4601c3b,
> -     0xf800000c, 0xf4601c7b,
> -     0xf8000010, 0xf4601ebb,
> -     0xf8000014, 0xf4601efb,
> -     0xf8000018, 0xf4601e7b,
> -     0xf800001c, 0xf4601cfb,
> -     0xf8000020, 0xf4601bbb,
> -     0xf8000024, 0xbf8a0000,
> -     0xb96ef814, 0xf4601bbb,
> -     0xf8000028, 0xbf8a0000,
> -     0xb96ef815, 0xf4601bbb,
> -     0xf800002c, 0xbf8a0000,
> -     0xb96ef812, 0xf4601bbb,
> -     0xf8000030, 0xbf8a0000,
> -     0xb96ef813, 0x8b6eff7f,
> -     0x04000000, 0xbfa1000b,
> -     0xf4601bbb, 0xf8000038,
> -     0xbf8a0000, 0xbf0d806e,
> -     0xbfa10006, 0x856e906e,
> -     0x8b6e6e6e, 0xbfa10003,
> -     0xbe804ec1, 0x816ec16e,
> -     0xbfa0fffb, 0xbefd006f,
> -     0xbefe0070, 0xbeff0071,
> -     0xb97b2011, 0x857b867b,
> -     0xb97b0191, 0x857b827b,
> -     0xb97bba11, 0xb973f801,
> -     0xb8ee3b05, 0x806e816e,
> +     0xbe864306, 0x80f6c076,
> +     0x82f78077, 0xf460803b,
> +     0xf8000000, 0xbf8a0000,
> +     0x80fd907d, 0xbf800000,
> +     0xbe804300, 0xbe824302,
> +     0xbe844304, 0xbe864306,
> +     0xbe884308, 0xbe8a430a,
> +     0xbe8c430c, 0xbe8e430e,
> +     0xbf06807d, 0xbfa1ffef,
> +     0xb980f801, 0x00000000,
> +     0xb8f8f802, 0xbf0d9e78,
> +     0xbfa10003, 0xbef800ff,
> +     0x00000800, 0xbfa00007,
> +     0xb8f83b05, 0x80788178,
>        0xbf0d9972, 0xbfa20002,
> -     0x846e896e, 0xbfa00001,
> -     0x846e8a6e, 0x806eff6e,
> -     0x00000240, 0x806e746e,
> -     0x826f8075, 0xf4605c37,
> -     0xf8000010, 0xf4605d37,
> -     0xf8000020, 0xf4601e77,
> -     0xf8000034, 0xbf8a0000,
> -     0x8b6dff6d, 0x0000ffff,
> -     0x8bfe7e7e, 0x8bea6a6a,
> -     0x936eff77, 0x0002001a,
> -     0xb96ef81a, 0xb97af804,
> +     0x84788978, 0xbfa00001,
> +     0x84788a78, 0x8078ff78,
> +     0x00000200, 0x80767874,
> +     0x82778075, 0xbeff0071,
> +     0xf4601bfb, 0xf8000000,
> +     0xf4601b3b, 0xf8000004,
> +     0xf4601b7b, 0xf8000008,
> +     0xf4601c3b, 0xf800000c,
> +     0xf4601c7b, 0xf8000010,
> +     0xf4601ebb, 0xf8000014,
> +     0xf4601efb, 0xf8000018,
> +     0xf4601e7b, 0xf800001c,
> +     0xf4601cfb, 0xf8000020,
> +     0xf4601bbb, 0xf8000024,
> +     0xbf8a0000, 0xb96ef814,
> +     0xf4601bbb, 0xf8000028,
> +     0xbf8a0000, 0xb96ef815,
> +     0xf4601bbb, 0xf800002c,
> +     0xbf8a0000, 0xb96ef812,
> +     0xf4601bbb, 0xf8000030,
> +     0xbf8a0000, 0xb96ef813,
> +     0x8b6eff7f, 0x04000000,
> +     0xbfa1000b, 0xf4601bbb,
> +     0xf8000038, 0xbf8a0000,
> +     0xbf0d806e, 0xbfa10006,
> +     0x856e906e, 0x8b6e6e6e,
> +     0xbfa10003, 0xbe804ec1,
> +     0x816ec16e, 0xbfa0fffb,
> +     0xbef80080, 0xb8f6f802,
> +     0xbf0d9e76, 0xbfa10038,
> +     0xbefe00c1, 0xbef80080,
> +     0xed050078, 0x00000000,
> +     0x00000000, 0xbfc00000,
> +     0xd7600077, 0x00010100,
> +     0xbef60077, 0xbe805376,
> +     0xbfa20006, 0xb8f6f811,
> +     0x8b76a076, 0xbf830010,
> +     0xbfa1fff9, 0xbef80081,
> +     0xbfa0001a, 0xbefe00c1,
> +     0xbefd0090, 0xbef80084,
> +     0xbf0a777d, 0xbfa10015,
> +     0xed050078, 0x00000000,
> +     0x00000000, 0xed050078,
> +     0x00000001, 0x00000400,
> +     0xed050078, 0x00000002,
> +     0x00000800, 0xed050078,
> +     0x00000003, 0x00000c00,
> +     0xbfc00000, 0x7e008500,
> +     0x7e028501, 0x7e048502,
> +     0x7e068503, 0x807d847d,
> +     0x80789078, 0xbf0a777d,
> +     0xbfa2ffeb, 0xee0a0074,
> +     0x000c0000, 0x00000000,
> +     0xee0a0074, 0x000c0001,
> +     0x00008000, 0xee0a0074,
> +     0x000c0002, 0x00010000,
> +     0xee0a0074, 0x000c0003,
> +     0x00018000, 0xbf8a0000,
> +     0xbefd006f, 0xbefe0070,
> +     0xbeff0071, 0xb97b2011,
> +     0x857b867b, 0xb97b0191,
> +     0x857b827b, 0xb97bba11,
> +     0xb973f801, 0xb8eef802,
> +     0xbf0d9e6e, 0xbfa10003,
> +     0xbeee00ff, 0x00000800,
> +     0xbfa00007, 0xb8ee3b05,
> +     0x806e816e, 0xbf0d9972,
> +     0xbfa20002, 0x846e896e,
> +     0xbfa00001, 0x846e8a6e,
> +     0x806eff6e, 0x00000240,
> +     0x806e746e, 0x826f8075,
> +     0xf4605c37, 0xf8000010,
> +     0xf4605d37, 0xf8000020,
> +     0xf4601e77, 0xf8000034,
> +     0xbf8a0000, 0x8b6dff6d,
> +     0x0000ffff, 0x8bfe7e7e,
> +     0x8bea6a6a, 0xbf068178,
> +     0xbfa20007, 0x936eff77,
> +     0x0002001a, 0xb96ef81a,
> +     0xb97af804, 0xbe804ec2,
> +     0xbf94fffe, 0xbe804a6c,
> +     0xbef8007a, 0x8c6dff6d,
> +     0x00010000, 0xbfa0fc47,
>        0xbe804ec2, 0xbf94fffe,
> -     0xbe804a6c, 0xbe804ec2,
> -     0xbf94fffe, 0xbfb10000,
> +     0xbfb10000, 0xbf9f0000,
>        0xbf9f0000, 0xbf9f0000,
>        0xbf9f0000, 0xbf9f0000,
> -     0xbf9f0000, 0x00000000,
>   };
>
>   static const uint32_t cwsr_trap_gfx9_5_0_hex[] =3D {
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/dri=
vers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index d38ff404277b..355b5175f141 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -38,6 +38,7 @@
>   #define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY =3D=3D CHIP_G=
C_12_0_3)
>   #define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY =3D=3D CHIP_GFX12)
>   #define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)
> +#define HAVE_DYNAMIC_VGPRS (ASIC_FAMILY =3D=3D CHIP_GFX12)
>
>   #define SINGLE_STEP_MISSED_WORKAROUND 1     //workaround for lost TRAP_=
AFTER_INST exception when SAVECTX raised
>   #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY =3D=3D CHIP_GFX12)
> @@ -60,16 +61,20 @@ var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT           =3D=
 15
>   var SQ_WAVE_STATUS_WAVE64_SHIFT                     =3D 29
>   var SQ_WAVE_STATUS_WAVE64_SIZE                      =3D 1
>   var SQ_WAVE_STATUS_NO_VGPRS_SHIFT           =3D 24
> +var SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT         =3D 30
>   var SQ_WAVE_STATUS_IN_WG_SHIFT                      =3D 11
>   var SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK    =3D SQ_WAVE_STATE_PRIV_SYS_=
PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK
>   var S_SAVE_PC_HI_TRAP_ID_MASK                       =3D 0xF0000000
>
>   var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT                =3D 12
>   var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE         =3D 9
> +var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_MASK         =3D 0xFF000
>   var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE                =3D 8
>   var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT               =3D 12
>
>   #if ASIC_FAMILY < CHIP_GC_12_0_3
> +var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT =3D 24
> +var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE  =3D 4
>   var SQ_WAVE_LDS_ALLOC_GRANULARITY           =3D 9
>   #else
>   var SQ_WAVE_LDS_ALLOC_GRANULARITY           =3D 10
> @@ -185,6 +190,34 @@ var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK           =3D=
 0x04000000
>   var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT             =3D 26
>   var S_WAVE_SIZE                                     =3D 25
>
> +#if HAVE_DYNAMIC_VGPRS
> +var WAVE_MIN_NUM_DVGPRS                              =3D 16    // Define=
d by SQ_DYN_VGPR.block_size.  Assume default value for now.
> +
> +// The total VGPR count of a DVGPR wave is persisted in the wave's own s=
cratch, in a small
> +// region reserved at the front of the dynamic-VGPR backing store (ahead=
 of the dynamic
> +// VGPRs themselves).
> +//
> +// NOTE: the driver-side dynamic-VGPR scratch allocation must include th=
ese reserved bytes
> +// per lane in addition to the space for the dynamic VGPRs.
> +var S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET                =3D 0     // count =
location within the reserved region
> +var S_SAVE_DVGPR_SCRATCH_RESERVE             =3D 4     // bytes reserved=
 per lane at scratch offset 0
> +
> +// DVGPR restore-allocation bypass.  If the restore-time s_alloc_vgpr fa=
ils while a
> +// context-save is pending, the wave cannot restore its dynamic VGPRs.  =
Rather than
> +// dropping them (corruption) or spinning forever, the wave re-enters th=
e save path
> +// (L_SAVE_BYPASS) so it is re-saved and retried on a later restore when=
 pool space frees.
> +//
> +// On such a re-save the live allocation has collapsed to the minimum bl=
ock, so the save
> +// must NOT overwrite the durable scratch count (that would lose the rea=
l count and strand
> +// the dynamic VGPRs still sitting in scratch).  A freshly dispatched wa=
ve never passes
> +// through restore, so a "this is a bypass re-save" marker cannot live i=
n scratch (its first
> +// save would read it uninitialized); it is instead carried for the sing=
le trap execution in
> +// a free PC_HI bit.  On GFX12 the PC occupies PC_HI[15:0] (48-bit addre=
ss) and there are no
> +// banked-VGPR bits, so PC_HI[30:16] are free; the bit is masked off bef=
ore PC_HI is written
> +// to memory, so it is never persisted.
> +var S_SAVE_PC_HI_DVGPR_BYPASS_SHIFT          =3D 16
> +var S_SAVE_PC_HI_DVGPR_BYPASS_MASK           =3D 0x00010000
> +#endif
>   var s_restore_spi_init_lo                   =3D exec_lo
>   var s_restore_spi_init_hi                   =3D exec_hi
>   var s_restore_mem_offset                    =3D ttmp12
> @@ -196,6 +229,8 @@ var s_restore_mode                                =3D=
 ttmp7
>   var s_restore_flat_scratch                  =3D s_restore_tmp
>   var s_restore_pc_lo                         =3D ttmp0
>   var s_restore_pc_hi                         =3D ttmp1
> +// Scratch register, valid only before L_RESTORE_HWREG loads the saved P=
C.
> +var s_restore_tmp2                           =3D s_restore_pc_lo
>   var s_restore_exec_lo                               =3D ttmp4
>   var s_restore_exec_hi                               =3D ttmp5
>   var s_restore_state_priv                    =3D ttmp14
> @@ -210,6 +245,20 @@ var s_restore_ttmps_lo                           =3D=
 s_restore_tmp
>   var s_restore_ttmps_hi                              =3D s_restore_alloc=
_size
>   var s_restore_spi_init_hi_save                      =3D s_restore_exec_=
hi
>
> +#if HAVE_DYNAMIC_VGPRS
> +// Temporaries for the dynamic-VGPR restore, which runs after L_RESTORE_=
HWREG (scratch is not
> +// addressable before SCRATCH_BASE is restored).
> +var s_restore_dvgpr_tmp                              =3D s_restore_addr_=
lo
> +var s_restore_dvgpr_count                    =3D s_restore_addr_hi
> +
> +// s_restore_mem_offset (ttmp12) is dead as a scratch offset once the dy=
namic-VGPR restore
> +// finishes, so it is reused to carry the rfe-vs-resave decision to the =
end of restore:
> +// 0 =3D=3D resume the shader normally, 1 =3D=3D bypass to the save path=
 (re-save).  The dynamic-VGPR
> +// restore loop only ever leaves the register 0 or >=3D S_SAVE_DVGPR_SCR=
ATCH_RESERVE (its
> +// starting offset, which it only increments), so 1 is an unambiguous ma=
rker.
> +var s_restore_dvgpr_bypass                   =3D s_restore_mem_offset
> +#endif
> +
>   #if SAVE_TTMPS_IN_SGPR_BLOCK
>   var TTMP_SR_OFFSET_FROM_HWREG                       =3D -0x40
>   #else
> @@ -409,6 +458,15 @@ L_SAVE:
>        s_endpgm
>   L_HAVE_VGPRS:
>        s_and_b32       s_save_pc_hi, s_save_pc_hi, ADDRESS_HI32_MASK
> +#if HAVE_DYNAMIC_VGPRS
> +// Re-entry point for the DVGPR restore-allocation bypass (see L_DYN_VGP=
R_ALLOC_LOOP).
> +// On entry from restore s_save_state_priv has been populated from s_res=
tore_state_priv and
> +// the bypass marker bit (S_SAVE_PC_HI_DVGPR_BYPASS_MASK) has been set i=
n PC_HI -- this entry
> +// skips the PC_HI mask at L_HAVE_VGPRS, so the marker survives to the d=
ynamic-VGPR save,
> +// where it suppresses the durable scratch count write (the count and th=
e dynamic VGPRs are
> +// already intact in scratch from the previous save).
> +L_SAVE_BYPASS:
> +#endif
>        s_mov_b32       s_save_tmp, 0
>        s_setreg_b32    hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLA=
G_PRIV_SAVE_CONTEXT_SHIFT, 1), s_save_tmp     //clear saveCtx bit
>
> @@ -798,6 +856,9 @@ L_SAVE_VGPR_NORMAL:
>
>        // VGPR store using dw burst
>        s_mov_b32       m0, 0x4                                           =
      //VGPR initial index value =3D4
> +#if HAVE_DYNAMIC_VGPRS
> +     s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_STATUS)              =
     //save to check DYN_VGPR_EN later
> +#endif
>        s_cmp_lt_u32    m0, s_save_alloc_size
>        s_cbranch_scc0  L_SAVE_VGPR_END
>
> @@ -815,12 +876,51 @@ L_SAVE_VGPR_W32_LOOP:
>        global_store_addtid_b32 v3, [s_save_addr_lo, s_save_addr_hi] scope=
:SCOPE_SYS offset:128*3
>
>        s_add_u32       m0, m0, 4                                         =
      //next vgpr index
> +#if HAVE_DYNAMIC_VGPRS
> +     s_bitcmp1_b32   s_save_tmp, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
> +     s_cbranch_scc0  L_SAVE_FIXED_VGPR_END_LOOP_CHECK
> +     s_cmp_lt_u32    m0, WAVE_MIN_NUM_DVGPRS
> +     s_cbranch_scc0  L_SAVE_DYN_VGPR_SAVE
> +
> +L_SAVE_FIXED_VGPR_END_LOOP_CHECK:
> +#endif
>        s_add_u32       s_save_mem_offset, s_save_mem_offset, 128*4       =
      //every buffer_store_dword does 128 bytes
>        s_cmp_lt_u32    m0, s_save_alloc_size                             =
      //scc =3D (m0 < s_save_alloc_size) ? 1 : 0
>        s_cbranch_scc1  L_SAVE_VGPR_W32_LOOP                              =
      //VGPR save is complete?
> -
>        s_branch        L_SAVE_VGPR_END
>
> +#if HAVE_DYNAMIC_VGPRS
> +L_SAVE_DYN_VGPR_SAVE:
> +     s_bitcmp1_b32   s_save_pc_hi, S_SAVE_PC_HI_DVGPR_BYPASS_SHIFT
> +     s_cbranch_scc1  L_SAVE_VGPR_END
> +
> +     // Persist the total VGPR count in the reserved scratch slot (durab=
le per wave).
> +     // s_save_alloc_size holds the live total VGPR count (HW_REG_WAVE_G=
PR_ALLOC).
> +     s_mov_b32       s_save_mem_offset, S_SAVE_DVGPR_COUNT_SCRATCH_OFFSE=
T
> +     v_mov_b32       v0, s_save_alloc_size
> +     scratch_store_b32 off, v0, s_save_mem_offset offset: 0
> +
> +     // m0 already holds WAVE_MIN_NUM_DVGPRS: the fixed-VGPR loop steps =
by 4 and branches here
> +     // on the first index at or past the block boundary (must match RES=
TORE).
> +     s_mov_b32       s_save_mem_offset, S_SAVE_DVGPR_SCRATCH_RESERVE
> +
> +L_SAVE_DYN_VGPR_SAVE_LOOP:
> +     s_cmp_ge_u32    m0, s_save_alloc_size
> +     s_cbranch_scc1  L_SAVE_VGPR_END
> +
> +     v_movrels_b32   v0, v0                                             =
     //v0 =3D v[0+m0]
> +     v_movrels_b32   v1, v1                                             =
     //v1 =3D v[1+m0]
> +     v_movrels_b32   v2, v2                                             =
     //v2 =3D v[2+m0]
> +     v_movrels_b32   v3, v3                                             =
     //v3 =3D v[3+m0]
> +     scratch_store_b32 off, v0, s_save_mem_offset offset: 0
> +     scratch_store_b32 off, v1, s_save_mem_offset offset: 4
> +     scratch_store_b32 off, v2, s_save_mem_offset offset: 8
> +     scratch_store_b32 off, v3, s_save_mem_offset offset: 12
> +     s_add_u32       m0, m0, 4
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, 16
> +     s_branch        L_SAVE_DYN_VGPR_SAVE_LOOP
> +#endif
> +
>   L_SAVE_VGPR_WAVE64:
>        // VGPR store using dw burst
>        s_mov_b32       m0, 0x4                                           =
      //VGPR initial index value =3D4
> @@ -934,9 +1034,23 @@ L_RESTORE_VGPR:
>   L_ENABLE_RESTORE_VGPR_EXEC_HI:
>        s_mov_b32       exec_hi, 0xFFFFFFFF
>   L_RESTORE_VGPR_NORMAL:
> +#if HAVE_DYNAMIC_VGPRS
> +     // For DVGPR waves this loop restores only the fixed VGPR block, so=
 cap the loop bound at
> +     // WAVE_MIN_NUM_DVGPRS rather than taking the live GPR_ALLOC size. =
 The dynamic VGPRs are
> +     // restored later, from scratch, once SCRATCH_BASE has been restore=
d (it is not yet
> +     // restored at this point) and their count is known.
> +     s_getreg_b32    s_restore_tmp2, hwreg(HW_REG_WAVE_STATUS)
> +     s_bitcmp1_b32   s_restore_tmp2, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
> +     s_cbranch_scc0  L_RESTORE_ALLOC_SIZE_FROM_HW  // Not DVGPR, use HW =
register
> +     s_mov_b32       s_restore_alloc_size, WAVE_MIN_NUM_DVGPRS
> +     s_branch        L_RESTORE_ALLOC_SIZE_DONE

I am not sure we need to distinguish here, do we?  According to the
manual[1] states "Waves in dynamic VGPR mode are initialized with one
VGPR-block allocated" (section 3.3.3).  Therefore, I?expect that if the
wave is using DVGPRs, on restore it is created with 1 block, so reading
GPR_ALLOC would give us the same result.

Unless I?missed someting, it seems we could just remove this hunk (and
the definition of s_restore_tmp2), and have the same behaviour.  Am I
missing something?

[1] https://docs.amd.com/v/u/en-US/rdna4-instruction-set-architecture

Because here, if the wave has dVGPR, it saved as 32 VGPRs + the rest on src=
ratch memory. During restore, we would see 32 as the alloc size even there =
should be
more dVGPR. Therefore, we have a condition here to resolve which one is whi=
ch. Is it a wave without enabling dVGPR, or a wave with dVGPR and we need t=
o get
The actual allocation size.

> +
> +L_RESTORE_ALLOC_SIZE_FROM_HW:
> +#endif
>        s_getreg_b32    s_restore_alloc_size, hwreg(HW_REG_WAVE_GPR_ALLOC,=
SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
>        s_add_u32       s_restore_alloc_size, s_restore_alloc_size, 1
>        s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size, 2     =
      //Number of VGPRs =3D (vgpr_size + 1) * 4    (non-zero value)
> +L_RESTORE_ALLOC_SIZE_DONE:

If this remains (see previous comment), this label might be guarded by
HAVE_DYNAMIC_VGPRS (not strictly necessary, but would remain consistent
with the rest of the patch).
Will resolve this


>        //determine it is wave32 or wave64
>        s_lshr_b32      m0, s_restore_size, S_WAVE_SIZE
>        s_and_b32       m0, m0, 1
> @@ -1181,6 +1295,74 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
>        s_setreg_b32    hwreg(HW_REG_WAVE_SCHED_MODE), s_restore_tmp
>   #endif
>
> +#if HAVE_DYNAMIC_VGPRS
> +     // Default: resume normally after restore (see s_restore_dvgpr_bypa=
ss).
> +     s_mov_b32       s_restore_dvgpr_bypass, 0
> +
> +     // Check if dynamic VGPR is enabled
> +     s_getreg_b32    s_restore_dvgpr_tmp, hwreg(HW_REG_WAVE_STATUS)
> +     s_bitcmp1_b32   s_restore_dvgpr_tmp, SQ_WAVE_STATUS_DYN_VGPR_EN_SHI=
FT
> +     s_cbranch_scc0  L_SKIP_DYN_VGPR_RESTORE
> +
> +     // Total VGPR count persisted in the reserved scratch slot at preem=
pt (see
> +     // L_SAVE_DYN_VGPR_SAVE).
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
> +     s_mov_b32       s_restore_mem_offset, S_SAVE_DVGPR_COUNT_SCRATCH_OF=
FSET
> +     scratch_load_b32 v0, off, s_restore_mem_offset offset: 0
> +     s_wait_loadcnt  0
> +     v_readlane_b32  s_restore_dvgpr_count, v0, 0
> +
> +L_DYN_VGPR_ALLOC_LOOP:
> +     // s_alloc_vgpr modifies its operand, so give it a fresh copy of th=
e count each attempt.

Does it?  It modifies SCC, but I do not think it modifies its operand.
Good catch, will resolve this.

> +     s_mov_b32       s_restore_dvgpr_tmp, s_restore_dvgpr_count
> +     s_alloc_vgpr    s_restore_dvgpr_tmp
> +     s_cbranch_scc1  L_DYN_VGPR_RESTORE                      // allocati=
on succeeded
> +     // Allocation failed.  Keep retrying unless a context-save is pendi=
ng.
> +     s_getreg_b32    s_restore_dvgpr_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PR=
IV)
> +     s_and_b32       s_restore_dvgpr_tmp, s_restore_dvgpr_tmp, SQ_WAVE_E=
XCP_FLAG_PRIV_SAVE_CONTEXT_MASK
> +     s_sleep         0x10
> +     s_cbranch_scc0  L_DYN_VGPR_ALLOC_LOOP                   // no save =
pending -> retry
> +     // A context-save is pending and there is still no room: bypass to =
the save path so
> +     // this wave is re-saved and retried on a later restore. The re-sav=
e does write
> +     // the fixed VGPRs back from registers, so v[0:3] must be put back =
first.
> +     s_mov_b32       s_restore_dvgpr_bypass, 1               // re-save =
instead of rfe
> +     s_branch        L_DYN_VGPR_RELOAD_FIXED
> +
> +L_DYN_VGPR_RESTORE:
> +     // Enable all lanes for the v_movreld instructions below.  This pat=
h is wave32 only, so
> +     // exec_lo is the entire mask.
> +     s_mov_b32       exec_lo, 0xFFFFFFFF

Can exec_lo be anything else at this point?  It was set to this value
before reading the vgpr alloc size, which was needed to re-allocate.
Removing unnecessary register value set

> +     // Start at the first dynamic VGPR (must match SAVE).
> +     s_mov_b32       m0, WAVE_MIN_NUM_DVGPRS
> +     s_mov_b32       s_restore_mem_offset, S_SAVE_DVGPR_SCRATCH_RESERVE
> +     s_cmp_lt_u32    m0, s_restore_dvgpr_count
> +     s_cbranch_scc0  L_DYN_VGPR_RELOAD_FIXED
> +
> +L_DYN_VGPR_RESTORE_LOOP:
> +     scratch_load_b32 v0, off, s_restore_mem_offset offset: 0
> +     scratch_load_b32 v1, off, s_restore_mem_offset offset: 4
> +     scratch_load_b32 v2, off, s_restore_mem_offset offset: 8
> +     scratch_load_b32 v3, off, s_restore_mem_offset offset: 12
> +     s_wait_loadcnt  0
> +     v_movreld_b32   v0, v0
> +     v_movreld_b32   v1, v1
> +     v_movreld_b32   v2, v2
> +     v_movreld_b32   v3, v3
> +     s_add_u32       m0, m0, 4
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 16
> +     s_cmp_lt_u32    m0, s_restore_dvgpr_count
> +     s_cbranch_scc1  L_DYN_VGPR_RESTORE_LOOP
> +
> +     // Put back the v[0:3] borrowed above as scratch-load staging.  The=
 fixed VGPR block starts
> +     // at CWSR offset 0, DVGPR implies wave32, hence the 128-byte strid=
e.
> +L_DYN_VGPR_RELOAD_FIXED:
> +     global_load_addtid_b32  v0, [s_restore_base_addr_lo, s_restore_base=
_addr_hi] scope:SCOPE_SYS
> +     global_load_addtid_b32  v1, [s_restore_base_addr_lo, s_restore_base=
_addr_hi] scope:SCOPE_SYS offset:128
> +     global_load_addtid_b32  v2, [s_restore_base_addr_lo, s_restore_base=
_addr_hi] scope:SCOPE_SYS offset:128*2
> +     global_load_addtid_b32  v3, [s_restore_base_addr_lo, s_restore_base=
_addr_hi] scope:SCOPE_SYS offset:128*3
> +     s_wait_idle

Could as well be `s_wait_loadcnt 0`, couldn't it?
Yes, will resolve it.

> +L_SKIP_DYN_VGPR_RESTORE:
> +#endif
>        s_mov_b32       m0, s_restore_m0
>        s_mov_b32       exec_lo, s_restore_exec_lo
>        s_mov_b32       exec_hi, s_restore_exec_hi
> @@ -1220,6 +1402,14 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
>        s_and_b64       exec, exec, exec                                  =
      // Restore STATUS.EXECZ, not writable by s_setreg_b32
>        s_and_b64       vcc, vcc, vcc                                     =
      // Restore STATUS.VCCZ, not writable by s_setreg_b32
>
> +#if HAVE_DYNAMIC_VGPRS
> +     // DVGPR restore-allocation bypass: if dynamic VGPRs could not be a=
llocated while a
> +     // context-save was pending (flagged in s_restore_dvgpr_bypass =3D=
=3D 1 by
> +     // L_DYN_VGPR_ALLOC_LOOP), re-enter the save path instead of resumi=
ng the shader.
> +     s_cmp_eq_u32    s_restore_dvgpr_bypass, 1
> +     s_cbranch_scc1  L_DYN_VGPR_BYPASS_RESAVE
> +#endif
> +
>   #if RELAXED_SCHEDULING_IN_TRAP
>        // Assume relaxed scheduling mode after this point.
>        restore_sched_mode(s_restore_tmp)
> @@ -1239,6 +1429,16 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
>
>        s_rfe_b64       s_restore_pc_lo                                   =
      //Return to the main shader program and resume execution
>
> +#if HAVE_DYNAMIC_VGPRS
> +L_DYN_VGPR_BYPASS_RESAVE:
> +     // Out of line so the resume path above ends at s_rfe_b64 with SCC =
untouched.  Hand the
> +     // save path the state_priv it would otherwise have read at trap en=
try, and set the
> +     // transient PC_HI bypass marker so the save skips the durable scra=
tch count write.
> +     s_mov_b32       s_save_state_priv, s_restore_state_priv
> +     s_or_b32        s_save_pc_hi, s_save_pc_hi, S_SAVE_PC_HI_DVGPR_BYPA=
SS_MASK
> +     s_branch        L_SAVE_BYPASS
> +#endif

I am not sure I?follow why this needs to be ou of line.  SCC was touched
before deciding if we want to jump here or not.  Feels the previous hunk
could be

   s_cmp_eq_u32   s_restore_dvgpr_bypass, 1
   s_cbranch_scc0 L_NO_DVGPR_RESAVE

   // set state as expected for save
   s_mov_b32    s_save_state_priv, s_restore_state_priv
   s_or_b32     s_save_pc_hi, s_save_pc_hi, S_SAVE_PC_HI_DVGPR_BYPASS_MASK
   s_branch     L_SAVE_BYPASS

L_NO_DVGPR_RESAVE:
   ...
   // Here we do restore SCC
   s_setreg_b32    hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv


Best,
Lancelot.

Right, let me address that.

> +
>   L_END_PGM:
>        // Make sure that no wave of the group/cluster can exit the trap h=
andler
>        // before the group/cluster barrier state is saved.
> @@ -1271,6 +1471,18 @@ function write_12sgpr_to_v2(s)
>   end
>
>   function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)
> +#if HAVE_DYNAMIC_VGPRS
> +     // DVGPR waves (wave32 only) keep only the fixed VGPR block (WAVE_M=
IN_NUM_DVGPRS) in
> +     // the CWSR buffer; the dynamic VGPRs live in scratch.  Every CWSR =
region placed after
> +     // the VGPR block (SGPR/HWREG/LDS/TTMP) is sized off the VGPR block=
, so centralize the
> +     // fixed-block adjustment here to keep every offset consistent.
> +     s_getreg_b32    s_vgpr_size_byte, hwreg(HW_REG_WAVE_STATUS)
> +     s_bitcmp1_b32   s_vgpr_size_byte, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
> +     s_cbranch_scc0  L_GET_VGPR_SIZE_NORMAL
> +     s_mov_b32       s_vgpr_size_byte, (WAVE_MIN_NUM_DVGPRS * 128)      =
     //16 fixed VGPRs, wave32
> +     s_branch        L_GET_VGPR_SIZE_DONE
> +L_GET_VGPR_SIZE_NORMAL:
> +#endif
>        s_getreg_b32    s_vgpr_size_byte, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_W=
AVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
>        s_add_u32       s_vgpr_size_byte, s_vgpr_size_byte, 1
>        s_bitcmp1_b32   s_size, S_WAVE_SIZE
> @@ -1280,6 +1492,9 @@ function get_vgpr_size_bytes(s_vgpr_size_byte, s_si=
ze)
>   L_ENABLE_SHIFT_W64:
>        s_lshl_b32      s_vgpr_size_byte, s_vgpr_size_byte, (2+8)         =
      //Number of VGPRs =3D (vgpr_size + 1) * 4 * 64 * 4   (non-zero value)
>   L_SHIFT_DONE:
> +#if HAVE_DYNAMIC_VGPRS
> +L_GET_VGPR_SIZE_DONE:
> +#endif
>   end
>
>   function get_sgpr_size_bytes


--_000_SA1PR12MB999254C203B930C1E9D9DCEDE09F842SA1PR12MB999254_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Hi Lancelot,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I put some comments regarding your review. I will update the change and sen=
d out another review later. Thank you for taking the time for reviewing the=
 code!</div>
<div><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Siwei</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Six, Lancelot &lt;Lancelot.Six@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 17, 2026 6:06 PM<br>
<b>To:</b> He, Siwei &lt;Siwei.He@amd.com&gt;; amd-gfx@lists.freedesktop.or=
g &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Cornwall, Jay &lt;Jay.Cornwall@amd.com&gt;; Kim, Jonathan &lt;Jo=
nathan.Kim@amd.com&gt;; Indic, Vladimir &lt;Vladimir.Indic@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: add dynamic VGPR save/restore to th=
e gfx12 trap handler
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Hi Siwei,<br>
<br>
Thanks for working on this.<br>
<br>
Comments included inline.<br>
<br>
On 14/08/2026 14:57, Siwei He wrote:<br>
&gt; A gfx12 wave using dynamic VGPRs is launched with a fixed 16-VGPR bloc=
k<br>
&gt; and allocates the rest from a shared pool with s_alloc_vgpr.<br>
&gt;&nbsp;&nbsp; - the fixed block (WAVE_MIN_NUM_DVGPRS, 16 VGPRs) continue=
s to go to<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; the CWSR buffer;<br>
&gt;&nbsp;&nbsp; - the dynamic VGPRs go to the wave's scratch, which is dur=
able per wave<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; and therefore survives a restore that cannot r=
eallocate them.<br>
&gt;<br>
&gt; Persist wave's total VGPR count in a 4-byte per-lane<br>
&gt; slot reserved at the front of the dynamic-VGPR scratch region, read ba=
ck<br>
&gt; through a VGPR lane since scratch is per lane.<br>
&gt;<br>
&gt; Restore reallocates with s_alloc_vgpr once SCRATCH_BASE is available a=
nd<br>
&gt; retries while the pool is full. If a context save becomes pending whil=
e<br>
&gt; the allocation still cannot be satisfied, waiting would block the very=
<br>
&gt; preemption that frees pool space, so the wave leaves its dynamic VGPRs=
<br>
&gt; in scratch, completes the restore without resuming the shader, and<br>
&gt; re-enters the save path at L_SAVE_BYPASS to be retried on a later<br>
&gt; restore. Such a re-save must not overwrite the persisted count.<br>
&gt; The live allocation has collapsed to the fixed block, and recording th=
at would<br>
&gt; lose the real count and strand the dynamic VGPRs in scratch. Signal th=
e<br>
&gt; condition in PC_HI bit 1.<br>
<br>
Should this be PC_HI bit 16?</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><span style=3D"col=
or: rgb(15, 92, 26);">Yes, it should be bit 16!<br>
</span><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h&nbsp;&nbsp;&nbs=
p; | 356 +++++++++++-------<br>
&gt;&nbsp;&nbsp; .../amd/amdkfd/cwsr_trap_handler_gfx12.asm&nbsp;&nbsp;&nbs=
p; | 217 ++++++++++-<br>
&gt;&nbsp;&nbsp; 2 files changed, 432 insertions(+), 141 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/=
gpu/drm/amd/amdkfd/cwsr_trap_handler.h<br>
&gt; index 54fa76f374c9..259b2a4a1940 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h<br>
&gt; @@ -3644,7 +3644,7 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] =
=3D {<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; static const uint32_t cwsr_trap_gfx12_hex[] =3D {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0xbfa00239,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0xbfa00273,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb0804009, 0xb8eef81a,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf880000, 0xb980081a,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xb8f8f804,<br>
&gt; @@ -3707,7 +3707,10 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e000280, 0xbefe007a,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff007b, 0xb8fb0742,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x847b997b, 0xb8fa3b05,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x847b997b, 0xb8faf802,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9e7a, 0xbfa10003,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbefa00ff, 0x00000800,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00007, 0xb8fa3b05,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807a817a, 0xbf0d997b,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x847a897a,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x847a8a7a,<br>
&gt; @@ -3748,6 +3751,9 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4074, 0x010c0000,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00020000, 0xee0a4074,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x018c0000, 0x00030000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f0f802, 0xbf0d9e70,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbef000ff,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000800, 0xbfa00007,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f03b05, 0x80708170,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9973, 0xbfa20002,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84708970, 0xbfa00001,<br>
&gt; @@ -3790,7 +3796,10 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0080, 0x80767074,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a4076,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x010c0000, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe00c1, 0xb8f03b05,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe00c1, 0xb8f0f802,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9e70, 0xbfa10003,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbef000ff, 0x00000800,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00007, 0xb8f03b05,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80708170, 0xbf0d9973,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x84708970,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x84708a70,<br>
&gt; @@ -3859,9 +3868,12 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06817d, 0xbfa20002,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0080, 0xbfa00001,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff00c1, 0xb8fb4306,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7bc17b, 0xbfa10042,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7bc17b, 0xbfa10048,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7aff6d, 0x80000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa1003f, 0x847b897b,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10045, 0x847b897b,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f0f802, 0xbf0d9e70,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbef000ff,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000800, 0xbfa00007,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f03b05, 0x80708170,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9973, 0xbfa20002,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84708970, 0xbfa00001,<br>
&gt; @@ -3902,20 +3914,37 @@ static const uint32_t cwsr_trap_gfx12_hex[] =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fb3b05, 0x807b817b,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x847b827b, 0x857d9973,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7d817d, 0xbf06817d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2001b, 0xbefd0084,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a7b7d, 0xbfa10032,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x7e008700, 0x7e028701,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x7e048702, 0x7e068703,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80767074, 0x82778075,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xee0a4076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x008c0000, 0x00008000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x010c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000, 0xee0a4076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x018c0000, 0x00018000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x807d847d, 0x8070ff70,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000200, 0xbf0a7b7d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffe9, 0xbfa0001a,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2003d, 0xbefd0084,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb8faf802, 0xbf0a7b7d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10053, 0x7e008700,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e028701, 0x7e048702,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e068703, 0x80767074,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a4076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x008c0000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00008000, 0xee0a4076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x010c0000, 0x00010000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x018c0000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00018000, 0x807d847d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9e7a, 0xbfa10002,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a907d, 0xbfa10005,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x8070ff70, 0x00000200,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a7b7d, 0xbfa2ffe5,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00037, 0xbf0d906d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20035, 0xbef00080,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e00027b, 0xed068070,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbef00084, 0xbf097b7d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2002d, 0x7e008700,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e028701, 0x7e048702,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e068703, 0xed068070,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xed068070, 0x00800000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000400, 0xed068070,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x01000000, 0x00000800,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xed068070, 0x01800000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000c00, 0x807d847d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x80709070, 0xbfa0ffeb,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0084, 0xbf0a7b7d,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10017, 0x7e008700,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e028701, 0x7e048702,<br>
&gt; @@ -3929,17 +3958,20 @@ static const uint32_t cwsr_trap_gfx12_hex[] =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00030000, 0x807d847d,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8070ff70, 0x00000400,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a7b7d, 0xbfa2ffe9,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0014c, 0xbef4007e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa001ab, 0xbef4007e,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b75ff7f, 0x0000ffff,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbef1007f, 0xb8f20742,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84729972, 0x8b6eff7f,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x04000000, 0xbfa10044,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x04000000, 0xbfa1004a,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe00c1, 0x857d9972,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7d817d, 0xbf06817d,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0xbeff0080,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0xbeff00c1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8ef4306, 0x8b6fc16f,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10039, 0x846f896f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa1003f, 0x846f896f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f8f802, 0xbf0d9e78,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbef800ff,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000800, 0xbfa00007,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f83b05, 0x80788178,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9972, 0xbfa20002,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84788978, 0xbfa00001,<br>
&gt; @@ -3972,134 +4004,178 @@ static const uint32_t cwsr_trap_gfx12_hex[] =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857d9972, 0x8b7d817d,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06817d, 0xbfa20002,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0080, 0xbfa00001,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff00c1, 0xb8ef3b05,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x806f816f, 0x846f826f,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x857d9972, 0x8b7d817d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06817d, 0xbfa2002c,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbeee0078, 0x8078ff78,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000200, 0xbefd0084,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80767874, 0x82778075,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xee0a0076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0001, 0x00008000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0002,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000, 0xee0a0076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0003, 0x00018000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x7e008500,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x7e028501, 0x7e048502,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x7e068503, 0x807d847d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff00c1, 0xb8ecf802,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9e6c, 0xbfa10002,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbeef0090, 0xbfa00003,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb8ef3b05, 0x806f816f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x846f826f, 0x857d9972,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7d817d, 0xbf06817d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2002c, 0xbeee0078,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8078ff78, 0x00000200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a6f7d, 0xbfa2ffe8,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80766e74, 0x82778075,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xee0a0076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0001, 0x00008000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0002,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000, 0xee0a0076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0003, 0x00018000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xbfa0002d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbeee0078, 0x8078ff78,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000400, 0xbefd0084,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a6f7d, 0xbfa10018,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80767874, 0x82778075,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xee0a0076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0001, 0x00010000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0002,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00020000, 0xee0a0076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0003, 0x00030000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x7e008500,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x7e028501, 0x7e048502,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x7e068503, 0x807d847d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0084, 0x80767874,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a0076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0001,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00008000, 0xee0a0076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0002, 0x00010000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0003,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00018000, 0xbf8a0000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e008500, 0x7e028501,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e048502, 0x7e068503,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x807d847d, 0x8078ff78,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000200, 0xbf0a6f7d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffe8, 0x80766e74,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a0076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0001,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00008000, 0xee0a0076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0002, 0x00010000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0003,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00018000, 0xbf8a0000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0002d, 0xbeee0078,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8078ff78, 0x00000400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a6f7d, 0xbfa2ffe8,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80766e74, 0x82778075,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xee0a0076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0001, 0x00010000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0002,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00020000, 0xee0a0076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0003, 0x00030000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb8f83b05,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80788178, 0xbf0d9972,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x84788978,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x84788a78,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x8078ff78, 0x00000200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80f8ff78, 0x00000060,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80767874, 0x82778075,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd00ff, 0x0000006c,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf460403b, 0xf8000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x80fd847d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf800000, 0xbe804300,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbe824302, 0x80f6a076,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x82f78077, 0xf460603b,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0084, 0xbf0a6f7d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10018, 0x80767874,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a0076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0001,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000, 0xee0a0076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0002, 0x00020000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0003,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00030000, 0xbf8a0000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e008500, 0x7e028501,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e048502, 0x7e068503,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x807d847d, 0x8078ff78,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000400, 0xbf0a6f7d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffe8, 0x80766e74,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a0076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0001,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000, 0xee0a0076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0002, 0x00020000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0003,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00030000, 0xbf8a0000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f8f802, 0xbf0d9e78,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbef800ff,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000800, 0xbfa00007,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f83b05, 0x80788178,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9972, 0xbfa20002,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x84788978, 0xbfa00001,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x84788a78, 0x8078ff78,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000200, 0x80f8ff78,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000060, 0x80767874,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xbefd00ff,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x0000006c, 0xf460403b,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000000, 0xbf8a0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80fd887d, 0xbf800000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x80fd847d, 0xbf800000,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804300, 0xbe824302,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbe844304, 0xbe864306,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80f6c076, 0x82f78077,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf460803b, 0xf8000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x80fd907d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x80f6a076, 0x82f78077,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf460603b, 0xf8000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x80fd887d,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf800000, 0xbe804300,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe824302, 0xbe844304,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbe864306, 0xbe884308,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbe8a430a, 0xbe8c430c,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbe8e430e, 0xbf06807d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa1ffef, 0xb980f801,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xb8f83b05,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80788178, 0xbf0d9972,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x84788978,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x84788a78,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x8078ff78, 0x00000200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x80767874, 0x82778075,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0071, 0xf4601bfb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000000, 0xf4601b3b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000004, 0xf4601b7b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000008, 0xf4601c3b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf800000c, 0xf4601c7b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000010, 0xf4601ebb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000014, 0xf4601efb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000018, 0xf4601e7b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf800001c, 0xf4601cfb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000020, 0xf4601bbb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000024, 0xbf8a0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xb96ef814, 0xf4601bbb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000028, 0xbf8a0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xb96ef815, 0xf4601bbb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf800002c, 0xbf8a0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xb96ef812, 0xf4601bbb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000030, 0xbf8a0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xb96ef813, 0x8b6eff7f,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x04000000, 0xbfa1000b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000038,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xbf0d806e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10006, 0x856e906e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6e6e6e, 0xbfa10003,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804ec1, 0x816ec16e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0fffb, 0xbefd006f,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe0070, 0xbeff0071,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xb97b2011, 0x857b867b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xb97b0191, 0x857b827b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xb97bba11, 0xb973f801,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xb8ee3b05, 0x806e816e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbe864306, 0x80f6c076,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x82f78077, 0xf460803b,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000000, 0xbf8a0000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x80fd907d, 0xbf800000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804300, 0xbe824302,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbe844304, 0xbe864306,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbe884308, 0xbe8a430a,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbe8c430c, 0xbe8e430e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06807d, 0xbfa1ffef,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb980f801, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f8f802, 0xbf0d9e78,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbef800ff,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000800, 0xbfa00007,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f83b05, 0x80788178,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9972, 0xbfa20002,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x846e896e, 0xbfa00001,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x846e8a6e, 0x806eff6e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x00000240, 0x806e746e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x826f8075, 0xf4605c37,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000010, 0xf4605d37,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000020, 0xf4601e77,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000034, 0xbf8a0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6dff6d, 0x0000ffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x8bfe7e7e, 0x8bea6a6a,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x936eff77, 0x0002001a,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xb96ef81a, 0xb97af804,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x84788978, 0xbfa00001,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x84788a78, 0x8078ff78,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000200, 0x80767874,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xbeff0071,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bfb, 0xf8000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601b3b, 0xf8000004,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601b7b, 0xf8000008,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601c3b, 0xf800000c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601c7b, 0xf8000010,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601ebb, 0xf8000014,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601efb, 0xf8000018,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601e7b, 0xf800001c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601cfb, 0xf8000020,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000024,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb96ef814,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000028,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb96ef815,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf800002c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb96ef812,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000030,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb96ef813,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6eff7f, 0x04000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa1000b, 0xf4601bbb,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000038, 0xbf8a0000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d806e, 0xbfa10006,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x856e906e, 0x8b6e6e6e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbe804ec1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x816ec16e, 0xbfa0fffb,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbef80080, 0xb8f6f802,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9e76, 0xbfa10038,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe00c1, 0xbef80080,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xed050078, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xbfc00000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xd7600077, 0x00010100,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbef60077, 0xbe805376,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20006, 0xb8f6f811,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76a076, 0xbf830010,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa1fff9, 0xbef80081,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0001a, 0xbefe00c1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0090, 0xbef80084,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a777d, 0xbfa10015,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xed050078, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xed050078,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001, 0x00000400,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xed050078, 0x00000002,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000800, 0xed050078,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00000003, 0x00000c00,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc00000, 0x7e008500,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e028501, 0x7e048502,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7e068503, 0x807d847d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x80789078, 0xbf0a777d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffeb, 0xee0a0074,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0074, 0x000c0001,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00008000, 0xee0a0074,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0002, 0x00010000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0074, 0x000c0003,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00018000, 0xbf8a0000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd006f, 0xbefe0070,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0071, 0xb97b2011,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x857b867b, 0xb97b0191,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x857b827b, 0xb97bba11,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb973f801, 0xb8eef802,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9e6e, 0xbfa10003,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbeee00ff, 0x00000800,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00007, 0xb8ee3b05,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x806e816e, 0xbf0d9972,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x846e896e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x846e8a6e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x806eff6e, 0x00000240,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x806e746e, 0x826f8075,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4605c37, 0xf8000010,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4605d37, 0xf8000020,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601e77, 0xf8000034,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x8b6dff6d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x0000ffff, 0x8bfe7e7e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x8bea6a6a, 0xbf068178,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20007, 0x936eff77,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x0002001a, 0xb96ef81a,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xb97af804, 0xbe804ec2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffe, 0xbe804a6c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbef8007a, 0x8c6dff6d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000, 0xbfa0fc47,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804ec2, 0xbf94fffe,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804a6c, 0xbe804ec2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffe, 0xbfb10000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0xbfb10000, 0xbf9f0000,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0x00000000,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; static const uint32_t cwsr_trap_gfx9_5_0_hex[] =3D {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/=
drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm<br>
&gt; index d38ff404277b..355b5175f141 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm<br>
&gt; @@ -38,6 +38,7 @@<br>
&gt;&nbsp;&nbsp; #define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY =
=3D=3D CHIP_GC_12_0_3)<br>
&gt;&nbsp;&nbsp; #define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY =3D=3D CHI=
P_GFX12)<br>
&gt;&nbsp;&nbsp; #define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY =3D=3D CHIP_GC=
_12_0_3)<br>
&gt; +#define HAVE_DYNAMIC_VGPRS (ASIC_FAMILY =3D=3D CHIP_GFX12)<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #define SINGLE_STEP_MISSED_WORKAROUND 1&nbsp;&nbsp;&nbsp;&=
nbsp; //workaround for lost TRAP_AFTER_INST exception when SAVECTX raised<b=
r>
&gt;&nbsp;&nbsp; #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY =3D=3D CHIP_GFX=
12)<br>
&gt; @@ -60,16 +61,20 @@ var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 15<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_STATUS_WAVE64_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 29<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_STATUS_WAVE64_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D 1<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_STATUS_NO_VGPRS_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 24<br>
&gt; +var SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; =3D 30<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_STATUS_IN_WG_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D 11<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK&nbsp;&nbsp;&nbsp;=
 =3D SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK<br=
>
&gt;&nbsp;&nbsp; var S_SAVE_PC_HI_TRAP_ID_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xF0000000<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 12=
<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D 9<br>
&gt; +var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; =3D 0xFF000<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 8<=
br>
&gt;&nbsp;&nbsp; var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 12<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #if ASIC_FAMILY &lt; CHIP_GC_12_0_3<br>
&gt; +var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT =3D 24<br>
&gt; +var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE&nbsp; =3D 4<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_LDS_ALLOC_GRANULARITY&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 9<br>
&gt;&nbsp;&nbsp; #else<br>
&gt;&nbsp;&nbsp; var SQ_WAVE_LDS_ALLOC_GRANULARITY&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 10<br>
&gt; @@ -185,6 +190,34 @@ var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x04000000<br>
&gt;&nbsp;&nbsp; var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 26<br>
&gt;&nbsp;&nbsp; var S_WAVE_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D 25<br>
&gt;&nbsp;&nbsp;<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +var WAVE_MIN_NUM_DVGPRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 16&nbsp;&nbsp;&nb=
sp; // Defined by SQ_DYN_VGPR.block_size.&nbsp; Assume default value for no=
w.<br>
&gt; +<br>
&gt; +// The total VGPR count of a DVGPR wave is persisted in the wave's ow=
n scratch, in a small<br>
&gt; +// region reserved at the front of the dynamic-VGPR backing store (ah=
ead of the dynamic<br>
&gt; +// VGPRs themselves).<br>
&gt; +//<br>
&gt; +// NOTE: the driver-side dynamic-VGPR scratch allocation must include=
 these reserved bytes<br>
&gt; +// per lane in addition to the space for the dynamic VGPRs.<br>
&gt; +var S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0&nbsp;&nbsp=
;&nbsp;&nbsp; // count location within the reserved region<br>
&gt; +var S_SAVE_DVGPR_SCRATCH_RESERVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 4&nbsp;&nbsp;&nbsp;&nbsp; // bytes =
reserved per lane at scratch offset 0<br>
&gt; +<br>
&gt; +// DVGPR restore-allocation bypass.&nbsp; If the restore-time s_alloc=
_vgpr fails while a<br>
&gt; +// context-save is pending, the wave cannot restore its dynamic VGPRs=
.&nbsp; Rather than<br>
&gt; +// dropping them (corruption) or spinning forever, the wave re-enters=
 the save path<br>
&gt; +// (L_SAVE_BYPASS) so it is re-saved and retried on a later restore w=
hen pool space frees.<br>
&gt; +//<br>
&gt; +// On such a re-save the live allocation has collapsed to the minimum=
 block, so the save<br>
&gt; +// must NOT overwrite the durable scratch count (that would lose the =
real count and strand<br>
&gt; +// the dynamic VGPRs still sitting in scratch).&nbsp; A freshly dispa=
tched wave never passes<br>
&gt; +// through restore, so a &quot;this is a bypass re-save&quot; marker =
cannot live in scratch (its first<br>
&gt; +// save would read it uninitialized); it is instead carried for the s=
ingle trap execution in<br>
&gt; +// a free PC_HI bit.&nbsp; On GFX12 the PC occupies PC_HI[15:0] (48-b=
it address) and there are no<br>
&gt; +// banked-VGPR bits, so PC_HI[30:16] are free; the bit is masked off =
before PC_HI is written<br>
&gt; +// to memory, so it is never persisted.<br>
&gt; +var S_SAVE_PC_HI_DVGPR_BYPASS_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =3D 16<br>
&gt; +var S_SAVE_PC_HI_DVGPR_BYPASS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00010000<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp; var s_restore_spi_init_lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D exec_lo<br>
&gt;&nbsp;&nbsp; var s_restore_spi_init_hi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D exec_hi<br>
&gt;&nbsp;&nbsp; var s_restore_mem_offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =3D ttmp12<br>
&gt; @@ -196,6 +229,8 @@ var s_restore_mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D ttmp7<br>
&gt;&nbsp;&nbsp; var s_restore_flat_scratch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
s_restore_tmp<br>
&gt;&nbsp;&nbsp; var s_restore_pc_lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D ttmp0<br>
&gt;&nbsp;&nbsp; var s_restore_pc_hi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D ttmp1<br>
&gt; +// Scratch register, valid only before L_RESTORE_HWREG loads the save=
d PC.<br>
&gt; +var s_restore_tmp2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D s_restore_pc_lo<br>
&gt;&nbsp;&nbsp; var s_restore_exec_lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D tt=
mp4<br>
&gt;&nbsp;&nbsp; var s_restore_exec_hi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D tt=
mp5<br>
&gt;&nbsp;&nbsp; var s_restore_state_priv&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =3D ttmp14<br>
&gt; @@ -210,6 +245,20 @@ var s_restore_ttmps_lo&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D s_restore_tmp<br=
>
&gt;&nbsp;&nbsp; var s_restore_ttmps_hi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D s_resto=
re_alloc_size<br>
&gt;&nbsp;&nbsp; var s_restore_spi_init_hi_save&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D s_restore_exec_hi<br>
&gt;&nbsp;&nbsp;<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +// Temporaries for the dynamic-VGPR restore, which runs after L_RESTO=
RE_HWREG (scratch is not<br>
&gt; +// addressable before SCRATCH_BASE is restored).<br>
&gt; +var s_restore_dvgpr_tmp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D s_restore_addr_lo=
<br>
&gt; +var s_restore_dvgpr_count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
s_restore_addr_hi<br>
&gt; +<br>
&gt; +// s_restore_mem_offset (ttmp12) is dead as a scratch offset once the=
 dynamic-VGPR restore<br>
&gt; +// finishes, so it is reused to carry the rfe-vs-resave decision to t=
he end of restore:<br>
&gt; +// 0 =3D=3D resume the shader normally, 1 =3D=3D bypass to the save p=
ath (re-save).&nbsp; The dynamic-VGPR<br>
&gt; +// restore loop only ever leaves the register 0 or &gt;=3D S_SAVE_DVG=
PR_SCRATCH_RESERVE (its<br>
&gt; +// starting offset, which it only increments), so 1 is an unambiguous=
 marker.<br>
&gt; +var s_restore_dvgpr_bypass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D s_res=
tore_mem_offset<br>
&gt; +#endif<br>
&gt; +<br>
&gt;&nbsp;&nbsp; #if SAVE_TTMPS_IN_SGPR_BLOCK<br>
&gt;&nbsp;&nbsp; var TTMP_SR_OFFSET_FROM_HWREG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -0x40<br>
&gt;&nbsp;&nbsp; #else<br>
&gt; @@ -409,6 +458,15 @@ L_SAVE:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_endpgm<br>
&gt;&nbsp;&nbsp; L_HAVE_VGPRS:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; s_save_pc_hi, s_save_pc_hi, ADDRESS_HI32_MASK<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +// Re-entry point for the DVGPR restore-allocation bypass (see L_DYN_=
VGPR_ALLOC_LOOP).<br>
&gt; +// On entry from restore s_save_state_priv has been populated from s_=
restore_state_priv and<br>
&gt; +// the bypass marker bit (S_SAVE_PC_HI_DVGPR_BYPASS_MASK) has been se=
t in PC_HI -- this entry<br>
&gt; +// skips the PC_HI mask at L_HAVE_VGPRS, so the marker survives to th=
e dynamic-VGPR save,<br>
&gt; +// where it suppresses the durable scratch count write (the count and=
 the dynamic VGPRs are<br>
&gt; +// already intact in scratch from the previous save).<br>
&gt; +L_SAVE_BYPASS:<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; s_save_tmp, 0<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_setreg_b32&nbsp;&nbsp;&nbs=
p; hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SH=
IFT, 1), s_save_tmp&nbsp;&nbsp;&nbsp;&nbsp; //clear saveCtx bit<br>
&gt;&nbsp;&nbsp;<br>
&gt; @@ -798,6 +856,9 @@ L_SAVE_VGPR_NORMAL:<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // VGPR store using dw burst=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; m0, 0x4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; //VGPR initial index value =3D4<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_getreg_b32&nbsp;&nbsp;&nbsp; s_save_tmp, h=
wreg(HW_REG_WAVE_STATUS)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //save to check D=
YN_VGPR_EN later<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbs=
p; m0, s_save_alloc_size<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp; L_SAVE_=
VGPR_END<br>
&gt;&nbsp;&nbsp;<br>
&gt; @@ -815,12 +876,51 @@ L_SAVE_VGPR_W32_LOOP:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; global_store_addtid_b32 v3, =
[s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:128*3<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; m0, m0, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; //next vgpr index<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_bitcmp1_b32&nbsp;&nbsp; s_save_tmp, SQ_WAV=
E_STATUS_DYN_VGPR_EN_SHIFT<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp; L_SAVE_FIXED_VGPR_END_L=
OOP_CHECK<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp; m0, WAVE_MIN_=
NUM_DVGPRS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp; L_SAVE_DYN_VGPR_SAVE<br=
>
&gt; +<br>
&gt; +L_SAVE_FIXED_VGPR_END_LOOP_CHECK:<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; s_save_mem_offset, s_save_mem_offset, 128*4&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //every buffer_s=
tore_dword does 128 bytes<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbs=
p; m0, s_save_alloc_size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; //scc =3D (m0 &lt; s_save_alloc_size) ? 1 : 0<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE_=
VGPR_W32_LOOP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /=
/VGPR save is complete?<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; L_SAVE_VGPR_END<br>
&gt;&nbsp;&nbsp;<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +L_SAVE_DYN_VGPR_SAVE:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_bitcmp1_b32&nbsp;&nbsp; s_save_pc_hi, S_SA=
VE_PC_HI_DVGPR_BYPASS_SHIFT<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE_VGPR_END<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // Persist the total VGPR count in the reser=
ved scratch slot (durable per wave).<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // s_save_alloc_size holds the live total VG=
PR count (HW_REG_WAVE_GPR_ALLOC).<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_save_mem_offset, S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; v0, s_save_alloc_size<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_store_b32 off, v0, s_save_mem_offset=
 offset: 0<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // m0 already holds WAVE_MIN_NUM_DVGPRS: the=
 fixed-VGPR loop steps by 4 and branches here<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // on the first index at or past the block b=
oundary (must match RESTORE).<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_save_mem_offset, S_SAVE_DVGPR_SCRATCH_RESERVE<br>
&gt; +<br>
&gt; +L_SAVE_DYN_VGPR_SAVE_LOOP:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_ge_u32&nbsp;&nbsp;&nbsp; m0, s_save_al=
loc_size<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE_VGPR_END<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_movrels_b32&nbsp;&nbsp; v0, v0&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //v0 =3D v[0+m0]<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_movrels_b32&nbsp;&nbsp; v1, v1&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //v1 =3D v[1+m0]<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_movrels_b32&nbsp;&nbsp; v2, v2&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //v2 =3D v[2+m0]<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_movrels_b32&nbsp;&nbsp; v3, v3&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //v3 =3D v[3+m0]<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_store_b32 off, v0, s_save_mem_offset=
 offset: 0<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_store_b32 off, v1, s_save_mem_offset=
 offset: 4<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_store_b32 off, v2, s_save_mem_offset=
 offset: 8<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_store_b32 off, v3, s_save_mem_offset=
 offset: 12<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; m0, m0, 4<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_save_mem_offset, s_save_mem_offset, 16<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; L_SAVE_DYN_VGPR_SAVE_LOOP<br>
&gt; +#endif<br>
&gt; +<br>
&gt;&nbsp;&nbsp; L_SAVE_VGPR_WAVE64:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // VGPR store using dw burst=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; m0, 0x4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; //VGPR initial index value =3D4<br>
&gt; @@ -934,9 +1034,23 @@ L_RESTORE_VGPR:<br>
&gt;&nbsp;&nbsp; L_ENABLE_RESTORE_VGPR_EXEC_HI:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; exec_hi, 0xFFFFFFFF<br>
&gt;&nbsp;&nbsp; L_RESTORE_VGPR_NORMAL:<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // For DVGPR waves this loop restores only t=
he fixed VGPR block, so cap the loop bound at<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // WAVE_MIN_NUM_DVGPRS rather than taking th=
e live GPR_ALLOC size.&nbsp; The dynamic VGPRs are<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // restored later, from scratch, once SCRATC=
H_BASE has been restored (it is not yet<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // restored at this point) and their count i=
s known.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_getreg_b32&nbsp;&nbsp;&nbsp; s_restore_tmp=
2, hwreg(HW_REG_WAVE_STATUS)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_bitcmp1_b32&nbsp;&nbsp; s_restore_tmp2, SQ=
_WAVE_STATUS_DYN_VGPR_EN_SHIFT<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp; L_RESTORE_ALLOC_SIZE_FR=
OM_HW&nbsp; // Not DVGPR, use HW register<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_restore_alloc_size, WAVE_MIN_NUM_DVGPRS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; L_RESTORE_ALLOC_SIZE_DONE<br>
<br>
I am not sure we need to distinguish here, do we?&nbsp; According to the<br=
>
manual[1] states &quot;Waves in dynamic VGPR mode are initialized with one<=
br>
VGPR-block allocated&quot; (section 3.3.3).&nbsp; Therefore, I&#8239;expect=
 that if the<br>
wave is using DVGPRs, on restore it is created with 1 block, so reading<br>
GPR_ALLOC would give us the same result.<br>
<br>
Unless I&#8239;missed someting, it seems we could just remove this hunk (an=
d<br>
the definition of s_restore_tmp2), and have the same behaviour.&nbsp; Am I<=
br>
missing something?<br>
<br>
[1] <a href=3D"https://docs.amd.com/v/u/en-US/rdna4-instruction-set-archite=
cture" id=3D"OWAf2340b75-6a3b-5e3f-68a8-78c4d87ee2e4" class=3D"OWAAutoLink"=
 data-auth=3D"NotApplicable">
https://docs.amd.com/v/u/en-US/rdna4-instruction-set-architecture</a></div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(15, 92, =
26);">Because here, if the wave has dVGPR, it saved as 32 VGPRs + the rest =
on srcratch memory. During restore, we would see 32 as the alloc size even =
there should be</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(15, 92, =
26);">more dVGPR. Therefore, we have a condition here to resolve which one =
is which. Is it a wave without enabling dVGPR, or a wave with dVGPR and we =
need to get</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><span style=3D"col=
or: rgb(15, 92, 26);">The actual allocation size.<br>
</span><br>
&gt; +<br>
&gt; +L_RESTORE_ALLOC_SIZE_FROM_HW:<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_getreg_b32&nbsp;&nbsp;&nbs=
p; s_restore_alloc_size, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR=
_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; s_restore_alloc_size, s_restore_alloc_size, 1<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; s_restore_alloc_size, s_restore_alloc_size, 2&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Number of VGPRs =3D (vgpr_siz=
e + 1) * 4&nbsp;&nbsp;&nbsp; (non-zero value)<br>
&gt; +L_RESTORE_ALLOC_SIZE_DONE:<br>
<br>
If this remains (see previous comment), this label might be guarded by<br>
HAVE_DYNAMIC_VGPRS (not strictly necessary, but would remain consistent<br>
with the rest of the patch).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(15, 92, 26);">
Will resolve this</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //determine it is wave32 or =
wave64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshr_b32&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; m0, s_restore_size, S_WAVE_SIZE<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; m0, m0, 1<br>
&gt; @@ -1181,6 +1295,74 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_setreg_b32&nbsp;&nbsp;&nbs=
p; hwreg(HW_REG_WAVE_SCHED_MODE), s_restore_tmp<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp;<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // Default: resume normally after restore (s=
ee s_restore_dvgpr_bypass).<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_restore_dvgpr_bypass, 0<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // Check if dynamic VGPR is enabled<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_getreg_b32&nbsp;&nbsp;&nbsp; s_restore_dvg=
pr_tmp, hwreg(HW_REG_WAVE_STATUS)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_bitcmp1_b32&nbsp;&nbsp; s_restore_dvgpr_tm=
p, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp; L_SKIP_DYN_VGPR_RESTORE=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // Total VGPR count persisted in the reserve=
d scratch slot at preempt (see<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // L_SAVE_DYN_VGPR_SAVE).<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; exec_lo, 0xFFFFFFFF<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_restore_mem_offset, S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_load_b32 v0, off, s_restore_mem_offs=
et offset: 0<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_wait_loadcnt&nbsp; 0<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_readlane_b32&nbsp; s_restore_dvgpr_count, =
v0, 0<br>
&gt; +<br>
&gt; +L_DYN_VGPR_ALLOC_LOOP:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // s_alloc_vgpr modifies its operand, so giv=
e it a fresh copy of the count each attempt.<br>
<br>
Does it?&nbsp; It modifies SCC, but I do not think it modifies its operand.=
<br>
<span style=3D"color: rgb(15, 92, 26);">Good catch, will resolve this.</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_restore_dvgpr_tmp, s_restore_dvgpr_count<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_alloc_vgpr&nbsp;&nbsp;&nbsp; s_restore_dvg=
pr_tmp<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_DYN_VGPR_RESTORE&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // allocation succeeded<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // Allocation failed.&nbsp; Keep retrying un=
less a context-save is pending.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_getreg_b32&nbsp;&nbsp;&nbsp; s_restore_dvg=
pr_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_restore_dvgpr_tmp, s_restore_dvgpr_tmp, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CON=
TEXT_MASK<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_sleep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x10<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp; L_DYN_VGPR_ALLOC_LOOP&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // no save pending -&gt; retry<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // A context-save is pending and there is st=
ill no room: bypass to the save path so<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // this wave is re-saved and retried on a la=
ter restore. The re-save does write<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // the fixed VGPRs back from registers, so v=
[0:3] must be put back first.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_restore_dvgpr_bypass, 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // re-save instead of rfe<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; L_DYN_VGPR_RELOAD_FIXED<br>
&gt; +<br>
&gt; +L_DYN_VGPR_RESTORE:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // Enable all lanes for the v_movreld instru=
ctions below.&nbsp; This path is wave32 only, so<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // exec_lo is the entire mask.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; exec_lo, 0xFFFFFFFF<br>
<br>
Can exec_lo be anything else at this point?&nbsp; It was set to this value<=
br>
before reading the vgpr alloc size, which was needed to re-allocate.<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(15, 92, 26);">
Removing unnecessary register value set</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // Start at the first dynamic VGPR (must mat=
ch SAVE).<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; m0, WAVE_MIN_NUM_DVGPRS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_restore_mem_offset, S_SAVE_DVGPR_SCRATCH_RESERVE<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp; m0, s_restore=
_dvgpr_count<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp; L_DYN_VGPR_RELOAD_FIXED=
<br>
&gt; +<br>
&gt; +L_DYN_VGPR_RESTORE_LOOP:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_load_b32 v0, off, s_restore_mem_offs=
et offset: 0<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_load_b32 v1, off, s_restore_mem_offs=
et offset: 4<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_load_b32 v2, off, s_restore_mem_offs=
et offset: 8<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scratch_load_b32 v3, off, s_restore_mem_offs=
et offset: 12<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_wait_loadcnt&nbsp; 0<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_movreld_b32&nbsp;&nbsp; v0, v0<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_movreld_b32&nbsp;&nbsp; v1, v1<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_movreld_b32&nbsp;&nbsp; v2, v2<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; v_movreld_b32&nbsp;&nbsp; v3, v3<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; m0, m0, 4<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_restore_mem_offset, s_restore_mem_offset, 16<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp; m0, s_restore=
_dvgpr_count<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_DYN_VGPR_RESTORE_LOOP=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // Put back the v[0:3] borrowed above as scr=
atch-load staging.&nbsp; The fixed VGPR block starts<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // at CWSR offset 0, DVGPR implies wave32, h=
ence the 128-byte stride.<br>
&gt; +L_DYN_VGPR_RELOAD_FIXED:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; global_load_addtid_b32&nbsp; v0, [s_restore_=
base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; global_load_addtid_b32&nbsp; v1, [s_restore_=
base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS offset:128<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; global_load_addtid_b32&nbsp; v2, [s_restore_=
base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS offset:128*2<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; global_load_addtid_b32&nbsp; v3, [s_restore_=
base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS offset:128*3<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_wait_idle<br>
<br>
Could as well be `s_wait_loadcnt 0`, couldn't it?<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(15, 92, 26);">
Yes, will resolve it.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
&gt; +L_SKIP_DYN_VGPR_RESTORE:<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; m0, s_restore_m0<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; exec_lo, s_restore_exec_lo<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; exec_hi, s_restore_exec_hi<br>
&gt; @@ -1220,6 +1402,14 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; exec, exec, exec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Restore STATUS.EXECZ, not wr=
itable by s_setreg_b32<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; vcc, vcc, vcc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Restore STATU=
S.VCCZ, not writable by s_setreg_b32<br>
&gt;&nbsp;&nbsp;<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // DVGPR restore-allocation bypass: if dynam=
ic VGPRs could not be allocated while a<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // context-save was pending (flagged in s_re=
store_dvgpr_bypass =3D=3D 1 by<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // L_DYN_VGPR_ALLOC_LOOP), re-enter the save=
 path instead of resuming the shader.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_eq_u32&nbsp;&nbsp;&nbsp; s_restore_dvg=
pr_bypass, 1<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_DYN_VGPR_BYPASS_RESAV=
E<br>
&gt; +#endif<br>
&gt; +<br>
&gt;&nbsp;&nbsp; #if RELAXED_SCHEDULING_IN_TRAP<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Assume relaxed scheduling=
 mode after this point.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; restore_sched_mode(s_restore=
_tmp)<br>
&gt; @@ -1239,6 +1429,16 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_rfe_b64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; s_restore_pc_lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Return to the main shade=
r program and resume execution<br>
&gt;&nbsp;&nbsp;<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +L_DYN_VGPR_BYPASS_RESAVE:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // Out of line so the resume path above ends=
 at s_rfe_b64 with SCC untouched.&nbsp; Hand the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // save path the state_priv it would otherwi=
se have read at trap entry, and set the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // transient PC_HI bypass marker so the save=
 skips the durable scratch count write.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_save_state_priv, s_restore_state_priv<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; s_save_pc_hi, s_save_pc_hi, S_SAVE_PC_HI_DVGPR_BYPASS_MASK<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; L_SAVE_BYPASS<br>
&gt; +#endif<br>
<br>
I am not sure I&#8239;follow why this needs to be ou of line.&nbsp; SCC was=
 touched<br>
before deciding if we want to jump here or not.&nbsp; Feels the previous hu=
nk<br>
could be<br>
<br>
&nbsp;&nbsp; s_cmp_eq_u32&nbsp;&nbsp; s_restore_dvgpr_bypass, 1<br>
&nbsp;&nbsp; s_cbranch_scc0 L_NO_DVGPR_RESAVE<br>
<br>
&nbsp;&nbsp; // set state as expected for save<br>
&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp; s_save_state_priv, s_restore_state=
_priv<br>
&nbsp;&nbsp; s_or_b32&nbsp;&nbsp;&nbsp;&nbsp; s_save_pc_hi, s_save_pc_hi, S=
_SAVE_PC_HI_DVGPR_BYPASS_MASK<br>
&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;&nbsp; L_SAVE_BYPASS<br>
<br>
L_NO_DVGPR_RESAVE:<br>
&nbsp;&nbsp; ...<br>
&nbsp;&nbsp; // Here we do restore SCC<br>
&nbsp;&nbsp; s_setreg_b32&nbsp;&nbsp;&nbsp; hwreg(HW_REG_WAVE_STATE_PRIV), =
s_restore_state_priv<br>
<br>
<br>
Best,<br>
Lancelot.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><span style=3D"col=
or: rgb(15, 92, 26);">Right, let me address that.</span><br>
<br>
&gt; +<br>
&gt;&nbsp;&nbsp; L_END_PGM:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Make sure that no wave of=
 the group/cluster can exit the trap handler<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // before the group/cluster =
barrier state is saved.<br>
&gt; @@ -1271,6 +1471,18 @@ function write_12sgpr_to_v2(s)<br>
&gt;&nbsp;&nbsp; end<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // DVGPR waves (wave32 only) keep only the f=
ixed VGPR block (WAVE_MIN_NUM_DVGPRS) in<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // the CWSR buffer; the dynamic VGPRs live i=
n scratch.&nbsp; Every CWSR region placed after<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // the VGPR block (SGPR/HWREG/LDS/TTMP) is s=
ized off the VGPR block, so centralize the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // fixed-block adjustment here to keep every=
 offset consistent.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_getreg_b32&nbsp;&nbsp;&nbsp; s_vgpr_size_b=
yte, hwreg(HW_REG_WAVE_STATUS)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_bitcmp1_b32&nbsp;&nbsp; s_vgpr_size_byte, =
SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp; L_GET_VGPR_SIZE_NORMAL<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s_vgpr_size_byte, (WAVE_MIN_NUM_DVGPRS * 128)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //16 fixed VGPRs, wave32<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; L_GET_VGPR_SIZE_DONE<br>
&gt; +L_GET_VGPR_SIZE_NORMAL:<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_getreg_b32&nbsp;&nbsp;&nbs=
p; s_vgpr_size_byte, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZ=
E_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; s_vgpr_size_byte, s_vgpr_size_byte, 1<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_bitcmp1_b32&nbsp;&nbsp; s_=
size, S_WAVE_SIZE<br>
&gt; @@ -1280,6 +1492,9 @@ function get_vgpr_size_bytes(s_vgpr_size_byte, s=
_size)<br>
&gt;&nbsp;&nbsp; L_ENABLE_SHIFT_W64:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; s_vgpr_size_byte, s_vgpr_size_byte, (2+8)&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Number of=
 VGPRs =3D (vgpr_size + 1) * 4 * 64 * 4&nbsp;&nbsp; (non-zero value)<br>
&gt;&nbsp;&nbsp; L_SHIFT_DONE:<br>
&gt; +#if HAVE_DYNAMIC_VGPRS<br>
&gt; +L_GET_VGPR_SIZE_DONE:<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp; end<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; function get_sgpr_size_bytes<br>
<br>
</div>
</body>
</html>

--_000_SA1PR12MB999254C203B930C1E9D9DCEDE09F842SA1PR12MB999254_--
