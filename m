Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C56E77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 08:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84BE10E33B;
	Thu, 19 Dec 2024 08:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PkeUInpZ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95BC10E33B
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 08:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/n5q85CFuTuN8mdbZWfFEjKQh6Mz16FcWn0pKcv3ezAcni9SUzYRu3I6MB0UZ0bKNnTQyySb5jkkONy7CLW0WHnLtABnrmeZZ2nPD+txGpj3lnUqMGFkMyroCvYYg7g5ZpQMGQdL8SIMPL3v47tlJ27DULI/vw07LQ/bEFt5EyGTyU2hbrVFd2AN6OgMEJBZ6iOD5dBe211v6EqS9sGwEtZkhYlr/mYW/Isj/HTQ2vrcHkAxCHv+BJ1UM8dbnomQ145TsuHqHrZf7HrAcbx8h/XatPKZAXViqCEuamLZBqRg6BsRLJLHorHdcFiDkOkYpVufJL9WQwiWnuV+qeHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsRBuE+nuCkGWPPWBC8FWtXazveW9rWGNoCpuaBavj4=;
 b=aj1qHL/CfFUmtm+Kv5a2aXMU9ScrYqPARwmSWXw6eaVLkw5Doswakh9P7TICtZ7V4YBxwinUrWIuv/Ku+lSY8U3eHZqykTueuvZNqlHczxoRWE3u2loQ9rgLtuC6tM6iMtuHLQF9JyclT3T4eVx3v026SfzRoUZ7nZrqrN3oSif8v6NpMdiKDzIm1rQvLiENMdSPprydIZIboqvtwo0lx33zUiWn+ad0k4h/+b4R+J14j6SrnW3jpmlKvRCZJyKes/+yBOMUUiOEAy/vsLmM3bPnCfBpzJ3gU/sbhxF5z5ahABdY/cNQse2VAx9YtcjOKzwbyCIOn8y+VmVGK/rtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsRBuE+nuCkGWPPWBC8FWtXazveW9rWGNoCpuaBavj4=;
 b=PkeUInpZ5fpz+VUify3GQrMSXooAGN/8BV64L1YzfZXPc3sE8tTNQlOKJn/ByawuuN6oi0y/qNXeyRzW1QFwk5cE/xj3lJCMswx43eOySA5ivnkVpuYSD+1s0U4gysLpHLghfK4XUVPd9Kh3uB66HBqNaJAZ6gJCXuGteoE//XE=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 08:01:16 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 08:01:16 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, Tobias Klausmann <klausman@schwarzvogel.de>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [Bug report] Regression with kernel v6.13-rc2
Thread-Topic: [Bug report] Regression with kernel v6.13-rc2
Thread-Index: AQHbUWUGfslbcL05S0qwZkVRMIlnsrLsNeIAgAD9n9A=
Date: Thu, 19 Dec 2024 08:01:16 +0000
Message-ID: <DM4PR12MB5152AFC2089AC7C7F67C800CE3062@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
 <SA1PR12MB859906B3658D04A797CF388BED052@SA1PR12MB8599.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB859906B3658D04A797CF388BED052@SA1PR12MB8599.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a68ea0e9-8139-47d6-b9b1-67f336e8a35c;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-18T16:39:38Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PR12MB8253:EE_
x-ms-office365-filtering-correlation-id: 0f12265f-5e0b-4dd4-7561-08dd20035069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?002lkzQ75DnmQiskCOcHBILPzznQpZ0oFgDK7cwlYlszf5keDQux/2yFLXWS?=
 =?us-ascii?Q?pxQF0WQSvUTAM8iyYZJUQV3Vwk+ihflNydTmCxG9qRx0feCYGGwQ8ViKHBNV?=
 =?us-ascii?Q?fpOzA1jI+tHT2FzQlqjckQRf5vIh6XIlAnaDYuYoBYndxNlKen6asGXUX4N6?=
 =?us-ascii?Q?UGTLktV7D0gyc+tFlY5EytWpr43VXayaaecVuk9qx9NlUWyPNaJ4HQEuNEDx?=
 =?us-ascii?Q?N2wG7fOXbyj0tGF6CrBpck8BNNdRPAf4Z2fJSA/gUH7yibGXHMbHhUsa4C95?=
 =?us-ascii?Q?VaUSsXAluQZZVdG9RlCkq+IZ79LrMXz42+ox6sXU9X22grF2ywFxpsAAPxrl?=
 =?us-ascii?Q?GXrsES7U1N0BRAAGVgVT7hUU6RnhUSSoZoOh6BnuY5WPqjWEQz4tqp5rDjMi?=
 =?us-ascii?Q?5spQpcGWsUAITpDL/FgsE4JNaltw39NF9D91KlMwynh13dD+bt9k8I5uNeiB?=
 =?us-ascii?Q?BoM3ePbMUS0cPRBtWpIYQbAlwtaFbI4qkPXKsIQ2+xj6obd+uRAS7eWubFCh?=
 =?us-ascii?Q?/1EbXqqSe8wHAP9ZOZ08ImZM+s9yRHAu/rESAdVhDZcZ0qUrm5iVxJntxx7g?=
 =?us-ascii?Q?5M5S3+2+g+0Jc7pSxKcjOMD4YLvR7v6WrMg1owQPqIO1GAUuHnT8wFi0Tjja?=
 =?us-ascii?Q?0q5mJ09ZwO865y21ocXRY7gE8YuRz6aNiBxfXtrMvi2kXVomWtHwhNUkuUXE?=
 =?us-ascii?Q?eWG92UuoxXqIqaJv8Gazqz4XCZ1unyiLqdh9sKSLy80cM5VsKBM8G056JJWT?=
 =?us-ascii?Q?g1qOYgLtLi70oT6uChnOoP3RK4cp/MiQ+JPYgZG9Qf8pAhf8IRz5/zoTx8WH?=
 =?us-ascii?Q?iFXvfEn++t9kPD4H3LKXG8+DjwCAx+/VBOpyXcPfSF1LzEogDzrMVd2y/sbH?=
 =?us-ascii?Q?KDHxM5sn2Q0atN2Ubi/N5qtNC6UIdNL7mVwUQeTYz2qoCtIzwntrLHi/XR34?=
 =?us-ascii?Q?MJdgnizHlvows68NOhDXhweV7emiRLuVqzNSvuy4l5/T+JAlGsZBx8bICFgv?=
 =?us-ascii?Q?mlToNu41JCqHFtYB2WTa7iWHsR1y9USUBosq0nYGB8NYwqqPj+vFNKQGxOpK?=
 =?us-ascii?Q?AvK0DbWPtHjnOS1HsNUczI4vTVF3DFiFIQfpAzzuclSgulWGgIPsf8Ee4EYU?=
 =?us-ascii?Q?CYKg6LN6soirJb83/8ZGck0OVAQI9gc7kZlWw1Pb9KwMJS53mmN3dNUYLUwA?=
 =?us-ascii?Q?gSgZoTYQJE6jwLvVWB6+RS6O1Q9Bbpr8O8R/BATru12OQgqA05J7AxRdpBmw?=
 =?us-ascii?Q?xmKEpBhpeDbCJFCHbPuJddNkc+EXV8+8ifvqsd/YyfdSMoxDDjsKuLuesSdQ?=
 =?us-ascii?Q?jZIyYZsPdXHKClg8GoXq8P7CmAXztfY9k1IoV4dvtF1+lyqasqTyKFdvfEui?=
 =?us-ascii?Q?pkoHoXJdW9+P58YL781y0fgjSpQo7ZUntlJx+K0krFZYEcunxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1zGH29XFTwtx/QKlouB7q9wqyDqDn8UeVXAzu7f1W/D51L6CBOzq93QIUxhf?=
 =?us-ascii?Q?6rmjkGbVzVqNjTjchAkcxj1klARiiBiDhHoG9uIORNdOEydVADRUBqiyoO1x?=
 =?us-ascii?Q?6z6bAUsW9JO2nv7sWmNq+RBa73Ke66f8RgwD3zNLe3FaB5ykT5nrMkM2QK/b?=
 =?us-ascii?Q?bKU+hJ4+moskuVdXqp3GdeBqlANDQ0bysgv4cOKHO2ge5idIHc4OI0OiWwoJ?=
 =?us-ascii?Q?sYLNLrJial6YY/UVU0QIowY6b5c2umFGKUqsqBdQM3m7DH7W+HXs2nWkx+4G?=
 =?us-ascii?Q?z4jj/QnXJo9sNHcwDNZyvvNDN87WRXz7ufqEt2/gqeC08T7w19JMdfGhJFq7?=
 =?us-ascii?Q?JKAQD7dKu9+ikQvU4HN8irRBhlAoNy8FmFMvOMfSeP8IXTSeee2lG7t5ocBq?=
 =?us-ascii?Q?b42mc/rxWqRyIAGClFSdyzGCzjQI8qEwhYUfAID1Cg6Ek8ukRAh2TewspDwG?=
 =?us-ascii?Q?7PzVuim4tlJ5sM+ouRn8QRxTaN9xMNpPlySWArZnJMZpS9XjlZ4a5PyEnK+1?=
 =?us-ascii?Q?44/LHmpGoCePC9gBqvA56cVhyosl8SWW+b22STcnPl8tKU1ODtre0cLNjXd+?=
 =?us-ascii?Q?F9kMNkMdjxoyVwfK9+ogwFPYVuK1lck7X+7g+8YS2pvvqm82rSYqUIbPHpra?=
 =?us-ascii?Q?cxF3l4N6lg7S7RDN6h0/h0ZZKSlc3NvdcCGQ6WBmzmJl6fO8eXEhCRNYKbL5?=
 =?us-ascii?Q?coWi4ml9PG7Hg2mhDRnj9zrL5QcdKnrNfcgT0naglXn0pEuIm+Vfoou9ns5L?=
 =?us-ascii?Q?Zz2UfhlrBIwW8hCQa9mqfLhYf7zy51cRoA1rGn6DYsDKvQQlwKC72w656Mz+?=
 =?us-ascii?Q?ubZ+8J7wSbX3bC+W61tOOZibZcdxfo0hUQv2Id2EPPaWE0FoUUzr8lN11G1k?=
 =?us-ascii?Q?ROLWiyc+KsgCUsn5w94U+6GJzQ4s988sH60dUvzcohh4EjIPJzH6P4oIFCio?=
 =?us-ascii?Q?tD2xytXo1/08fcMWjiVsjToSYIbvKQZ3/UwX9hNmaeM35d3PLLriKhKXNrJ3?=
 =?us-ascii?Q?DDXH946J4cM8Axv6vwiAHf/EKpU9NIk/pzEbuytUOqztTFjtB70rB2GnRgoG?=
 =?us-ascii?Q?VbGYdarqfF2o0x4n9czBGGlBEQnpjx76zi55IhoFUtnija1mvpAl8hyCeroO?=
 =?us-ascii?Q?ygc/DMh6tilSpZestEZ623tI9dqrIocNw2l0dro66xkXCNHhPKEjQHmvo/GM?=
 =?us-ascii?Q?rfBTBSxpZZx5y7jsgptaMtzWMNL0OxO4Ha0su+jXbZA0xrPG/XyfruhH80QN?=
 =?us-ascii?Q?TVRch+7Ji7vy1BFTSw06NP6+p9NM1Xv8Ts+wbUdDm1vlDDrv77PASnQhG3tR?=
 =?us-ascii?Q?vH9xaJVaCGx2CNzOvlHevcA2+9jnF7Pp5+F5+ocPSvMk+kfHiUrbJHGN42s6?=
 =?us-ascii?Q?4INWGMcvxCXCbLU3sR/ef18DhHIEPb/eJPuco4ZYodsFR408qTFg/zZfTgEj?=
 =?us-ascii?Q?A1JvFjzfmvDZXu0m78z67vhiRelgcF4crMcGolK96eVJv5C6eeyDkqEiHfz9?=
 =?us-ascii?Q?1FaUt3PttHny0H0RFYCJViZxlJgzv4uxnuyfpJKowVseABcF3eQ+4GHefvY5?=
 =?us-ascii?Q?6wl5j+2hC/yg8BFybBA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f12265f-5e0b-4dd4-7561-08dd20035069
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 08:01:16.2392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtsFSqxt3l+aZraavsZsCZgpnP0hL6MqQ4u2ep6wF4Eu+qzMfFX6TXTtNPXyW2KUF0H/26wEHFUmCTFywsV3zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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

Hi Tobias and Teddy,

-----Original Message-----
From: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>
Sent: Thursday, December 19, 2024 12:46 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Tobias Klausmann <klaus=
man@schwarzvogel.de>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehlin=
g@amd.com>
Subject: RE: [Bug report] Regression with kernel v6.13-rc2

[Public]

> From: Tobias Klausmann <klausman@schwarzvogel.de>
> Sent: Wednesday, December 18, 2024 10:54 Hi!
>
> I have been hitting kernel messages from AMDGPU since v6.13-rc2, for
> example:
>
> [Wed Dec 18 15:56:24 2024] gmc_v11_0_process_interrupt: 10 callbacks
> suppressed [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00040B52
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          Faulty U=
TCL2
> client ID: CPC (0x5)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MORE_FAULTS: 0x0
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> WALKER_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> PERMISSION_FAULTS: 0x5
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MAPPING_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page
> fault
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          Faulty U=
TCL2
> client ID: CPC (0x5)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MORE_FAULTS: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> WALKER_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> PERMISSION_FAULTS: 0x3
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MAPPING_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page
> fault
> (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
>
> This happens when loading nontrivial (~6g) models using PyTorch. There
> is no immediate crash, but if exercise the model for a few minutes,
> evetually, the GPU crashes (sometimes the whole machine).
>
> I bisected this betwee -rc1 (which works fine) and -rc2, and I landed on =
this commit:
>
Hi Tobias,
With this patch, PyTorch works on my side, please help verify this on your =
side.
https://lists.freedesktop.org/archives/amd-gfx/2024-December/118058.html

> commit 438b39ac74e2a9dc0a5c9d653b7d8066877e86b1
> Author: Jesse.zhang@amd.com <Jesse.zhang@amd.com>
> Date:   Thu Dec 5 17:41:26 2024 +0800
>
>     drm/amdkfd: pause autosuspend when creating pdd
>
>     When using MES creating a pdd will require talking to the GPU to
>     setup the relevant context. The code here forgot to wake up the GPU
>     in case it was in suspend, this causes KVM to EFAULT for passthrough
>     GPU for example. This issue can be masked if the GPU was woken up by
>     other things (e.g. opening the KMS node) first and have not yet gone =
to sleep.
>
>     v4: do the allocation of proc_ctx_bo in a lazy fashion
>     when the first queue is created in a process (Felix)
>
>     Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>     Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Cc: stable@vger.kernel.org
>
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 15 ++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 23 ++--------------=
------
>  2 files changed, 17 insertions(+), 21 deletions(-)
>
> I am not sure what the causal relation ship between the commit and the
> messages I get is, but I thought this report might be useful.

If I had to guess I'd say that somewhere used the pdd->proc_ctx_gpu_addr be=
fore add_queue_mes is called, and since this patch moved the init into add_=
queue_mes null is passed to the GPU and we get the page fault.
Hi  Teddy,
 It enable MES debugger before add mes queue. And MES debugger will use pdd=
->proc_ctx_gpu_addr.

Thanks
Jesse


+Alex as well for awareness.

> Since I am not subscribed to the list, please CC me on replies. Thank you=
!
>
> Best,
> Tobias

