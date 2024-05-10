Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD99EC25B4F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CFE10E17B;
	Fri, 10 May 2024 06:29:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="levKSwRC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6123410E17B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtfvS7MooOQyYFz+hjguP+FNqiH9co5qPhAau+fqE7SVLkQmoKjxgYlvBBvWFM6A4O331AYZopSdC3JaHGPbJB+DeiG/A7BWs6Ne+qEgauKRYqfCD7xtUEg3QsFQZC8rDQVEI6L2DZrfG/4NskOsnKhq+wv9aCtP2eJU+Wy/bNqfNMAV2l+S6kCy6HaMT8VcBkrUA22uFhEPcLTHrORBYB/tCQLQdgXplFNNRZGXPE6Aj0/QJwkFQRilYzarxOsm/l6frIDtTWdTda3KG4YillvqmIHKxyh7Q5cuPzBVYT8wwEVh2Pjbv313ko/0/RnlQV+zrr5YPUlfPVBz/r9YOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pVLf9iZXk55RjGU4pEu5I+jfFB1m7M9qPAHTExTJyE=;
 b=DAnalOyCTStWNl0EsZqUPr8liqx53RPzCA3+u4CO4pXP5NM0QYoQb425erpwfur/JbjFR+90mDRZjzHwIptLycQPU4lO8LMAwZGHdlb57YzJ5kKU1NB3CWItL6fxlnS22GDoYG02aCHMb5hkqhFzoLVxnUxIGpLMv/29Jdiirw9ibKNjrnE8OVQa08/gFoKShw4ngHxXBLbPQjKPOq+3O5IbioF/vId7ZGIIggnGvFphowysCm/8oT+rlAGcLEhTMSotyU+IS/UB459dWUqv1bchpwzvPwead/ccNzQzeOVcJgebSGuhxN0duW2NCdCM6wTo67GGfQAvknr4lTIAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pVLf9iZXk55RjGU4pEu5I+jfFB1m7M9qPAHTExTJyE=;
 b=levKSwRCV4J1wONtUsBNYZal04cpvgu1kUmZxOIA7keiN95fBEPBHqhHcpScpc33LD5yrcowOszjlnzzLXn7yBmvkCzzdbwbpGKHlclRvuuPo5hrPFD/ZuwY1A+btIgqxJOLz4qaLeLQivkoyTbZXDK//VpDlbTXMuCzHTMsBoY=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 06:29:32 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:29:31 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 05/22] drm/amd/pm: check specific index for aldebaran
Thread-Topic: [PATCH 05/22] drm/amd/pm: check specific index for aldebaran
Thread-Index: AQHaooUaLL0Dq8xy+UuAlZoaFA5vdbGP9eSQ
Date: Fri, 10 May 2024 06:29:31 +0000
Message-ID: <CH3PR12MB8074FF294B5BF8FE7B56C149F6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-5-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-5-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=54e613d3-e000-4399-86b7-1679c18336d7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:46:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|MW4PR12MB7309:EE_
x-ms-office365-filtering-correlation-id: 8e1c3a18-6cce-4a65-39fe-08dc70ba8d71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ziALenEDOMtIYVISRoFUYqFAL6SvV++OMUBMLsvWrB1HeEnhe/VYXEderp?=
 =?iso-8859-1?Q?wWee4d+40lhZx78VL6pithfMib+Vnj9uqEsjwoasRIGelzDeI1xZ2MBY36?=
 =?iso-8859-1?Q?ZPmivrwhf+BH6NYNQQa/14dIuQZf0po3RfD2qTp1x6tiNeBF2XnFuVEEpY?=
 =?iso-8859-1?Q?wfr0m3eQq3X7+6jgrsMKTa0ESqWS415XAcxlN4kqKVRuz4+EZjW+5GQOgv?=
 =?iso-8859-1?Q?cTDzfwY3boIvThOCib63pGIcZaT/gzxNAW8TerM+vICamYEjIbq+Ge1Q0f?=
 =?iso-8859-1?Q?Yhv4zb1/30I4/V/NRUCfUUAV6hBI1GYx+Nh/Tgy8T+X+8SHcIjkSXzZlr+?=
 =?iso-8859-1?Q?h8RjYsw9JYop0q3eDZddBrwpJv9MtgUHprba7Lla77tsPoT3OFDoJKQpyC?=
 =?iso-8859-1?Q?HUimNj/EqFWLRbRPUDYJdyLJpvDwAWdV4m2Prwr/xavAKBq4dOF6neJ+Mn?=
 =?iso-8859-1?Q?9HNI/Zrz0MV93bkf9Mh2wlhPaHeJPUzuQjihZGFljEwxmHbz6mCvD+lUHC?=
 =?iso-8859-1?Q?CdEt0GnREHpwIECYd3JA5xedRSTecUBMvKgTrMkN0wBWNh76dkpLPkmMcp?=
 =?iso-8859-1?Q?5zpBhC6ablIJbNejB3RnPXAk8eJknDF8XcxawjxXB7hnu61tRZ9yqavXVK?=
 =?iso-8859-1?Q?heUiQmVrESq2V71G6OVsJn+N7DYJn3+83l6L7QINXNl7jTpRR0/DogacHY?=
 =?iso-8859-1?Q?OCogoBIIAEemL0lUKfCog6LFNil1VDGlA7bYP4gEyNf+1wHT62K6539Tiv?=
 =?iso-8859-1?Q?jEfDiOq5U2svo3Cg6wtXirb87Ixm9MlQ64Pm1GT1L8vmpDzDxHzcNizGJc?=
 =?iso-8859-1?Q?obbhPhfJNdld7HOLipMm9WrYbT2u61x1bUNbuQD62jhStmT9shC3anSi+v?=
 =?iso-8859-1?Q?6GdRBfrRb/w9/yU6UrhgbHO/PGGv9+Bu/59Idw6MgTYxpyOUJSMW4WEwcU?=
 =?iso-8859-1?Q?MRX6LRe1VRwNi6GxAuBjwfMBr+usfhKLNARgrwy14rgrjNMhEjR0tW+UL+?=
 =?iso-8859-1?Q?3fUDEzaMK77ybkPPV+4m2fEINDVuUtcSm4LfExOXZpUq2x0wHtglCjxSrb?=
 =?iso-8859-1?Q?fJQWeXDB5Bwh3M8mG0AtBD0k7MLLq5qcKFRZ5VZ1U8nU4+1Z8CxPIzwgGq?=
 =?iso-8859-1?Q?zgk/prnyEVNyvd+sdOPWHU5Jmf1v5X/tKOgts2G7btTmFZWt0ZVgED4EX1?=
 =?iso-8859-1?Q?HRSFo6Yv5xzudYaEK76G9inJVz8T9OE65qc96wTqDoURwJGT3DEw2nk3tk?=
 =?iso-8859-1?Q?q+kOaFJaExwDqKi0Zp8PDT3wqWCsentBRS1mGlENHUXHW2lRfZrLHNO8K1?=
 =?iso-8859-1?Q?/Ej+yzOotrlv91GB1372C/XBTEe5KnWt8XWWZSjW0vjsWYe3VVMx2DspAL?=
 =?iso-8859-1?Q?BjoMWjRKBT9l/yyqZsF6sVvuY2T8NfXA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kChFUGxgL46N6CGuSH0VGUli8Gier3jxN7nEprsMqUgTLJ41gBCegP7JIM?=
 =?iso-8859-1?Q?aL8myHRMQ8+4McTXQ5qtpzyP4J0jTcrpS7NsLJmXjd0GyjJgmNBOoispV3?=
 =?iso-8859-1?Q?pf5c+69LisS4qQ1IvWrpP0XfEOqu59idghr+p3XM7rL94hOMa7iPv8tnTL?=
 =?iso-8859-1?Q?19fuEONWwVS8r1gfvcjkBjtyk3L5ybxLl3L9CBtbKZVWvDs+7yBjDIZkwK?=
 =?iso-8859-1?Q?etDbNV97T49ZFbxjBUhsnck77XciZsjBR36M/dInoatK6csGdrT+AjpEpo?=
 =?iso-8859-1?Q?wCTX6Avik/n+uQdyn/vHERX0fGwICVE0QRx1VeEko+t2JCSqY9NuokaiRz?=
 =?iso-8859-1?Q?lVqSH/X84LwTHhw+YSP86UB9arxzxBkSdfRj8jVwoCM8AnX6TnKawY3bUw?=
 =?iso-8859-1?Q?DsXv2S07E8tJmjz9ikPoGim1rrrp/smRYQzIIVWdOQcvudz4XhlKYnC+0v?=
 =?iso-8859-1?Q?xLMf8OGThfOymFwWz2MHZRZnv1wQUi/ZrkSelEyaPZHC6PXkzUh0Q5VWvE?=
 =?iso-8859-1?Q?kFZsXMxBjshaFHo+ceOaUDDdj0Uy9wLiXNJv1VAmFgQ0uQQEaM5gV5kHmc?=
 =?iso-8859-1?Q?HwzZXH9Y5LY4QwLTw8GsttQfFQuvLUa19RmsBGUMv53L0uXNxdkA5qdTwP?=
 =?iso-8859-1?Q?GxAoqOylzjsN/3a2HHX6x8Xsh9HKrgcm8qeRExvR1DDbsLDww9tpjDbhsw?=
 =?iso-8859-1?Q?v6s8tOSTK5FifmAE16StHB3jNAHaemeNkRljp32mT3n/o2zryFXRD6OTwh?=
 =?iso-8859-1?Q?w3cCndJWjTJM+Fw0lDYdoHRKg3O/XjryX3Z8RKFh7oiJ36f5RxVD5opDmr?=
 =?iso-8859-1?Q?Rkkhgt7QVFVOhLUO8b7/M3AHKSwsLIfBpoKPB5X39pcPKLlQwk840tzmQA?=
 =?iso-8859-1?Q?pAnSaUL+C3yQWjnNXUGs3UJ7rcfmsDa4yCtAkXPg7l46/01N2jI+KPU9Vw?=
 =?iso-8859-1?Q?pqMO7oJhNWeDIft1arSK08Ut2f+eQHfgQ9zV4ucLXt3kku/RggxHclxALj?=
 =?iso-8859-1?Q?ZLg2zZlzjqn5PuWl1N5h0sF1Q29kQo14gY5Nhuan5r1fiQQbRKiESAf30l?=
 =?iso-8859-1?Q?Nyvs305hs1CGMSlH33lra3Zya2YqsbqN2Gi2hUzyZatpXTJm0ghfoQEPyw?=
 =?iso-8859-1?Q?f1+DK7t67WQsSkPq5bD6t1H2JK6vBdLfuH0djBVJ2ksZENyRdi1FYZnTXY?=
 =?iso-8859-1?Q?KnCEdXD68q8Aq+rKCJV7p/T+raRu+8MxhqMaQ1bQUhp13ef7SbqFk9HiVc?=
 =?iso-8859-1?Q?e0yf8UaGiV4DFse9lvv75SpLCvWquPARD7/KB2EJQ1bULn7TeVI7ttImLl?=
 =?iso-8859-1?Q?4q2xNv6xwU+k5Vn9aJygfAXuAy2ir2H0df0Qt+p0K49VnGVtu0TzJNCTgC?=
 =?iso-8859-1?Q?DLkQiXPZAmJG5uDNR+h9Uqaf2LAu5ct3dCj8NdRLwWlHu2/L0P3waS5tJ0?=
 =?iso-8859-1?Q?z3xImwOxWD5Mt6nUvha0GDx3TzDti/30oN4xqZNcF8fzpQXKusDqmoAY1V?=
 =?iso-8859-1?Q?9qYGL00NjUnupkzMbCMFAILz1+g0X3SFpKSITbrxVPzoUJ2HjI4QoNI81m?=
 =?iso-8859-1?Q?iZAGUVmoxCoyLVg8Yrs3SDXgP67dg/SlNPjNjGXQe/Ephnjr1nIsBSxvZT?=
 =?iso-8859-1?Q?ePDLVcdr1DfR8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1c3a18-6cce-4a65-39fe-08dc70ba8d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:29:31.8855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nukiNdbyLb7qhYWdZX8B1zT+Th6QvC91x8tOzFvqvWwOo7Kwgn3OzfvaJQH+mfBi6E5w8CavuyhJikUTPiX9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
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

[AMD Official Use Only - General]

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 05/22] drm/amd/pm: check specific index for aldebaran
>
> Check for specific indexes that may be invalid values.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index ce941fbb9cfb..a22eb6bbb05e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1886,7 +1886,8 @@ static int aldebaran_mode2_reset(struct
> smu_context *smu)
>
>       index =3D smu_cmn_to_asic_specific_index(smu,
> CMN2ASIC_MAPPING_MSG,
>                                               SMU_MSG_GfxDeviceDriverRese=
t);
> -
> +     if (index < 0 )
> +             return -EINVAL;
>       mutex_lock(&smu->message_lock);
>       if (smu->smc_fw_version >=3D 0x00441400) {
>               ret =3D smu_cmn_send_msg_without_waiting(smu, (uint16_t)ind=
ex,
> SMU_RESET_MODE_2);
> --
> 2.25.1

