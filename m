Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA19C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 14:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C6C10E211;
	Wed, 30 Jul 2025 14:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C8wboOaU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879C110E211
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 14:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMohpoPnu+i4RbEar62RnG4snqlpgX3n+TVooO7tox1paraVugmqGL1nDR/go0OuGZVkS9bi53YVP8DxxLRJWQ95YFATagV558mLbTfxZ94kc1F9xtaTTikl2o4O3DEfz9Jkn7JMkxi4tVxTLdlx/uWXafWeBLYt+zV36Mujvyd1hst+lsmXsql7IQwJz983bmR+zq/OycKOueQKomJL3nWz5t6HqDf1a9EYwl89yoml6T7B65MjMt4hdcwvHwBR48zeiw81OJqd8Ez9dhbIBXZgCqZCseZ/f2djeyt80ouD87U5dXD6fvRHchcqyqyuQAuxlYLt0GQLNMYVJnQSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMnaap+y0eHMJlCYrbm0/BZK/RzuEWBd/ZsDSRXnjhM=;
 b=reVlVKfm4c6DDOMJqvk7iFt/oCSiUrWbAUAmj0VSoDhlKVNBKbzt7He+I8eyCfu44aK3Y/9eNlg4mDsupMSbcDe5i8luBBG0Obus4IKID5DjWyHWt1+1re/G7Okdc7pyJr1KmXYSGwzbpvhtwm5d+hqrR8tLiOfnckszOjTaOawE096MyxUfFE3HlXqHYMzQXSqP8w5ha5NvRNV4YIeXInlu7C7pjHOuOH3yyLCQr2payC4A+NWSw1SGzKXYXuvHDh8uFXJhiZ6MD8VGiwcP6crJlHa2dWvNpog6XXF/QVGe8HmxUsZZkgOB58SaJrRIxo7amVcxEUbl+MMDakOWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMnaap+y0eHMJlCYrbm0/BZK/RzuEWBd/ZsDSRXnjhM=;
 b=C8wboOaUAC+PO2SkHy4TRgDo04h8N6DgM9huc2RVS/GN4ZZ8SoUmgmf/N63MaFTnSC31bqUg3OXZ43pCkOQLPkGT4IS+5O12sCpM2JTKJSIbLwMSeiAEj3d3dH/pNKTdSIRmglPzsz7qdGRcDGQbaK+yIO6ilirw2KAevycC9nQ=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 14:36:08 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b%6]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 14:36:07 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel
Thread-Topic: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel
Thread-Index: AQHcATPja5UzcvzUJk2ttUQcXVlVPrRKe+0AgABABac=
Date: Wed, 30 Jul 2025 14:36:07 +0000
Message-ID: <CY5PR12MB6345EE3C03B323938A9243FFFA24A@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20250730092454.58644-1-xiang.liu@amd.com>
 <SJ2PR12MB8807A6715D8376959EDA3BE8B024A@SJ2PR12MB8807.namprd12.prod.outlook.com>
In-Reply-To: <SJ2PR12MB8807A6715D8376959EDA3BE8B024A@SJ2PR12MB8807.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-30T14:36:07.2840000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|SJ1PR12MB6051:EE_
x-ms-office365-filtering-correlation-id: e49baca0-e30d-4d1b-541e-08ddcf766bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Gc28MMzoVniIKi/upvRJAC5ECGZYK6BXotKC+2a4HVlWi0dlej3SBnI3yjji?=
 =?us-ascii?Q?qtnn8/DNTraLEX8s7PvvsviZblR4BBjo5X5KgnhP2mKgwVjlTabJV05SwGGy?=
 =?us-ascii?Q?LIIvxoRCBHGM8Xk8piYOeAwHSwDLkNeuFqL2m8joAKJHIVV0u7ONEQf8xWWy?=
 =?us-ascii?Q?N5iPDixhjTv3tB7ibBT/ANCXWietVEiOob9u4wKtXOEZIPKngna9AX0OYGOT?=
 =?us-ascii?Q?3kHzgOHqXPTEIxXvnsyB9FCuUBC1Z9gu2NqVxIr9OcCMxycMLUN0HjgtMdLf?=
 =?us-ascii?Q?ZGOfdHc6YcF24OqfCltd/qIlL+T/4D1qdCY6zl5SJ1w6+41K4jpedJTUp2Mr?=
 =?us-ascii?Q?rvIJVUIb3E4X7EHdSRqe2xNIbE2A3j2Gv4/ZNP2qrW5AxdjV/YvUDyWCtlHt?=
 =?us-ascii?Q?otFsq8lQYitLxGU0MswNSaRj4HJMVe4sRaawQoAstqQoTtqv1/gU8s2nWnab?=
 =?us-ascii?Q?z8cm0+c6yjlNJjV3tgJrysS2hzQsQwrp7n4EWGKJ1UHEHc0qCEyC/8pCQygS?=
 =?us-ascii?Q?npayo74u27f2EdGV+2oW66B0LvU9n6i5qb8mmdWr3mbIsx+wEPh96rEC6GNZ?=
 =?us-ascii?Q?+gcSoswUgJoF3PGKMMxgeRj4Nm5W6NNmY9fMXVPyER9DEiytB1m30SIt7FRd?=
 =?us-ascii?Q?qW1hnDoUu2rlmx7RDV2Wk9odoJHLqBREPXHdW6tfGvTBNtKmJdTqoizzW7yN?=
 =?us-ascii?Q?WLBcL95qtOSr0hBT0DRnx10p4qM0nTreg3T3jDOvMGyzS3C2VivxpqZ1duCt?=
 =?us-ascii?Q?0nLIgdOw83Mq33gGxu+PqG67oC/gIl4zgvQmufTaLjdHg5XVi/bSETDnaE9F?=
 =?us-ascii?Q?d5bOMjBjnL/hoxmEvM5myA5PWWFCer51l01mlj0+fRckczJyper/u9ZCYwfP?=
 =?us-ascii?Q?HrpT/BAkAD1R2L1UYQSP5a0yRxNTlAoXcqGVUPDGP//rbVi1j4WcXqc3ynRl?=
 =?us-ascii?Q?1IyBaAgpR7uMVHxzI+p0BIhN3iA/ULiBJ6G2PUXIhbGXAp/QnAMAsi3b/9mp?=
 =?us-ascii?Q?e/PDKEkbFc3RY+rFV3oAxwB6SgxpPbK1yeX3Ri0b26UrJKTIM4XKeWbOR86n?=
 =?us-ascii?Q?NVuSILnUzLt90NEy+i2zfBTqndoz4wUSxe+omVntKw4s3aDuDDB6p3zXeuXo?=
 =?us-ascii?Q?b90t1o17ForqjgNQwMiRwKo/q8WhmjdtWsXhkQJJn4zbjeoa8PNxIDK3W8SU?=
 =?us-ascii?Q?ghjUDxdw8ddDOlsvad4EIDB0juAGNoIR/0Ab+xsil8AcOYHo+8CiDtdVBDp2?=
 =?us-ascii?Q?D+mo12cT5KYjEQt28qWCaY5ErmYqXzILHmfDroBSpP7aEwMRhacXpV2C+imb?=
 =?us-ascii?Q?UhAZ4vwiBG2SBM6hrSg2gNidu/qhinP59A+KK7WKb7m6I1+IJAi48PmOMzbg?=
 =?us-ascii?Q?FEqS9dXsx/yMVISMVcIJQrLBUZ0ojfnq7RNjiwfhjsrlR3avokU0CQFQ2JuS?=
 =?us-ascii?Q?aV/4s77fs4/iGGiZwJ+kJhN6kWWXA36mCbVVaOhOmMtMf3Qc7B+BRA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ymg3Fes/V+97eXpN2A9l7mnKRVwbpIzckiUyrCKpC0HIHSGok0QTtHkZxstG?=
 =?us-ascii?Q?uFGXxt3ltBAD5nrSK+E4uBfo/K7vchuijfzd81vjlPVh6Bs6uJ+j7WPS0VWb?=
 =?us-ascii?Q?esMS9JqAq5A6wtCAqkQYtC96w4acTVzVHwUQdITDwxtK4KXN0tOEErSPebWE?=
 =?us-ascii?Q?sBDXy4H0Y14NweWWudsEZGHJTDI2IThUj0hl4yxu5fjHqUwcNVHbtDgtlvrK?=
 =?us-ascii?Q?z3tSR7aHAGzQedtOM0subgSqxXdm/f1Gcdq+FcmtUSZ23zvA0rc59gALoisH?=
 =?us-ascii?Q?xEe7ROGRWxzBG2ngN2z2UzQqpb5geSxup3nfSs4K8VhHsRXTUwOHn4QCuGfY?=
 =?us-ascii?Q?TKYyn9c3CmPf4eGKTpVWYu2OU9AK6QQVv1v9wQBNiJ/Q765Niub7w6bmjYDd?=
 =?us-ascii?Q?OBMz0SETNYrVH5Fqtal8IVYcrxpVl7Y9Ru0Ob7jCoGDTcx+5UQc+v5EZAgpN?=
 =?us-ascii?Q?xYvXxtZBAAQEULkoKhuMcWuuVX1EHrE+YAkqRdwyRQlLyJsTlCGQyCWcviGj?=
 =?us-ascii?Q?9cUF/FeN32nC5TBNshWyu2PKk2VaiBeDcwoQJP6R4MUGG/eDHJlFxEB6CwKW?=
 =?us-ascii?Q?cTcBPMXd7Z4Hh4ITgMJIvZknct+3clTNfz8S2OrMQAS+TpJLAiwi0kXmwgWn?=
 =?us-ascii?Q?J70C4sWAfEepd7dL0PheXytTGv8c9cztTQEimIefob/VYMphdWS/l0ipTxud?=
 =?us-ascii?Q?CObvycqLZS3d15bCTdv9kOqIq20zJAAPVKQohntk23EN304V87D6qrDdGtv5?=
 =?us-ascii?Q?SPS+gU2OQQ2+qX+gVFxzoaGJohJ1aZtX7vAWId1N1suJIjnn552PqUs9Zh1P?=
 =?us-ascii?Q?QuBFt0w2niYDIaAg2iRHuGxfZthghCN3QerzQsYYPmhiQ1PpNMxiikNtOVaO?=
 =?us-ascii?Q?aFpG9WFuqJkp/XUa9qpLCNe/HRYEI+XN3gesXgZbeiXY9ITNwFMF/DMGvJbe?=
 =?us-ascii?Q?ug1FNmfh0mi/YE96bLG4OoFZlIFAzT387Dbxj/h8QxC9SV2mhlBx9JwfNJ2Y?=
 =?us-ascii?Q?33LRU4nMW1yoqlnsaHtn3euebDQurCBKg/SogRvvT/PYn92aUo5fQkxjJeU0?=
 =?us-ascii?Q?/brp0nkPUTitIfqLRVhHbVEWeXBdyEr8fajFDsJxvxknbYVzzW5v4SNGEjku?=
 =?us-ascii?Q?HdlJ0IAvCY5wjxCOxWi61Mjy2Q9AciMhwM5dlNhygKFs8Rca5w+6FuJrJeAl?=
 =?us-ascii?Q?2ulCt9D0J1UGEv9s/6/27taqnU3u6N0huEfEsbB+mqQTV396aQgAbG2rRLnn?=
 =?us-ascii?Q?nJQTHUCuo5AwdWaPSp5pyykXaIHfuUSSTEtRGmcEdupKvCB7BAWrGAAmCpeS?=
 =?us-ascii?Q?LAQ2oxCe4GJ7xMe+J6TI9cZSyu89t/igcgCcTVM6Fb1ZG//k7hD1O3vgpFO7?=
 =?us-ascii?Q?WbCcfXIVTY1zigbwHvHV35Y/j9oU7/AXmNo5r8c3PLzP4EU2lsMYKZ+5uQ/K?=
 =?us-ascii?Q?deo5dBWz3k022tgxXXUQSDcpA5j7dqwjskvdoWTdK+MjLzGPhi+SNOylsTxK?=
 =?us-ascii?Q?YUpF36xm3DAXJbuhyAhh3hzJPap512jxF6SihXqAh07fgSQIb0+IZBoI1QVS?=
 =?us-ascii?Q?Z1Dw46psuQovgf8hkNc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6345EE3C03B323938A9243FFFA24ACY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49baca0-e30d-4d1b-541e-08ddcf766bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 14:36:07.8225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMe9T5Z+dfVr/16G+PDbPt87dYPsTXnvoJtqKAca/rgHXgWs/bZIVHWnUAub7mqmDU7HdmWbTpjoZpdvO5akDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
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

--_000_CY5PR12MB6345EE3C03B323938A9243FFFA24ACY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks, will do.

Best Regards,

Liu, Xiang

________________________________
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, July 30, 2025 6:46 PM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: RE: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel

[AMD Official Use Only - AMD Internal Distribution Only]

Better to add comment for the added condition check, with this resolved, th=
e patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang =
Liu
> Sent: Wednesday, July 30, 2025 5:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean)
> <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel
>
> Avoid GFX poison consumption errors logged when fatal error occurs.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 47 ++++++++++++++-----------
>  1 file changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index 3835f2592914..59dbb9257096 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -125,6 +125,27 @@ static void aca_smu_bank_dump(struct amdgpu_device
> *adev, int idx, int total, st
>               RAS_EVENT_LOG(adev, event_id, HW_ERR "hardware error logged
> by the scrubber\n");  }
>
> +static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum
> +aca_hwip_type type) {
> +
> +     struct aca_hwip *hwip;
> +     int hwid, mcatype;
> +     u64 ipid;
> +
> +     if (!bank || type =3D=3D ACA_HWIP_TYPE_UNKNOW)
> +             return false;
> +
> +     hwip =3D &aca_hwid_mcatypes[type];
> +     if (!hwip->hwid)
> +             return false;
> +
> +     ipid =3D bank->regs[ACA_REG_IDX_IPID];
> +     hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
> +     mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
> +
> +     return hwip->hwid =3D=3D hwid && hwip->mcatype =3D=3D mcatype; }
> +
>  static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum
> aca_smu_type type,
>                                      int start, int count,
>                                      struct aca_banks *banks, struct
> ras_query_context *qctx) @@ -163,6 +184,11 @@ static int
> aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
>
>               bank.smu_err_type =3D type;
>
> +             if (type =3D=3D ACA_SMU_TYPE_UE &&
> +
> ACA_REG__STATUS__POISON(bank.regs[ACA_REG_IDX_STATUS]) &&
> +                 !aca_bank_hwip_is_matched(&bank, ACA_HWIP_TYPE_UMC))
> +                     continue;
> +
>               aca_smu_bank_dump(adev, i, count, &bank, qctx);
>
>               ret =3D aca_banks_add_bank(banks, &bank); @@ -173,27 +199,6=
 @@
> static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum
> aca_smu_
>       return 0;
>  }
>
> -static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum
> aca_hwip_type type) -{
> -
> -     struct aca_hwip *hwip;
> -     int hwid, mcatype;
> -     u64 ipid;
> -
> -     if (!bank || type =3D=3D ACA_HWIP_TYPE_UNKNOW)
> -             return false;
> -
> -     hwip =3D &aca_hwid_mcatypes[type];
> -     if (!hwip->hwid)
> -             return false;
> -
> -     ipid =3D bank->regs[ACA_REG_IDX_IPID];
> -     hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
> -     mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
> -
> -     return hwip->hwid =3D=3D hwid && hwip->mcatype =3D=3D mcatype;
> -}
> -
>  static bool aca_bank_is_valid(struct aca_handle *handle, struct aca_bank=
 *bank,
> enum aca_smu_type type)  {
>       const struct aca_bank_ops *bank_ops =3D handle->bank_ops;
> --
> 2.34.1


--_000_CY5PR12MB6345EE3C03B323938A9243FFFA24ACY5PR12MB6345namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks, will do.</div>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: bl=
ack;">Best Regards,</span></p>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rg=
b(36, 36, 36);">Liu, Xiang</span></p>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhou1, Tao &lt;Tao.Zh=
ou1@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 30, 2025 6:46 PM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu, Xiang(Dean) &=
lt;Xiang.Liu@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Skip poison aca bank from UE channe=
l</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
Better to add comment for the added condition check, with this resolved, th=
e patch is:<br>
<br>
Reviewed-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Xiang Liu<br>
&gt; Sent: Wednesday, July 30, 2025 5:25 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu, Xiang(Dean)<br>
&gt; &lt;Xiang.Liu@amd.com&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel<br>
&gt;<br>
&gt; Avoid GFX poison consumption errors logged when fatal error occurs.<br=
>
&gt;<br>
&gt; Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 47 ++++++++++++++-----=
------<br>
&gt;&nbsp; 1 file changed, 26 insertions(+), 21 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<br>
&gt; index 3835f2592914..59dbb9257096 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<br>
&gt; @@ -125,6 +125,27 @@ static void aca_smu_bank_dump(struct amdgpu_devic=
e<br>
&gt; *adev, int idx, int total, st<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; RAS_EVENT_LOG(adev, event_id, HW_ERR &quot;hardware error log=
ged<br>
&gt; by the scrubber\n&quot;);&nbsp; }<br>
&gt;<br>
&gt; +static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum<br>
&gt; +aca_hwip_type type) {<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct aca_hwip *hwip;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int hwid, mcatype;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 ipid;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || type =3D=3D ACA_HWIP_TYPE_UNKNO=
W)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; hwip =3D &amp;aca_hwid_mcatypes[type];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!hwip-&gt;hwid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ipid =3D bank-&gt;regs[ACA_REG_IDX_IPID];<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; hwid =3D ACA_REG__IPID__HARDWAREID(ipid);<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mcatype =3D ACA_REG__IPID__MCATYPE(ipid);<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return hwip-&gt;hwid =3D=3D hwid &amp;&amp; =
hwip-&gt;mcatype =3D=3D mcatype; }<br>
&gt; +<br>
&gt;&nbsp; static int aca_smu_get_valid_aca_banks(struct amdgpu_device *ade=
v, enum<br>
&gt; aca_smu_type type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; int start, int count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct aca_banks *banks, struct<br>
&gt; ras_query_context *qctx) @@ -163,6 +184,11 @@ static int<br>
&gt; aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_<=
br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; bank.smu_err_type =3D type;<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (type =3D=3D ACA_SMU_TYPE_UE &amp;&amp;<br>
&gt; +<br>
&gt; ACA_REG__STATUS__POISON(bank.regs[ACA_REG_IDX_STATUS]) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; !aca_bank_hwip_is_matched(&amp;bank, ACA_HWIP_T=
YPE_UMC))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; aca_smu_bank_dump(adev, i, count, &amp;bank, qctx);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ret =3D aca_banks_add_bank(banks, &amp;bank); @@ -173,27 +199=
,6 @@<br>
&gt; static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enu=
m<br>
&gt; aca_smu_<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; -static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum<br>
&gt; aca_hwip_type type) -{<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct aca_hwip *hwip;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int hwid, mcatype;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 ipid;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || type =3D=3D ACA_HWIP_TYPE_UNKNO=
W)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; hwip =3D &amp;aca_hwid_mcatypes[type];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!hwip-&gt;hwid)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ipid =3D bank-&gt;regs[ACA_REG_IDX_IPID];<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; hwid =3D ACA_REG__IPID__HARDWAREID(ipid);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mcatype =3D ACA_REG__IPID__MCATYPE(ipid);<br=
>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return hwip-&gt;hwid =3D=3D hwid &amp;&amp; =
hwip-&gt;mcatype =3D=3D mcatype;<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp; static bool aca_bank_is_valid(struct aca_handle *handle, struct =
aca_bank *bank,<br>
&gt; enum aca_smu_type type)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_bank_ops *bank_op=
s =3D handle-&gt;bank_ops;<br>
&gt; --<br>
&gt; 2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_CY5PR12MB6345EE3C03B323938A9243FFFA24ACY5PR12MB6345namp_--
