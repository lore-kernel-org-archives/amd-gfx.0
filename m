Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30444C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 04:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF54061279
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 04:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF54061279
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C716E323;
	Mon,  8 Nov 2021 04:43:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010DF6E323
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 04:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9mZGgM2KGZcV4/59GdI5gpXZtHMO/oB3vPkjKw+eC63qKkIh+cj1G3yNVcrplfZYPynCZt4rVrNxPg41Pqz6XAOWZm6ByyI/MrZWRHaUbLQgN+4waxEfMFmdLrL7AXNVIEChmgHAMipZXkQwQHNacFt8jR4osQh1EtpySYZRWNe5a1ozHnLnWpVZLUr/zruv9kDMy87JlM5mdOc4RjuD+QasC/LIzL7ct2OpjMAizbSbtBnVRZA6xK+5r/CLhPzQRwdP7ahXRrNV4Qfx2p5igd8PMVHkZPJ3lTfRVez14ifiW1hhPMbUQY1wwfJ23vWRFkhT9N8BRYuF+QdWF8dCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MilQZYWQ9o05sRTgbVVtaIKEe6OH5cnrNBwVRJgVL8U=;
 b=YnDumkv0Wf6o1Z3+SM50zEinBTBzSSvQaLh38GoeKGhX+wA0IjNZI6bWqeMODHu1z3mcQn4CRlfNx38RWJlu/KrWO02jLlu9WN5AZTYac2hGxS59WWbLmRDq3UxV/9Arxf4e10zEJiHsQmRD/WgT44piH9ay4n199AHDynFytnHqujmtBqCrrty9bij0dirgY1HXOQd0K2dD7Tfty++UryGZYjZKnELVq5fVEEmdnKqF+eendDgscQdBG7MLpoUUDGS4nHvVb014LprGy7sNQuZCNEsquKyjowApoEvjeUo2vMcydrBDZvrAwvRw6/IVqinBpnRL80eJqFmEpimhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MilQZYWQ9o05sRTgbVVtaIKEe6OH5cnrNBwVRJgVL8U=;
 b=jxuj4qQXiE8VT8HpTFPRsYTrYnZiJq7TypPuIsOEDqiFwrkymxcO/9Sc9bhJXEAIaobpwKdfK3CEJ1ReeCSGBkumASNJGD5qf1FocQbgm6NZ3OnRIGXRXxjKgzeZ3cpgPRtWxs52N8vve7l4W306m3SPwRGMVAJ8h+GDEXudTaY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Mon, 8 Nov 2021 04:43:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 04:43:20 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Borislav Petkov <bp@alien8.de>
Subject: RE: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Thread-Topic: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Thread-Index: AQHXu6U/ZEe6vPjmAkGizCNrJ1mPBavJLxGAgAAFT4CAAAIugIAABoCAgACjCrCAAIEAAIAADb7AgAAExgCAAv/N0IAAmpGAgAKexJCAAASygIABFY9AgAB1n4CAAZf1QIAg6e3wgAA5goCABEbiAA==
Date: Mon, 8 Nov 2021 04:43:20 +0000
Message-ID: <DM6PR12MB2619D0952D42450C79BE9BC1E4919@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
 <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWRvl6ymevr7+kiB@zn.tnic>
 <BYAPR12MB26152EF8CD43290EBE40C165E4B79@BYAPR12MB2615.namprd12.prod.outlook.com>
 <YWamNaMAxaw+/9Az@zn.tnic>
 <DM6PR12MB26199D9E4AD854A4DCF562B4E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWfxtUusQ5w/1agx@zn.tnic>
 <DM6PR12MB26197151C642B89A9C824AA0E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB26191DEE9CEF9A1E49E62634E48E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YYUUWS6vB70K2Y21@zn.tnic>
In-Reply-To: <YYUUWS6vB70K2Y21@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-08T04:43:16Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0c704bef-98b7-44d5-8d4f-f2e881675326;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f40aa86-8e82-40c8-b433-08d9a2724a76
x-ms-traffictypediagnostic: DM6PR12MB4699:
x-microsoft-antispam-prvs: <DM6PR12MB46997F12E85A17FEEEC445B1E4919@DM6PR12MB4699.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHeqSiFOxnjtkuZ5uR8l/0aPRzyICU/JeM8k8pY+E6zXiSH65jID5CgTcNOSpZHETQE81NPpwL5ItOXzdSLXzmx31bxoc8Pes2pypQ4Ve0JMm1hVDLuAdNvywwzNTBJosAohmDLLEtJ52+AE55p/wm0+aPju6MlhJ/tjncV3XIux8uN8qPpEPjblWHMn5hsnjz6vfXPQNrMsr5G3mBrtTXHhF4ofKxZ6fDQKF7LmawV/soHDD3e0UWWDIDT5MXSsCNtM9+3JZKRsZCjSqS9KeG1ZgJkTBftaHhPa+dQavLt0svBlBeaw/8mCOdYhOP9eHa8BkED7Hogy7P4UfXIHvGBclrx1vCDK1b0JwBc5EWvV5CEWLdgKT1iwn3aT9jlfY/74OLUl+bPQKWOFqsYf3tMu4T3AegOcRSYPhGn8CIptquCtyzNiQDCLqBk0fF8KO7iNKZ3EF6Yl8kFtK9CWnZ/4Top6MnQUz+ByKYbXD+blkhIq5mR4xiu/D3pQKQ8H+Xwuz7M4eLkC6hTRl0ATp6Ix8oZjrUmhqgUlCor82tEP2fiiI9KuCBrYuFJ8Kty5Os/xsqTA+4vW+ccxC4EYPaUagnlGqwq9X91WtaaIRCHnhL5tnLWc+7iruBXXAjUlG47SCDTkU9oArtUVhpWb0DuopHpR++iWrw2/KJx88Avr3zy37P98Kp1MmFlJp4KeQ5WsFMP4iT9a4u2HpMWCqCcl5qazf7TtEDYc06UjLkbsMqhpex6z4cKXc8baFaJF+B6n+sBIDxc60z8aLVMuvQUUMG2ChDLhxu817DMTTNs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(8936002)(38100700002)(66946007)(71200400001)(2906002)(9686003)(33656002)(54906003)(52536014)(316002)(508600001)(4744005)(15650500001)(966005)(186003)(26005)(122000001)(7696005)(4326008)(5660300002)(55016002)(66556008)(83380400001)(66476007)(66446008)(6506007)(76116006)(8676002)(45080400002)(64756008)(6916009)(38070700005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dxFbXxO0m2RxcPyoBh7ms1gepz1yfTutioelepYzjE22yjyH4wMapLDidNzh?=
 =?us-ascii?Q?lwEjYsaEJSEH+b8wYxHpf/BFmfivHTeCe6iYMxVGYfsYgpempFRHAezSOaOO?=
 =?us-ascii?Q?NP5q2OKkAwNxfiOgvQjxuE7PK1+yuZLKNI1P+M477jjw+weA1RVtpmlWnp+e?=
 =?us-ascii?Q?alUGt5SzGGpmMflyTLcWi6QsCMlRKwjADPkRKeJBE2YZ3l8YsXIbG+ECxrBV?=
 =?us-ascii?Q?FN3AL6NJIvtGjxStLISHSseir8XfyeQh9bI4W4mgvZzHFZE2ZBpoSTCd+g27?=
 =?us-ascii?Q?s11s+KWQsmkurzva3chLlFggKK/Ulpl0JqkcxxPChMgfXJTbH19KnyR7WNxb?=
 =?us-ascii?Q?9w0bM1mRq2pdf0G6fyjB5uQc8FqjbEbLhKL3L27M4rfp1IYa9uE3rrVPMSpq?=
 =?us-ascii?Q?spmR6kO+q94RRkH3+WZXhDVG+pWz/v6tXlGx0PlVYgbeUKbDApWmn/WIx9el?=
 =?us-ascii?Q?/zKKDanGX4/2jnWqfMhExCjTiFkDJxdywHAGbM973RTTSXDomaLLywjIAkt/?=
 =?us-ascii?Q?vaz5aip9uKl3N4I29FuVBqySgM9MmiZmfY0enM+wLzGVlRIiwSvzokzvgfpw?=
 =?us-ascii?Q?+Xqu5JlBpxBEgVPY5uBoppcFEMNUlsrtwVf3KArTXIuRrvtVpm7kRKaruYeZ?=
 =?us-ascii?Q?Sub8+GUmET8szppQ+J4Vv5QvIrwzh7pgrHaaCyjtQk9AyQnOJo4zBWvlm8/b?=
 =?us-ascii?Q?X+d5xcwZmjw0G72Nm98TEusREiow9fqKnIuW+GoDKr6xJFNYr6pf9mFNFHpW?=
 =?us-ascii?Q?6qfjWG7COZP29KUNQefqIagDpIwSciLPOV+G5mw7CWARyOiVDAuavySnvcpJ?=
 =?us-ascii?Q?72QHUDlm+x5T1O9I9raa4/RbN7ZCpug1u7+HzVgyVRq0jIyS1BTuF9UxxAN8?=
 =?us-ascii?Q?nWAm3rs+y7HQwYw5puU+NppRdBgoYmxDCSWSLewPKVBmuPdPozC4OpRmc8/X?=
 =?us-ascii?Q?5ZGsG6IDSLUk3NjDIq43FxeMBB5Lq4qVK3huZTm2fo4A5aLEZAukqCGxcc3m?=
 =?us-ascii?Q?pwIOrnv3lGlt1j/WqEQx3piFPXhkAKs3HsIDK4NTTYJ+mUusoQq0C2QWHxGo?=
 =?us-ascii?Q?NC+2SfjEhg7tYjSBMpxqHcg5vE94W03uKdyBtoBheTRLx0BoMVRrXKJ85gXN?=
 =?us-ascii?Q?8FWbJwufCWaNoki8zwo/zkWVrKSWRMX5+5aqmpdTA36M0T1nYeSEb9MGmsH5?=
 =?us-ascii?Q?QHh50x9GF+sKMRahb/eCLUFQHPt7iR3ONzthb5897x9gyoOo7QVVv1cT5iNx?=
 =?us-ascii?Q?wfrYrjZxH+BIHt6IVtN8WLLKcJTXWU8q9R+ZLGNxZa3b3vLYQpf5GZmKV9DN?=
 =?us-ascii?Q?wkvUU5Y6ogd3j/dZ3YNTVHsiiiD/Ek3oj5IUYlnJYTUIWA2+FDuaKqQVg2Mf?=
 =?us-ascii?Q?fwocHArPCveQ99kzu2wKciicZd7yjM5Mh/KVia5Nesizs14t5dBMRDtndH6s?=
 =?us-ascii?Q?fCZ3TErtptATYagD5c6FxEVQSck2IWSnKAbSGy/Ah5e4hsdUf+aUpT5LEsVo?=
 =?us-ascii?Q?1zPzRVdcd6XShpyZkN+2D7QTC94bYM1Ukc5ZqUqYs3Q0hfrvHqllhpGR6NuO?=
 =?us-ascii?Q?1o75KyMxPmgaxJUI2q0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f40aa86-8e82-40c8-b433-08d9a2724a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 04:43:20.7731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QNRIf8RGIDQu4uKGT3XMi8KeI+DiL/9f7oL+T6WPctlFMDW7Zvsd+HxHJaKsXr4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4699
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks Boris.

BR
Evan
> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Friday, November 5, 2021 7:24 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris1=
2
> UVD/VCE on suspend")
>=20
> On Fri, Nov 05, 2021 at 08:05:41AM +0000, Quan, Evan wrote:
> > I'm wondering are you able to give the attached patch(alone) a try.
>=20
> Yap, looks good.
>=20
> Tested-by: Borislav Petkov <bp@suse.de>
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7Cbd84356a29
> d5445f98b208d9a04ecbdb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637717083006632366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0&amp;s
> data=3DpkaeF4lIGyQY2Ss0Oq7VOKZ4PaIPDZwltJiqyqRco0c%3D&amp;reserved
> =3D0
