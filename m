Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5388CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 01:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134A7615E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 01:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 134A7615E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1CD6E5B6;
	Tue, 16 Nov 2021 01:38:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630056E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 01:38:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaCeFlRRa3CViRuuGXdY4iWNDLCbJ3rpw58gkr2+0AAKyRoFCBPe88bRcjcUWRbosYwDaGgPvoDqNsharxCf+xkKCE8GihK42zZkw8LA2RbKxqC91sIts5YzH+ea9WImStk9JVYeZxpQz4tH7OreGDS/uuR9YnpXSAJJgsVFVG2v92l+Cm42g/0BISMa+3v6H9+Om8ol1smfKKkt/VvJ9+h6fFBaOR/R0DYKcgPsXLdVVJC5nBAO3O6TlTC7WWkgHfQKZ4teg510gUMX98BjnWOkAmt6pE7Fu+d8qNKcX2F/4kBqb7BpAu/FaFCPZ7uGb0YvfhVBULzBqSHWxQ3JBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWDqua7fuPAYN7NYNBFh0vOLvl2N1zFCA1bv/r3Mr0A=;
 b=NFPfJe4jzqHgHvoulrZN2sA7Wm0ldDyh8HY1uuZyeFSb6r257uTootmLAXoaS+ccovS20GRHGUJNHftY0R6i5koYiZ4cwU/FK9uRlceikor2opmIkUxXiG0R2SFYPr3jC3MEYcuzqwBW096lA6MLk/fC60ozYXGkor9fs33m95Zw6QB/hlrwbE7FvlLDO/tuyV9wIxYSwS+MXQf8+X12fTRXZHGnVokFisTN850wYmaiPl+lh6cVeYsnlevvUZEuPtXVSG9WeMc/MfmPLACVqBqXEwElgLTqwDJtzP5GY5nLCF48doPaa/zSwzEj49a4uQwKqMBFY44peF6bQfwlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWDqua7fuPAYN7NYNBFh0vOLvl2N1zFCA1bv/r3Mr0A=;
 b=DiYCnpW4kpfx2sXHJq9Op2OM+nWcrkIP9Wch5/AbEPPchaJ3JL6yveRgML9gSvXFaPRznqwANVhgMA/z3RZp4dh83kj3B8uqYtBriBNROl7K5nXD+t4ng6KfocLonjC/OFpOWaYKj7+0loKasBMpt4mfhyuOi7kzgkN7LBB/ayo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1707.namprd12.prod.outlook.com (2603:10b6:3:108::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Tue, 16 Nov 2021 01:38:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 01:38:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Remove artificial freq level on Navi1x
Thread-Topic: [PATCH] drm/amd/pm: Remove artificial freq level on Navi1x
Thread-Index: AQHX2fRbigleggaEIkW+umaS88G9pKwFYULA
Date: Tue, 16 Nov 2021 01:38:24 +0000
Message-ID: <DM6PR12MB26190B66861BE6A7D746E168E4999@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211115074216.16025-1-lijo.lazar@amd.com>
In-Reply-To: <20211115074216.16025-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-16T01:38:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=cc3b2510-e46f-442b-8a48-023074efce63;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 012fab63-0051-451c-8d85-08d9a8a1c7e1
x-ms-traffictypediagnostic: DM5PR12MB1707:
x-microsoft-antispam-prvs: <DM5PR12MB17078327653D12FD20314FD3E4999@DM5PR12MB1707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ciew6KQUKA74rtGnrAK8SKhJ+uElCgfu4ORlEn4ydWUX73UCUqH/pJVA6JTokB7ex4L75MG9Hw7FsmIyOGqS/70V+ORtwYa/IkXUTx5tJvUYdDQD8xER97MrbfRqZ3HPMnYH3y/JqIMuW3PLc4A/3jHs2TOKXxwL0/BbfNO4Y3gzeIFELIlj1tWOZ4hdQlfGonFRkQNK7xXrm630SU+lPK1lGtYI45PVNAEoDwAL+zQDN+r8iS0FV3jmoanbDDR+q2NWWxHZv7mUs7ZD+oaDS/5m7cOOgeBXlfUWEJ+qMzYE5OUMeV9WjSFQ1y/xQTXxDawGMUR3zRDz+ss6TNvGhP6NgwWyvv8oan+jFoBzb9VAAH6TnevWOTQHVv7mndpSsasT/Gfbp2sIF3FzN+51h3V7VNrzTATNyBE7I7TTuyCU1m/CpsPGs0JsFA1pB9uInp+Edm8FqXeftQZXtW2/DIOHESTswk3W7aLUE/Kfitf0xMT0h/fCfsHbrbPPkDL0UuWm64evlMuuQuZ1YtljTa3+klArMrqGBbWxms/lXlhO+cjnf5PxpmlMcxgAQHx2Co3Y0+j+n2IbLaAZB0YDWxWcdSAbvi1InZQqbgRC4MSNXpTquZKm18oSOy/HonuKxjtiT2G+ynKfbz7ZqRomW/u0qLtvylOZVcJv3pe00siHOBcDlmAC0ZCxqmE7+292hSMfrmaajG4+j6ORfX36BBHK4WFP1cmVsAqyoh/YCmM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(53546011)(122000001)(71200400001)(2906002)(86362001)(83380400001)(4326008)(316002)(38100700002)(7696005)(66946007)(66476007)(76116006)(64756008)(66446008)(26005)(66556008)(186003)(54906003)(110136005)(8936002)(5660300002)(8676002)(9686003)(33656002)(55016002)(38070700005)(52536014)(508600001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kSFaVy0MV27rVDmDSaj/wIggthGugc2EUlrxqru5d7t38s2/b1MLr0dca4Pm?=
 =?us-ascii?Q?ckAPArzL1UKppxyjLz9bux1Qq27OJr4xy78vd+5AcsOHb/FshNdypu2RzlGQ?=
 =?us-ascii?Q?HclXC0iWkTPal8nwTqxJ4VPdtcF+3qyaKTZx7g7dwEoL3hHh9ipaCNFbpN5K?=
 =?us-ascii?Q?7yNSO3YXAqu3z73hOKgSUSwZRHEjgyPpN2joJ8pactFJH07g1XBcmU+IdljH?=
 =?us-ascii?Q?eJLogbcpF0LJpS8/xON9LNHAq0PsUwAkbGNAFsyrFsMTAGeByazVzAztpXJF?=
 =?us-ascii?Q?JKHbG5uufC2KTmJygzeJVwpHIYgE07qBgOLe+tZhJdCIBP3Arj/ZRRCD+K45?=
 =?us-ascii?Q?WvSc89M8ns0398sPiKjx9KMaa3S3RaTimME5RDgZjDS+2j6dDOSf0CJSGh+x?=
 =?us-ascii?Q?tZo7Nu/T4tAk9Sw68B/O6QJQdQvtH1ekROGgI9zXG+p/JbWqWowSORf7VAqq?=
 =?us-ascii?Q?cs/fbIiTIsjdG30TxSAJI/dvpVSyCoWVlY2zrTVavHzBG0V1iCjky2nnC14Z?=
 =?us-ascii?Q?Jf1llYcspbAl3DAX8ZbqJiw4xq+c746ejwO7Mc6kkTSIsz5Ckb4jl6RXoW7Z?=
 =?us-ascii?Q?ssOGp1P4b4SlIVu1i49s350iAgTYGoiQVKb1lsA6E4wHzBrzibfGw3Ypy715?=
 =?us-ascii?Q?Zj5MOZDKYivUs32AaJq7CxeGD9Wka5Sl8Hc0b69krBuGsokhLmfsdtN6NDb1?=
 =?us-ascii?Q?UeySvXS+lrjvq0soG0eHwtGNK5A3VDZ/r/qkjceY33KGXddpW+g7rD8ll/Fe?=
 =?us-ascii?Q?9k3ynmuRC3q7r25MX3P97g5JB7CY+fqctOatrGWqY7Gq4DPL9C2G95pFq3/9?=
 =?us-ascii?Q?BqdzcxiNAJxGfJtMNAihUdKQWRoLhjr506a2zs8Tl7Zgfk6cj7VqK4ElM/qv?=
 =?us-ascii?Q?kosZDA6Wz5ZMsKL/IhikEqDCTP6J4P2Pua+veUeKQ70Ox66RwPSnyUgqYDVf?=
 =?us-ascii?Q?HJ+0ReIRmu8ytyluoSdIjhNjlup3J2qVqIk4wMxAOHEV7Ow0yAUZVAAEUf1R?=
 =?us-ascii?Q?BVwju/C/cJzZmaPuCPbNAOgQ54yfKF9NojuM5Lv0rOI5RBLbgEo+KpnM9fS2?=
 =?us-ascii?Q?vNQxU5E0ZiQ3H8HCBoWV5aB6wUZwgnEGXo7y7iR//bytiCZIJxpVMb64g8sX?=
 =?us-ascii?Q?rp2lBzJ9aoy6DvQz3OEQfEn/BndWfcQ2+qIeGhuY9YzT1YvDvUYfLJpLlmR4?=
 =?us-ascii?Q?mH+1tOSFfp8SkcmD7ZHy/qLYJ/9tvF+/U3AlI9STS+uxnLanX5AzmKB1sjcL?=
 =?us-ascii?Q?BGK0MStxUi7+y5ZNdYSur4iTsjkgtRp8NB3W8F48lDpaqarX1pjiwrmJpujH?=
 =?us-ascii?Q?pqf8c3keyWlgfcnHMX27AGC0j+GgWn661X2mMsCr7swLQih6vVngFWOYft3j?=
 =?us-ascii?Q?06AHq3uTHRUL/sdYzOMysZFUA2gfA7vDDtGJuzIVU8TEZpeyOCj0BEiFdG94?=
 =?us-ascii?Q?N9pVJPDPlp6YU0YjHwpUHfMHlbQl1+sFze5LtaxhsvqCHf3PxOW8XjRmdpqi?=
 =?us-ascii?Q?67vHk+z+J7ap+tc2UddTFfCmDT3q96jjitWOigD9jVUTZOpgMvR6rKpfVkAN?=
 =?us-ascii?Q?jCr+HY7H9Zx/pWknCk8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012fab63-0051-451c-8d85-08d9a8a1c7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 01:38:24.5015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/f+C2STJcRXBkCJt+zZID+8AIeg81jU3TlAwXvSHDoMOx1+ezBMreACRJgUh9mH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, November 15, 2021 3:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: Remove artificial freq level on Navi1x
>=20
> Print Navi1x fine grained clocks in a consistent manner with other SOCs.
> Don't show aritificial DPM level when the current clock equals min or max=
.
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 71161f6b78fe..60a557068ea4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1265,7 +1265,7 @@ static int navi10_print_clk_levels(struct
> smu_context *smu,
>  			enum smu_clk_type clk_type, char *buf)  {
>  	uint16_t *curve_settings;
> -	int i, size =3D 0, ret =3D 0;
> +	int i, levels, size =3D 0, ret =3D 0;
>  	uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
>  	uint32_t freq_values[3] =3D {0};
>  	uint32_t mark_index =3D 0;
> @@ -1319,14 +1319,17 @@ static int navi10_print_clk_levels(struct
> smu_context *smu,
>  			freq_values[1] =3D cur_value;
>  			mark_index =3D cur_value =3D=3D freq_values[0] ? 0 :
>  				     cur_value =3D=3D freq_values[2] ? 2 : 1;
> -			if (mark_index !=3D 1)
> -				freq_values[1] =3D (freq_values[0] +
> freq_values[2]) / 2;
>=20
> -			for (i =3D 0; i < 3; i++) {
> +			levels =3D 3;
> +			if (mark_index !=3D 1) {
> +				levels =3D 2;
> +				freq_values[1] =3D freq_values[2];
> +			}
> +
> +			for (i =3D 0; i < levels; i++) {
>  				size +=3D sysfs_emit_at(buf, size,
> "%d: %uMhz %s\n", i, freq_values[i],
>  						i =3D=3D mark_index ? "*" : "");
>  			}
> -
>  		}
>  		break;
>  	case SMU_PCIE:
> --
> 2.17.1
