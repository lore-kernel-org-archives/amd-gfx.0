Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA893E7315D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 12:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5755310E48F;
	Mon,  2 Feb 2026 12:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+VIIcTO";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6030B10E48F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 12:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6vLZRRN6+0HmuZ3cEWOI23bupEvUOQ3w97+H/qOBLMCCTub2TnTYwGBADU4AjQYA7hTIwrGYGJRsEGS5SeDNZtU8Ikryev9E3lFmISZIPYRqzPSSX6ir2BimoYAWKg4qlV3RtRCDBLl6vK/VSZeJo+Pci57kOxQjprAiR7uV9gPPIVUQeXzDpZuNRhpQk9Yh6VIIbJMphXY/eL/DS7S+BLkTzByOHVGDvPekNj2sWL2EXobracDko0QRvd3nDjZPz8EKc0BhjmK4TYh8RBgEGhy+zB8i3hM2CgjHEeGtK84LRb8lZBXY094ojA16ZMQVtfN6sw45RFJdTvyzAh4tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxvNJzVers34iuwvc1q0OqfTovAesrWtqAl6zg4ErBI=;
 b=fVPWSRuuElH2u5QxNQy56lPRM4Vx2YQz0WJth2hYM6CbU0ebCgNo9LQPOTi8yDjkTOdh9WDUuSPa8LXQRgHOR6Ov/RymOSTjJdOkmlndq2oGuXm5F6lQKToxRr9I4moOCfhJoVPDFhydNMq22+IyB3FM5SIiVcXys6f8r/8n8xOM7+Ol11XAYcT15MHXw/FQM9X+uF9BCA2PbzhmS524AXT62oEimS8c5rGZoZKtUgae1z4eBsTkdTmTFtrdTrVbLnFpTWNZeOtAZU9YgJuYNBSZKGQ9cqTSwllXYg1xgUEXd8k4M0VPiEbeiqOMowURdsUGb5vwuPW0hShImNDE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxvNJzVers34iuwvc1q0OqfTovAesrWtqAl6zg4ErBI=;
 b=B+VIIcTO80xN6VMOGL5HKmBdwq3GcYMM+hiagZPl0GmJvuPag2CS5n+wV23mR+MuiGTKI64+xljsNVZAkWit/kmcqMIs8cJZPUVyrash8N68s+wqabbp7nODcydQqzihHvqn1p6C1Qaq4R2BTyAp/HgHhELSkOzQoak+YWvuEmY=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 12:22:42 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac%5]) with mapi id 15.20.9520.010; Mon, 2 Feb 2026
 12:22:41 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is
 exceeded on init
Thread-Topic: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is
 exceeded on init
Thread-Index: AQHckizr3ebIh+j8d0iCPgA4nY4SrLVu9MAAgABigns=
Date: Mon, 2 Feb 2026 12:22:41 +0000
Message-ID: <CY5PR12MB6345916931ED235714DD34C2FA9AA@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20260130211031.446011-1-kent.russell@amd.com>
 <20260130211031.446011-2-kent.russell@amd.com>
 <PH7PR12MB87966F7BDEC2610399874C2EB09AA@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87966F7BDEC2610399874C2EB09AA@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-02T12:22:41.046Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|SA1PR12MB7443:EE_
x-ms-office365-filtering-correlation-id: b89f333a-941b-44da-702d-08de6255c311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?M7d3ohaJbiSBoKr1Yyqh4UuDfmPHRH700KL1fgQ2/5iSg/i+3mCVhewZM2FU?=
 =?us-ascii?Q?pSWdsZTkQbsQ8IFapr0TOY2rE/vXC/+LCBz0qKupRVIpBtI5Tkr3mvNkpMJa?=
 =?us-ascii?Q?KpilCFet1n2EVDIEZpSNtGxQgTA79s6f2ey5PBi7PknIzU2lucN1Iwyk07Na?=
 =?us-ascii?Q?Mno8w4RNHWgtdEqdGrD56zJ4tdSW+s7oJ8H4sgsrZCl9UAfpqa/jysUi9ox3?=
 =?us-ascii?Q?WI9UOS+xGNgntYLxBQ72Q9t0Ug3052mqUI3EItd1FdpjNxgKvPRsaCIwxF4D?=
 =?us-ascii?Q?lG0uN8vb1pL+tQ17I9/9Awa7xbZIJbV6Yh/eJG3nIu26rDMFDjipPaoqCwpG?=
 =?us-ascii?Q?R9kSvBjvItkX/GW2NEvQGG1nIeZoxNsUuxVGwVotOfEErsr12akprVWlHOjA?=
 =?us-ascii?Q?Poqnjzhra9oLoEmxddtWPz03OwWLy6NBAC2PwKgw4GxusWMPRRpAh05SKf4n?=
 =?us-ascii?Q?PDFIn7G/IQJjl4peQQxkrNCZqtRNoeGCYpVAMOzNbPB7hdmFl74k/uE0VrHJ?=
 =?us-ascii?Q?4frDu8tig3TqRkGrUzGVmpUJoW86hLn3UY+LAh8ysnlmCzz8LPhN9Xn9p3xC?=
 =?us-ascii?Q?Zg8gJCdRHwJ8QoZmm0ad5VruW6hcwz5qfGpiY9LzXXcpOUdO8mFVPxDelbLC?=
 =?us-ascii?Q?AU39Y6p9+5sxgkPPspiZZuwWzhPjHVFXOkdMv4V0EF07m3cF5NGRJUJKPWYk?=
 =?us-ascii?Q?TzUUEaDFnO3CREC3nlGykg165jCNrtXye753mLWTdG8XhwMdED8H6Hmav2jc?=
 =?us-ascii?Q?csi5beg+5UlhbfGkOo7DGMsZdnO4pz1/LLN4WT3xTJLMxFlICxY0awnGL3rc?=
 =?us-ascii?Q?ZXwvgceVoBUm8jsU1Y0kl9hu4HEPNvtPgVjo4YKevAeoOJUmw0qY5McQIiT3?=
 =?us-ascii?Q?Xt93ze4kWUH9VscIgndesESQKJi9ZyUwE1GqzeBkSSmAFPSj/hQcSHkQN/cS?=
 =?us-ascii?Q?nA6c3yYdzOMMPMc6rGtmJX3yYVsqHQ7y8mlGvBfdE40hVXe9fU0te/Dy89KR?=
 =?us-ascii?Q?YcacQhluSLY67EOYzU0g+7I0D2s+UvfZ6TaW4i7yCERwUvlrPBWAH7yEBQov?=
 =?us-ascii?Q?YiFHOACBZECLxsC3GmMZAV8qK1LHvBM9WcUmTzVE6sLWxoK8vGUW/q8aeXxj?=
 =?us-ascii?Q?qU6axo1+OORO+x1+qoMonqrsBKI4xE/4hNC8X1QgtIB56oh4oVCHkNxrgKpO?=
 =?us-ascii?Q?eiV2k013nOY4qcQCWs8+BPNY/UpL3Oym6PHQutMCR9Z8O/KnXaK/ZW+KevOG?=
 =?us-ascii?Q?EMCgmygDgFMCdK9iXe3e+8WFBZZVioCUeH3AIosJWvy0PqoHm7W3JQq9ZxTh?=
 =?us-ascii?Q?G/TX3rJTq5CW+uQwEU2jDe8E//8VXxjcc974AtrHzPNsKHoZC3/bst00B4pd?=
 =?us-ascii?Q?ESjYrYdNAzEsWaJqjY7uQZnqj6TZhsHjp+9+PLzSgEwtNz9ujhL1yeBuCtDF?=
 =?us-ascii?Q?Pi/Kc8KE3T+FTX7wGGdFU3q/PRFwMAzTsxocWFHAghC3+eHuP6uqkgi8tZbb?=
 =?us-ascii?Q?MmxCVvBSKguX0dXFm9XrxitBHHN5UhWquIvFx2yfRj64xOIJw5nrQnSQjPYv?=
 =?us-ascii?Q?8i2TLbhSNQlAAWW5j/+mX6kY3twNVqEvQS8iCZGaroHCEJdANkVunoT7EfV1?=
 =?us-ascii?Q?cg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K+nSaiorGpNX0fY50IlCanYwjCXnEO+E9qbFJOe7ioViGhf58PxGdydJfbHl?=
 =?us-ascii?Q?SaMSRfkOMZM4E4C5X5/uqQb7NG/3KXtBTJRmUkRflrmuggEf52NJdMuMBKpw?=
 =?us-ascii?Q?EOSkolwmrrOl9jH3glFllPfp9YCAePAt4+llG+7V+ozrvdg88wCcsanGrd76?=
 =?us-ascii?Q?FklduvTNogGXkhTxnMke3beqquc4gZ7vKgNe7oV4hN1LGcTDe+J+Om2ctjKQ?=
 =?us-ascii?Q?bLBKAbJ116NUVW6lZ3VXIi3UR9fGGIsJ6DIgZIsSPBFtPm2uJ6DezEEfZjca?=
 =?us-ascii?Q?qhcpDx7koF/NqUT9Ss8JVLSuQzh5mfQ2bQmyh9+1W2nheKQvIyeELepQAFxV?=
 =?us-ascii?Q?s0bKrzPCGd+xMc6J/93fZZ5eMeQfUqWdTKhRycUXhmZMdAuQdAQHH4yptA52?=
 =?us-ascii?Q?to7fX1hZmsHlQHK8y5zXPcw8gB5ho0IAw7yK/V4BkP93CInzPpOtbSynIhBL?=
 =?us-ascii?Q?pwgpRqBA3Fj5APDq4msOc/uhbETMqHtWHTOV8qUs1gU890zUmLqMdYMKhis6?=
 =?us-ascii?Q?KGrC9+1Iviz4dM/LiEhtbBDExsWYav4wsHMgUJolBIb7cEjwQLxxjMx7tJIk?=
 =?us-ascii?Q?vlbo6ql+VQtGZJQmfKoKF1wBv9dYPPgVGkShMFWuQcmSdwg7X5ZZqcv7alAG?=
 =?us-ascii?Q?h4ftt9ENepX5roNp+rz/olzFn/FB1lkxb+QFM/zKnztOtLErxSRxwzVPEN2N?=
 =?us-ascii?Q?AgVZZtptCX9RTyHsBEXnDTW9UAgsl9EStfHSQfCqgZxXEjyjLR5QqFTbGIZs?=
 =?us-ascii?Q?UTAlqcruHWqWGwH5Pid2ZID36rFvBDrktMA+esmU7Emfh5NwTWIxiUlUYO+o?=
 =?us-ascii?Q?xhdlZJ6AN0LmNE1x0JEcewNNFQ/wYa4XItazRjvBGRBG6hsJwEpZfx6Is9eC?=
 =?us-ascii?Q?9JSrWRj9eA8TTj42/d0YiwvlvyQKI8iL+aL8R8uV319NZKdcqhNNrDVn4Biv?=
 =?us-ascii?Q?ULvGHO1yltb6sD5/ejWAH2DH4zHzglC51JDoWNpB6QuR24FWq/iXIAqN8zex?=
 =?us-ascii?Q?qK6082qUMtdfEL8dgZdu+E8s9MHX+A03pVyulPjkjRIWYKZx3KoA6ajmYm/N?=
 =?us-ascii?Q?Z+oNOwul6/yNUNTss9L1BWM/9694F5rw+b3QHILQ3XB4wTkQElK0XmBSqqT5?=
 =?us-ascii?Q?qREnl+l9KlF97Q4Zl6RtNJJHipRnmS/fyr3FblM5kgU9t1dx/xfvk+3mLD7G?=
 =?us-ascii?Q?WbfWNQ4BInNrvLSZOguG/Vne8ONA3Odxyj3ucPBo3TCYcUR/uwV85xbWahu8?=
 =?us-ascii?Q?LMScwxhnmlQKEALbCD0ckiqVJEf+MDJFWyXTxdIevLGM30enosl3mnjRT+hI?=
 =?us-ascii?Q?wAmo2hsCCjKevFyKEOkbHrTTVUpDW/v7xKSsVrolBGi33kOR0nNltZ5AwYJs?=
 =?us-ascii?Q?vOG8xB5aSCVBT/cpVg1Ua1HLnjjmwVVTyIVzTtV1C+Z/yC9v3vIyWIuKnVtP?=
 =?us-ascii?Q?SwS+CeH94MYNmMOmEI0w5OpHs1rmkF92nWqiZ0JSg8/2cuUjmb48+R5nzYjU?=
 =?us-ascii?Q?B8Gp5AH/EM03BpPtDf5m2iXleGQT+NMPdaWSX76eL8iYZ5eQWzd11zTa+AEJ?=
 =?us-ascii?Q?X7nfLkz54HCmKHiZi78KSCimJgDef2DLPE7Ht0SsZgLxpJ5iHdkYOES+b3W6?=
 =?us-ascii?Q?rRgnZAjprHwbG6FScG61X46EgsqrrZwqj4RyX+e5J8Qc9IXVxdOvvtdZXsuZ?=
 =?us-ascii?Q?larUo1Ft5sY6aLWnQ8B4WAmjeLxYbngJ5preRV6p3PoRl4lP?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6345916931ED235714DD34C2FA9AACY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89f333a-941b-44da-702d-08de6255c311
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 12:22:41.7522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYPv4PGtHXF0wDbZKw6VWI+1CdLXsFBMLAn4yxpHQ7ygu+CWJI9qnWPfEhe8CxaSQuFMlfbccQ2LbUGDxCLoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
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

--_000_CY5PR12MB6345916931ED235714DD34C2FA9AACY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Tao,

This patch series looks good to me.

Best Regards,
Liu, Xiang

________________________________
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, February 2, 2026 2:24 PM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is e=
xceeded on init

[AMD Official Use Only - AMD Internal Distribution Only]

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Hi Dean,

Could you take a look into the patches as well? Thanks.

Tao

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Saturday, January 31, 2026 5:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is exc=
eeded
> on init
>
> When we load the bad pages, send an in-band CPER if we have met or exceed=
ed
> the bad page threshold. This aligns with a previous patch where we sent a=
n out-of-
> band CPER for the same case
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 469d04a39d7d..dd7d837b52bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1715,6 +1715,9 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>               if (amdgpu_bad_page_threshold !=3D 0 &&
>                       control->ras_num_bad_pages >=3D ras-
> >bad_page_cnt_threshold)
>                       amdgpu_dpm_send_rma_reason(adev);
> +             if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
> +                 amdgpu_cper_generate_bp_threshold_record(adev))
> +                     dev_warn(adev->dev, "Failed to send in-band CPER fo=
r
> exceeding bad
> +page threshold");
>
>       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
>                  amdgpu_bad_page_threshold !=3D 0) {
> --
> 2.43.0


--_000_CY5PR12MB6345916931ED235714DD34C2FA9AACY5PR12MB6345namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Tao,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
This patch series looks good to me.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Best Regards,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
Liu, Xiang</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhou1, Tao &lt;Tao.Zh=
ou1@amd.com&gt;<br>
<b>Sent:</b> Monday, February 2, 2026 2:24 PM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Liu, Xiang(Dean) &lt;Xiang=
.Liu@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if thresho=
ld is exceeded on init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
The series is: Reviewed-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
<br>
Hi Dean,<br>
<br>
Could you take a look into the patches as well? Thanks.<br>
<br>
Tao<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
&gt; Sent: Saturday, January 31, 2026 5:11 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao<br>
&gt; &lt;Tao.Zhou1@amd.com&gt;; Russell, Kent &lt;Kent.Russell@amd.com&gt;<=
br>
&gt; Subject: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is =
exceeded<br>
&gt; on init<br>
&gt;<br>
&gt; When we load the bad pages, send an in-band CPER if we have met or exc=
eeded<br>
&gt; the bad page threshold. This aligns with a previous patch where we sen=
t an out-of-<br>
&gt; band CPER for the same case<br>
&gt;<br>
&gt; Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++<br>
&gt;&nbsp; 1 file changed, 3 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
&gt; index 469d04a39d7d..dd7d837b52bf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
&gt; @@ -1715,6 +1715,9 @@ int amdgpu_ras_eeprom_check(struct<br>
&gt; amdgpu_ras_eeprom_control *control)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (amdgpu_bad_page_threshold !=3D 0 &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;r=
as_num_bad_pages &gt;=3D ras-<br>
&gt; &gt;bad_page_cnt_threshold)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_se=
nd_rma_reason(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;cper.enabled &amp;&amp; !amdgpu_uniras_enabled(adev) &amp;=
&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cper_generate_bp_threshold_record(adev))=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, =
&quot;Failed to send in-band CPER for<br>
&gt; exceeding bad<br>
&gt; +page threshold&quot;);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (hdr-&gt;header =3D=3D R=
AS_TABLE_HDR_BAD &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bad_page_threshold !=3D 0) {<br>
&gt; --<br>
&gt; 2.43.0<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB6345916931ED235714DD34C2FA9AACY5PR12MB6345namp_--
