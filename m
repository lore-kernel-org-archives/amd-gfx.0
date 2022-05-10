Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3966EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 03:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A646010EAA8;
	Tue, 10 May 2022 03:16:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CB210EAA8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 03:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlTA4n4NjnUds2WkJH+IBxqktgeLTE3j/Jfz1+YCqNkTLeJHDZBbrSeZTuQpq/5XAE292JHkITf92c+IB8JNOZGtInO79TKctOWwBntv4sXH13XCsBWzxmrR964Ezcu9k2aXWCe0uTbF2NANAjqvSQqsSy6+yW6MUXwzZhytpYfvrQNNoLbq06ecSCoi50a2lJ1oruCihBxvS7b4Ru6PC5MZKkgOa4hCfBmOVipCXIViXGAHCw1sivbUmzye7YTVSsIDjDJon0jm3YQSqhUiacjxz+Ui95FE5VO93elkWahsIzB2BVYoJuV9shBFBNzOVmZBW1usjehoG69S6Dk6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayiMBRHbMJa/QMEgasugyM6LfebsZ5Wdc4es+nwIdoI=;
 b=RMWNexPdqblhyfGhYcuc2ksfoTB7v+a8fGzJINcamiByk+JEl2b3XcmsQBfZphQtiGzRVU0yqvPy7XPaIhgsf+qt6729XhKvrCGYi1dITFESQHQsFOBo7pBdxCZg/MKUiOP850Ox9Drtd/V2vJOzPISMTkspjld8PDQwKLvHCYWrDDKlHS/0sDGI5zch9x0niaxdyf5CQtj2m96eXa18vYhXDMQFdOU07iBSZDstJoG8Jeg+/QEv7tDTaDyVd35WbiPn0L7OToj+CV9yUs4EK3kDy0QZLPYbbGJsAJeU64gZWe8H34VXxQax/dxyZr2jhnVcH5hCKt25NaPeeV2cCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayiMBRHbMJa/QMEgasugyM6LfebsZ5Wdc4es+nwIdoI=;
 b=vrcC/jchHPAxYWS2iUdHiMGQziXvsX8hGw2CWISZgHcUGq9tGnPYE+w7Mtf+NJem4G3YVVfN8TzkkL/P4y43VNaBT4Hfh/88jrpWCwlpEgNTrnglcgTIp7bHWxHqzcHfFr0ft8xtgdyfEMZ8ROSCLowiIV6HDMJIMGn7s5dNvuQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BYAPR12MB2968.namprd12.prod.outlook.com (2603:10b6:a03:ab::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Tue, 10 May 2022 03:16:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c429:9d84:9f6e:42bb]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c429:9d84:9f6e:42bb%7]) with mapi id 15.20.5227.018; Tue, 10 May 2022
 03:16:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Disallow managing power profiles on SRIOV for
 Sienna Cichlid
Thread-Topic: [PATCH] amdgpu/pm: Disallow managing power profiles on SRIOV for
 Sienna Cichlid
Thread-Index: AQHYY5qc6vJo164Hf0GmbGiHHR6OX60XcTog
Date: Tue, 10 May 2022 03:16:03 +0000
Message-ID: <DM6PR12MB2619E78E00298314319EEEADE4C99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220509114722.124060-1-danijel.slivka@amd.com>
In-Reply-To: <20220509114722.124060-1-danijel.slivka@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-10T03:16:01Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c2092482-0b01-46e0-8bdb-7f7a1becef37;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be0315b0-ce16-4996-0206-08da32336a95
x-ms-traffictypediagnostic: BYAPR12MB2968:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2968BA61854BEB4C660BC88FE4C99@BYAPR12MB2968.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEx9HfU+dx7BKmPZXfJdwVF76OQpA2YiQqi8vSUHgYF1O3pmQlg8yU3TeDpeGy6zKeEeYf6EnezW651An9EEbHxf14mda1JLAbGmyn6ANirOteSxunxWCLPA7m6m1ELSzL3XuGRBhI6s4zOA5+ocmwSoLmqQ3qiSUgvd21KFvQAZzy2ex0/XRcUDh1/q/CNBm904eki6ievxC+64Fn9ffwugDCWoABwXEUHlJvAcZAvrfWYGeKMEnpnzBAjGwzqWgTxn0HlslfmKggXUbnPFAe7xnTjdQmnjqtqQ0CkIUir5dVxOLFSos4+nNN562sinFJVcs/dnIgFJ6hIG7XC7RLi6OyToP+2IbxJgQn3iOj3yTUDhAZ3suKAxgn2d+xWdIjJpg135gdpLosWFT8zmIDRX6cfTEr+dFwLp8qcZIBjyymXLuu8L8LB0dAYCE9/VvNj2eeGy/00o0cwrDqZTg2GSPeZjX65E8PMI7FjJu/eYWZ5jAb8H3tH7Sqpm0Cf8Bh5D70MbK5BdWWrc+isYQLCg6GQgGIHabVkoCLaSD5FKc4j6niTzLGMqfgivrlwzDBg31PXjeXyEyUdwN4/LB+ds1Us9OtE1Z80IywnV6j+5xWcdDUW+fG+fTPA7Rq87/4iXx1n2KAGOUqfa7QUqq5Q6O4fB3EI2g9kfp3QJyYplJVkT8yug3gPf0YVE6k8Lq24xTiVyOG1mRAXLlRC2bA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(76116006)(66946007)(66476007)(52536014)(66556008)(64756008)(33656002)(66446008)(8936002)(26005)(83380400001)(5660300002)(9686003)(8676002)(4326008)(38100700002)(508600001)(86362001)(71200400001)(6506007)(53546011)(55016003)(7696005)(110136005)(38070700005)(2906002)(122000001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+PZSaZpaNoAOjOlt2E0hftdL6N5hr5PmnDqRyYBOW/N+E9UXUrW2YTMlc8wi?=
 =?us-ascii?Q?PeQoggh7KThOEWIuBxQ2sEgFDEN33m7zDZksGNFzVemZCLB8CT0mQQVtSukv?=
 =?us-ascii?Q?B+zMk2h8jKbn0hpJlCNCHbrCWWeiwV7yf1qDTrj0ZpF1GCIxJROpSArT2IyS?=
 =?us-ascii?Q?uzRfJvjNL/dLpSnV7G+FwcyQAbaRfuZGuhC2PKtkXCAWhjdn6l/x3sFRwdQ1?=
 =?us-ascii?Q?qtDoAjtCTzAIddpFm+5ya28rZEfL03kmwcnjl0OVrFjravQ/mAuW9jGbHs4D?=
 =?us-ascii?Q?M/idZr93fCmSCAKBSOhcdC6CQn7jS/d1UsaW18PDEehdsJBw84deWzGG7UWm?=
 =?us-ascii?Q?+gD1nNTwzunrKbin5OzfxFyFL7D3XhRhsxQuukJr7K16oR9He7nilr7Yg+zC?=
 =?us-ascii?Q?OcUl4YVqJYVD3zbYbhh00zMLbjh44Q3+0D3y5g4xre7JgVM+5oR2b6k4DP0/?=
 =?us-ascii?Q?j9iOP8ZtdSKMKQRu1t41TgWAu5KLOLh+PFhkDvQgOxEv+fwvRz/9ZZ0++suk?=
 =?us-ascii?Q?yZ7BnPEzEFKSnv2yNgCpJRTzI9jR1MYCXq/D4o9dYeQLvRoViZzADnf828bl?=
 =?us-ascii?Q?8y9P+luUXJgKT2QWePTSMwXgJ+atz3ZR4gY2iHE8tKRrMsRA8jQjSecQuyoC?=
 =?us-ascii?Q?1etv+fItDwOg9C57NBzPaMmVn+vjj33oZNdwn3RN5cEC/4qYnr3ASFvbvbZe?=
 =?us-ascii?Q?q2ml5TKH7VspBAhFcR0aZRGi3YmLTn3fDW9NU++/tQHaLIYDCdDNwOAj6Oom?=
 =?us-ascii?Q?Oh+GZJI3kvPf8E3EnTVBB6NOvvVjVQuptcYWugVMEqOZX3JxfA2EU7Eq7lid?=
 =?us-ascii?Q?9XuupNRl+p4mmMmuf+3knVjq2J4MdaBksiW0fR9AvZ+r1pbMs5YZ0/F5kUhO?=
 =?us-ascii?Q?7ZDdGjBhFPJJ7qua8yqA6OHyrKM+XmMyn0q4KydDBXp9iqWcoWxfMcYAdbTM?=
 =?us-ascii?Q?MQmr6cbzrFifHr2C9epZUL7guRkDDc63toqOdZQaTsqweqG9si5O4kzGSdGA?=
 =?us-ascii?Q?t6u+wtpqc5IS+6JYAnWnXBIwuPOF6vuAHWzmxnrTavDfAHhUAy5lOivB/sKq?=
 =?us-ascii?Q?OQv2AsdBUFe42YE7BYTvEH6x94j48xKfwDW9MQFjmU44buqmnQ0kMN3NUCAG?=
 =?us-ascii?Q?JoDQQFeTRORX9/SINDDjprAqSZZaDP1Si++5NOJZIBjEgi2Gw35C9tAhlc4d?=
 =?us-ascii?Q?cRmm2dLjoRnowx4T+vvV1ZJmu1PVTxPxMdDq77k6OBjkDgYS5mzafKa4dl4F?=
 =?us-ascii?Q?1ku28egsPO6ouvmWk6iIDOuup+QX7yacJKWffjRLMy1TBH1ZVjf92N+5RU/8?=
 =?us-ascii?Q?/PJrDvuPabHkQjWAQVWgcgUyMRrnGaWOC6BkZbn+QoWfb1GjD5mL+NhJN4aQ?=
 =?us-ascii?Q?5FxD8GeJx8cJFhknxMFt2xZ9Pn9d7vpp0Eq/QBHeuSJmVonMxXFUJk11FgFI?=
 =?us-ascii?Q?oXKjUNDsfAusSQRBjABUVyEJHm7naXqTjiLOXGn6t1uQkY48qpsQQmb1Rp/w?=
 =?us-ascii?Q?pluwDnUGJdGc0Qty+YjIqwEt3oHT/uuabwDHWl3J8VE72Ml9aM6tJDuBIg/C?=
 =?us-ascii?Q?ilMoj9BiepRr0vfBOwKCcu5bfUzt9Wp8OUcObEAJCMAezuZiNER5ot66CLwD?=
 =?us-ascii?Q?BHayo801RMJSYsbHjwRaracbosb4VUxbpFPI9C1IHHpU4dgF4rHPV7O9Ihgn?=
 =?us-ascii?Q?zs7ivAHzclrQE5pxGhDZICpJKUftlUHr3mQeKUjbO/V5/3Rm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0315b0-ce16-4996-0206-08da32336a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 03:16:03.9061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvIkUr+H9maR+l5cL4k6bV2GpLaZ16vLpURjjzHs1k1i1tKZFuDqNFJD/VnCCqdb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2968
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
Cc: "Slivka, Danijel" <Danijel.Slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Danijel Slivka
> Sent: Monday, May 9, 2022 7:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
> Subject: [PATCH] amdgpu/pm: Disallow managing power profiles on SRIOV
> for Sienna Cichlid
>=20
> Managing power profiles mode is not allowed in SRIOV mode for Sienna
> Cichlid.
> This patch is adjusting the "pp_power_profile_mode" and
> "power_dpm_force_performance_level" accordingly.
>=20
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 70a0aad05426..59a662aeaaf3 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2025,6 +2025,8 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>  	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>  		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D
> -EOPNOTSUPP)
>  			*states =3D ATTR_STATE_UNSUPPORTED;
> +		else if (gc_ver =3D=3D IP_VERSION(10, 3, 0) &&
> amdgpu_sriov_vf(adev))
> +			*states =3D ATTR_STATE_UNSUPPORTED;
>  	}
>=20
>  	switch (gc_ver) {
> @@ -2038,6 +2040,13 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>  			dev_attr->store =3D NULL;
>  		}
>  		break;
> +	case IP_VERSION(10, 3, 0):
> +		if (DEVICE_ATTR_IS(power_dpm_force_performance_level)
> &&
> +		    amdgpu_sriov_vf(adev)) {
> +			dev_attr->attr.mode &=3D ~S_IWUGO;
> +			dev_attr->store =3D NULL;
> +		}
> +		break;
>  	default:
>  		break;
>  	}
> --
> 2.25.1
