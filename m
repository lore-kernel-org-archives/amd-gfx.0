Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43943C5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 14:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C951910E214;
	Tue,  3 Jun 2025 14:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="emJcc2jt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DA310E212
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 14:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFFc0GpVujE8aBVHaAAlTcmnvdxwgy7iTh4KjlSfcYxuvHMWNJx80qozO+UPufbfJda+91WpFkmInkKRExul+PwC9wGacs0DRzgHsMJQCp3nh0LMzklDvkOvoYgq98vSytIbMQt/AsW++jxoDGrmLZWN/tAYLEz1ehTPzWmo15wNGW1ZHzy8SOTWTcfpb08ZNC2QkUz7cNaS4ESy2zx1CWAs4WmVtl18ZAYiCNEgP4hQDjF4Y3WD1JGu/AQ745oxE7PFrU7+kgn/8abpqvodyxY3UXjITiJDEqpJyP1vwqk9Ewkg7kFw5m78L5861FWM4IhBYQa/a208eJZ8MCnqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnSg6+FDLHBS/5mld+VKtbQYb5zOia3ajyeRpAmwHk4=;
 b=BBU9g9n1eXQGuHoDTmkyLvhLDMYg6u0hCE5uQSZBIKnVPACaMnSNwu0BZtph2PzpWMprI64VBHUDUeuPyt0yzocQCjKaCdFiPqvsmsuHxQYYFMvWlaTRMF6iM+R1FgfWQCxs2V0h1lcW3wOYVTSKsRY/hK75jJJstjv6rQh/s6f3d1C9/jBa8RyLNj1rwGL7vZytsv3Jrf3eSP8rypjAouC5gyw5kDmqaze4dhgh5zxzPRP4ohZWkEPFsP46b/FtDDGE7BkmwgEAO8pE03gFiDUUkRd+zWKqx1KQB8MQs3wHOAlTsz9haa1ioZLFHmKcFTG4l0hPHs3EUEcn7N8u3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnSg6+FDLHBS/5mld+VKtbQYb5zOia3ajyeRpAmwHk4=;
 b=emJcc2jtDnLm4+IrJAxsKH0SwNQ5PMCBV/eI5hsQmQXRHo0xydR4ogCZ2XGKGHXynYzc9obWQ/y+E8MsHdfbhvSiLI1daoGl4jH8z4bhEYQ9qM4WiLQpBU8gVtBGQEnUVVoo0oIfpqHgKffiW/y2YxmyavO2ddeJncHYjgIBWVk=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 14:43:55 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 14:43:55 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH V2] drm/amdkfd: add late initialization support for amdkfd
 device
Thread-Topic: [PATCH V2] drm/amdkfd: add late initialization support for
 amdkfd device
Thread-Index: AQHb0G9qwZ1nx+MB402uIoYmEwYkZbPrPQgAgAWKoACAAMJmcA==
Date: Tue, 3 Jun 2025 14:43:55 +0000
Message-ID: <CY8PR12MB7435AE559A98FB6A3A053C45856DA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250529075802.2932430-1-Jesse.Zhang@amd.com>
 <CY8PR12MB74350320629D6E41F5519A8E8561A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DM4PR12MB51524E91A24CD22D5B9F63ABE36DA@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51524E91A24CD22D5B9F63ABE36DA@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9e7c0ba3-aba9-4bf0-868b-6f983cd01eab;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-30T14:27:35Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH7PR12MB7889:EE_
x-ms-office365-filtering-correlation-id: a0a6f576-7b33-4938-ffe1-08dda2ad10de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rUMkNGakp653AymtM/3UKNxqcHs2sGUbe0owpW8YNzWCAntRFVd3EXKq7ntI?=
 =?us-ascii?Q?SQC4Vwq+Fu2x+gfCvIyBdD0bKvvs2EosFVSLBfNaBR5RQjUX2V9duRD3TtZs?=
 =?us-ascii?Q?+OVUBhgu6finckg97wY0lT6QxdX6g3xzszvJnhz8qsmDa0CGFIA83MD2pKsW?=
 =?us-ascii?Q?NQYqKkJeUaLmv5LvyjPYqHcQPAEv/12/2YFUA4QjXU34LROI4xzP4iGKltDN?=
 =?us-ascii?Q?2tcQQgr4xxE5Fc0YYUUIpgavJIGglyT/HbuCvYBLzc6LoMOMNkQj1mPDGaW+?=
 =?us-ascii?Q?flUQ0AhfZVHNm6w8qFLKecHUKl1qIaU9WWAWPPpVODM9WXuyISFlX+4OFjTh?=
 =?us-ascii?Q?vHnlB0uevlrLenI4iTLQF1BnWM6CeR7tnK1jr1gVcXu44ZqvvWzVObMudFvG?=
 =?us-ascii?Q?c5zAozztYCkSLraBc7KYqsCZVx/128ZXO0ULeT+syNgXRwMIq+P753b4CdJL?=
 =?us-ascii?Q?aCWVJGEnF+VYxuE9fj8Kwze5Fb5NBExZsezvbcXT4+FlNskB8uZHpOwyW5CS?=
 =?us-ascii?Q?tVZ3edz/k6/VriPZPJeOoYz1J5VPDj/56ljwa2NDYV2Hl8lgzWFWnE3uj8BF?=
 =?us-ascii?Q?jWbruW3I6QbvWMwyvGlNvde/HAP+1+7IR8552H70lF0O29UT8iSi0M08RqMQ?=
 =?us-ascii?Q?mdxVr3e/UnFGD8i0rdM6+9xnuSZBdYFqXARNiJaDENU60Gns5fXIkUBaSsRI?=
 =?us-ascii?Q?O3BhTDC4Mh+SOTX1wC3LFgWBIq2oHiPt/BgvzycKJNmkj5GFZdIFS44XqoJF?=
 =?us-ascii?Q?JXKFKeL9WoaedTWadzCIEetr0ZjpH8OyHfN3P/DVulRSPD9BWxc3XVCVJft2?=
 =?us-ascii?Q?UjM6LGzHVY5Jpjj+on8BtQZZP6m7OCN9dUB8wtY+qWHAZxJ/Grjrr20Cg9qX?=
 =?us-ascii?Q?ymZYxNUAF6N4CXSzaEozKrQJ6u0bPc+uSEPySgoagOpQvkGYKlA86rU+dAMG?=
 =?us-ascii?Q?nSNxSVfLqDI461RiEMaTLtMnUwOXdGjG3PKT0t4ZGQsq3zQ4x3N80o+t3rCo?=
 =?us-ascii?Q?D5AROA9q6WiNTDTAhsoQxibLX7sOvirsDnjINJCkoo7HA+m3bajIWcTCngqv?=
 =?us-ascii?Q?1ArSMznM4Soqqt9tBBNUVEbuA2XUPOzwB6wGmFu07qYH2c6mOsgyHBElZKJd?=
 =?us-ascii?Q?8EDbPQM+QmJMtvQhJ35uXwJgKhnZVZ0QNg69cGWZCiVJQwZpaJfSaAft+H5a?=
 =?us-ascii?Q?ylZFdEUU6xs0lPiZ4K+15ArSn28yoyQlG8AcIWfrnENcfWk6igsWmNblxu0q?=
 =?us-ascii?Q?HPonyvCFFZ80oKQApRto2ljG1uoZFhOVxIy9u7yI33x6EHb/GEZ6gJJynzn2?=
 =?us-ascii?Q?tvwMCapNs6+KFBNxCXTW6zzQ+0cGnwlvApK7dvfy4aizsgrCIyCB1tDajaER?=
 =?us-ascii?Q?4NMJBZzxrrdB0qjRsxG9xlSkLZYepR4qizrMzSdp5p+DnkCDtut8qT2vvclM?=
 =?us-ascii?Q?s5oxEnNwTCU0J2aU3zhAEe2Z7M+txdJpbL71El71hqYqUqpgf+HDIMBJwdnT?=
 =?us-ascii?Q?Yd/Bk2xSiDhRrC0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0d0TFHL8PvsUqImDsB6qJa5XZimuTenofdtOJbOWj9tAz93+XVS5M7swzDJ8?=
 =?us-ascii?Q?Zj77KzQrTWPfdwfl8VbIoshTgYK6klj4n7RdJcYcHlBqIFodufym3Uh7cb2E?=
 =?us-ascii?Q?A+kEfLQnD8lCfNDtSAvzbeLeczXwLwFcVcBv5JkKrsBrfqcbNAI0gkZCPTRB?=
 =?us-ascii?Q?pFlJKDQVj3cmavwbiz7V2eU/YJSoZZiQo5DQBGDlqXI6Weros/j0yTEg5NUa?=
 =?us-ascii?Q?COzYPOK9x1W+mqcRPScIe/fn5NmAm1rwScBUaLalsGww5YkY37L5zuyF5SOa?=
 =?us-ascii?Q?VOphkZfAeGP8IX0Nbh2UY0m/zMZYU8vEYRufTZbT6g2pJBIEivvnFujK0ucR?=
 =?us-ascii?Q?Pa7pKJ9WNNB1SY7NfRVuqqQPeuylS8/gdkkSoXz2j4+4xblvXtjcpIg/qJVV?=
 =?us-ascii?Q?1YkZfmF40j3V89AIcSw0yMh74DBuUlJAF02o/4STkUBRBzy6MvzQPiDqQf8e?=
 =?us-ascii?Q?+DloOYObYMzHlBVB46rDArbFZ84bNiyIOFDLfu9oyGqZ6BmnR880sT9/NPya?=
 =?us-ascii?Q?EKNRG+xWn0V3knulGxOM4B5NKMAdAqR5uD2WwmhMAvoWaADbAAlNtZ5RtHM1?=
 =?us-ascii?Q?evGZWFBy6AufrRqieZYCRi1MJGL5tCa0Om0lc5HyXhPbpjorILGJeI3JS+m8?=
 =?us-ascii?Q?7AG6VHvn5PtNlM1yduXLWIp2vCdHlf3QEu4j7i3VJYWNJ2NOkmfkRdia94g2?=
 =?us-ascii?Q?PS+VBIvdJPTKtOAl7Psu/Rn7TQwYaLAhdCjPvYyBKB0mCU3mmNoTca43NWh0?=
 =?us-ascii?Q?dvXTslMRuqZ7FdKK1zZWQH0nMI64vjL8G3u5XOUlmRvakDhbeoaCdICFunxo?=
 =?us-ascii?Q?MTD+WOqEoxetYGEchBLo5jsH62wPOIDBwfJfjtBhgRnaFZiW7xAQcvqty9QJ?=
 =?us-ascii?Q?bA3obXaK46mu3KtRtjX8f96vORIL4mMwOLSE9UMAjN5lX2VVucclVs3RMCdC?=
 =?us-ascii?Q?ttVFsXswRmzj4B/MKK4tyJZCCbkRDm7T68Y2pHa9TxZRJSyF6vetJPlnQFGb?=
 =?us-ascii?Q?lOatknK65y2HLpFBKxqaj1zyt5NsUHMm9ljdueAhx43ZkIxeBmZndnByEde6?=
 =?us-ascii?Q?2KnXhHpMXRrTi6G1KoSS+H1p/iNttnuuL3QAOVVchF3vm+qdZ1oi9b9d/sVw?=
 =?us-ascii?Q?WCByFyoTXKhYKvfqAHBv+FKJDrWDze9tXRm7UEDl2dm70mX0n6/zJdQ40FvH?=
 =?us-ascii?Q?c9HOUKzr4xBLHl7vCCl09ci3N49PSxba3Q/7aXzT7SPLYQrZg359E/mO0UPY?=
 =?us-ascii?Q?aRj8B++2xmfAu0u+kwvpC1Erv41ty9/xWZHXex1/VecRZrcFtR5+9ZGuqAAZ?=
 =?us-ascii?Q?O/Pst83bAwSwMzAjdXjARoYGujeoSK3XFW2w02q90e3u2Ei7k6JVM1JRAuzi?=
 =?us-ascii?Q?AssAhkm4ssTbKqrg3LLePAkfbeJFB+tVUYTjd03PQweIA9gSvbazJWn+vQ/p?=
 =?us-ascii?Q?KFh3vDtvaIBryxRHQPc1XoWLEiUeLhjEoEowmW/69M3C6iBFNI/7r0rb6m35?=
 =?us-ascii?Q?RuxUyGvVdNeW5Eargnoj1IqyOYl0RR8D3oS1lh2BYkD8NvPSldEGA9e58LX7?=
 =?us-ascii?Q?gC5PKOagmHLGh8xmsqA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a6f576-7b33-4938-ffe1-08dda2ad10de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 14:43:55.2127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cirv/rQQBVrKlzRPBNWh9zDmpnTCqdyA57M9JzBBbMuzNeMgy27FnbAr0WCVTK8s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
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

[Public]

> -----Original Message-----
> From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Sent: Monday, June 2, 2025 11:05 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH V2] drm/amdkfd: add late initialization support for a=
mdkfd
> device
>
> [Public]
>
> Hi Jon
> 1. Is it possible to just push KFD device initialization later during the=
 KGD
> initialization?
>
>
> The challenge is that SDMA reset capabilities depend on SMU initializatio=
n, which
> happens late in the IP init sequence.
> Specifically, in sdma_v4_4_2.c, we can't directly access the SMU version =
early.
> We rely on smu_v13_0_6_reset_sdma_is_supported() to query SMU for SDMA re=
set
> support,
> but this requires SMU to be fully initialized first. Hence, the need for =
a late-init phase.
>
> 2. From a brief look, it doesn't seem like the KFD would operate (let alo=
ne the KMS
> driver not surviving) if late IP initialization failed anyway.
> Chunking KFD topology settings into separate phases seems a bit awkward.
>
> If late_init fails at amdgpu device init, it should has a fatal error . T=
he driver will
> unload kms
> kfd should exit as well.
> how about kfd get the reset flag at node show show ? will update the patc=
h.

That seems fine to me if we're already setting a few caps during read anywa=
y.

Jon

>
> Regards
> Jesse
>
> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, May 30, 2025 10:48 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH V2] drm/amdkfd: add late initialization support for a=
mdkfd
> device
>
> [Public]
>
> Is it possible to just push KFD device initialization later during the KG=
D initialization?
> From a brief look, it doesn't seem like the KFD would operate (let alone =
the KMS
> driver not surviving) if late IP initialization failed anyway.
> Chunking KFD topology settings into separate phases seems a bit awkward.
>
> Jon
>
> > -----Original Message-----
> > From: Jesse.Zhang <Jesse.Zhang@amd.com>
> > Sent: Thursday, May 29, 2025 3:58 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang,
> > Jesse(Jie) <Jesse.Zhang@amd.com>
> > Subject: [PATCH V2] drm/amdkfd: add late initialization support for
> > amdkfd device
> >
> > Add support for late initialization of KFD device capabilities that
> > depend on information only available after IP blocks are fully initiali=
zed.
> > This is particularly needed for SDMA queue reset capabilities which
> > require sdma.supported_reset to be populated during AMDGPU IP late init=
.
> >
> > Key changes:
> > 1. Added amdgpu_amdkfd_device_late_init() interface 2. Implemented
> > kgd2kfd_device_late_init() in KFD 3. Added
> > kfd_topology_update_capabilities() to update node properties 4.
> > Integrated into amdgpu_device_ip_late_init() sequence
> >
> > v2: remove the include "kfd_priv.h"
> >
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 +++++
> > drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 +++++++
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  6 ++++++
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22
> > ++++++++++++++++++++++
> >  6 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index 4cec3a873995..d80745f60873 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -232,6 +232,11 @@ void amdgpu_amdkfd_device_init(struct
> > amdgpu_device
> > *adev)
> >       }
> >  }
> >
> > +int amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev) {
> > +     return kgd2kfd_device_late_init(adev->kfd.dev);
> > +}
> > +
> >  void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev)  {
> >       if (adev->kfd.dev) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > index b6ca41859b53..6c8bbcc7f177 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -160,6 +160,7 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device
> > *adev,
> >                       const void *ih_ring_entry);  void
> > amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);  void
> > amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
> > +int amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev);
> >  void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev);  int
> > amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);  void
> > amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev); @@ -410,6 +411,7
> > @@ void kgd2kfd_exit(void);  struct kfd_dev *kgd2kfd_probe(struct
> > amdgpu_device *adev, bool vf);  bool kgd2kfd_device_init(struct
> > kfd_dev *kfd,
> >                        const struct kgd2kfd_shared_resources
> > *gpu_resources);
> > +int kgd2kfd_device_late_init(struct kfd_dev *kfd);
> >  void kgd2kfd_device_exit(struct kfd_dev *kfd);  void
> > kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);  int
> > kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm); @@ -433,6 +435,11 @@
> > static inline int kgd2kfd_init(void)
> >       return -ENOENT;
> >  }
> >
> > +static inline int kgd2kfd_device_late_init(struct kfd_dev *kfd) {
> > +     return -ENOENT;
> > +}
> > +
> >  static inline void kgd2kfd_exit(void)  {  } diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index d9d8cd063829..b7c0281cb6ad 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3395,6 +3395,12 @@ static int amdgpu_device_ip_late_init(struct
> > amdgpu_device *adev)
> >               return r;
> >       }
> >
> > +     amdgpu_amdkfd_device_late_init(adev);
> > +     if (r) {
> > +             DRM_ERROR("amdkfd late init failed %d", r);
> > +             return r;
> > +     }
> > +
> >       if (!amdgpu_reset_in_recovery(adev))
> >               amdgpu_ras_set_error_query_ready(adev, true);
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index b9c82be6ce13..3aece03ad092 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -947,6 +947,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> >       return kfd->init_complete;
> >  }
> >
> > +int kgd2kfd_device_late_init(struct kfd_dev *kfd) {
> > +     kfd_topology_update_capabilities(kfd);
> > +     return 0;
> > +}
> > +
> >  void kgd2kfd_device_exit(struct kfd_dev *kfd)  {
> >       if (kfd->init_complete) {
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index d221c58dccc3..1eee4d625ba2 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -1134,6 +1134,7 @@ int kfd_topology_init(void);  void
> > kfd_topology_shutdown(void);  int kfd_topology_add_device(struct
> > kfd_node *gpu);  int kfd_topology_remove_device(struct kfd_node *gpu);
> > +void kfd_topology_update_capabilities(struct kfd_dev *kfd);
> >  struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
> >                                               uint32_t
> > proximity_domain);  struct kfd_topology_device
> > *kfd_topology_device_by_proximity_domain_no_lock(
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > index 09011d78f700..052215faff76 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -2026,6 +2026,28 @@ static void
> > kfd_topology_set_capabilities(struct
> > kfd_topology_device *dev)
> >       kfd_topology_set_dbg_firmware_support(dev);
> >  }
> >
> > +void kfd_topology_update_capabilities(struct kfd_dev *kfd) {
> > +     struct amdgpu_device *adev =3D kfd->adev;
> > +     struct kfd_topology_device *kdev;
> > +     struct amdgpu_device *node_adev;
> > +
> > +     list_for_each_entry(kdev, &topology_device_list, list) {
> > +
> > +             if (!kdev->gpu || !kdev->gpu->adev)
> > +                     continue;
> > +
> > +             /* Compare the underlying adev pointers, not the
> > + top-level structs
> > directly */
> > +             if (kdev->gpu->adev !=3D adev)
> > +                     continue;
> > +
> > +             node_adev =3D kdev->gpu->adev;
> > +             if (KFD_GC_VERSION(kdev->gpu) < IP_VERSION(10, 0, 0) &&
> > +                     (node_adev->sdma.supported_reset &
> > AMDGPU_RESET_TYPE_PER_QUEUE))
> > +                     kdev->node_props.capability2 |=3D
> > HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
> > +     }
> > +}
> > +
> >  int kfd_topology_add_device(struct kfd_node *gpu)  {
> >       uint32_t gpu_id;
> > --
> > 2.49.0
>
>

