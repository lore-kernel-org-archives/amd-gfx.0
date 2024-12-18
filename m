Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBF8E77187
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 16:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591A310E1CD;
	Wed, 18 Dec 2024 16:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E9wOfc9P";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFEFB10E1CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 16:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMjU/+4Do/dyiCHMssqkpE/l0TTHMexLbW+vbM6uvVNOjUUUOWDAyPb1lt4BrnPr0/0tmsUo7icL0OdJXZ3Gf78RTDGOliACru0emv+3jHkiB/ljocpKXs2VF3SRjBhyHmcH5li8craB4NcQTvAMTxCa9LJTIpf2pPsCC16tR9QjXwctqOYJ8W1kukiAFfwa8RisXn1OPbBiuEj56Ua1A9wrbdxv0et417mO7n3ofcoIfBDiqXqbIJ1kRJke5hqvL5I23rrn9RoGTlV668l5RVxSHiZp0MXu1jXoRZNo32vIojx9JdtVxLOH+/b1oVOpW/Wbkg04rAAzmyLH7SunKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBRWy0wz76RRfkF3UL+AATGXo7/azSUK9VbA3Iv45Eg=;
 b=ozHOPYM3JWEirB/1OtFwiK6fUEBOHSwwYI8Oh2My8TtlOkdNT7UEZbyMl08vutiM6KaLkFRsseWiaSbsqv/ghQPL7YNxIej0eYDNylWCCdgFiNbo5qr20aI/6vGiWoIFPdSNukL77I/7uGjnni8pPOvpg8wWsNCqTBi/h16Z7/Wx/hIK7CsK904HAhVhiDfOsisLDCrXNeycgElF2WzV4RL2pbo0bx1nhIhhENtb8Dwjn+nIt/G0OkljfiS8kyebhM2E93QChAnqo6GOejvvIy21CwI3HQscXudWlnQUL3/vTR014ptYIrV0nZzM8jyhFNUGNrz04zfgdlATMkPm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBRWy0wz76RRfkF3UL+AATGXo7/azSUK9VbA3Iv45Eg=;
 b=E9wOfc9PVZblBC0uppRTWsFZ1QSrg4LPMDg5DAo7k47QBMeQA6wzxvjMOn9Z+uMtuZNzqQ7rgPW51UGV2PEA9/Q67KfPruOQhyaAk3jjUcW3jp+OUza0sqaqkQvB+A0+N6Tht7VXlnxloqRxMdRPlwvCNYuUWb1pHu94KBteLDw=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 16:46:08 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 16:46:08 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Tobias Klausmann
 <klausman@schwarzvogel.de>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [Bug report] Regression with kernel v6.13-rc2
Thread-Topic: [Bug report] Regression with kernel v6.13-rc2
Thread-Index: AQHbUWUGrwzIpjZqAkic9tNvX9Hge7LsNAHQ
Date: Wed, 18 Dec 2024 16:46:08 +0000
Message-ID: <SA1PR12MB859906B3658D04A797CF388BED052@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
In-Reply-To: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
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
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|SA1PR12MB8096:EE_
x-ms-office365-filtering-correlation-id: e9f94f6c-37b4-40a1-7646-08dd1f8378bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3hEZnD1jFnoA4lmdBBEsdM4B2fzdUK+SXLCZn0bOItgSIPFVsYJBf0+FdxXM?=
 =?us-ascii?Q?jdhry+98TUHa48zSyu3XaFU1kC7Brf3wbNkAFvKb+Wi+b8UqY2Y/YUtcqhjR?=
 =?us-ascii?Q?JE0aWsHtj96zeWQCc9mh12pIc8xc3K+nJwfYTimHtRWpY9T1/RiimcBIRwD2?=
 =?us-ascii?Q?tEC7RDo6NBlcumuy6ejLP2zUG6alcnLeeHgNdaKCWZTYEoUDHJbgKJixKV/V?=
 =?us-ascii?Q?/6MDa/sk5AhsZGCpopPS5lv0I1bOZRCB71LjvTY9DRp5Bj4XJ+iBHsVypmXI?=
 =?us-ascii?Q?ptWLgoi1oANwa/aVYFVfhySepuFW9LrvwZt4tKQgYjVL62tdXM0RxQjg2not?=
 =?us-ascii?Q?1qaFTrpKyP7hbaVAsW8s9VF6lqvXkNqld7qpkMB6vRxNSkThizmcUoe+tNfM?=
 =?us-ascii?Q?M7iBD16NmFZykrrQV0vzCnAv4Q1sBrqkXa2mWw9zXh8KyB2j5SRyvgd2m+rL?=
 =?us-ascii?Q?xoM5J3qIexdcT2lQl5OGlcfbZ40O18uqtK9U0VUemlnv99gZGFMmK7hDn9XV?=
 =?us-ascii?Q?z1KrxP8pPPxGnPICEdRjaewpFXBC7OU4lYLtQ7lsw79T5MpEX15Ajt/j/HM/?=
 =?us-ascii?Q?vvLb1oZysqYEc2Yioq9mfC5pgmkj08f5o6KKq6gUua33GTIjjQUQrRWE/wJj?=
 =?us-ascii?Q?WyIKtWvK3n1gQxyaDpx+4UE45+BbughRwQOy7JT5+gRXusJ8mvf6gCNVXlnb?=
 =?us-ascii?Q?Ew5VXoWHj9eb9kS31dxVYjXFCXT9CawByTmOxHk9QdMlYv3KMJf2/mCowHZN?=
 =?us-ascii?Q?pIL9A3MXO/0MMsbLKEguOQmaJqDxMiO10h5gLf5U+KcI1fB+iE67K+ojwPpv?=
 =?us-ascii?Q?mq5t/+LDafP1mdvwCnQ5e0YIFP7wPsV9i0c+Yq6TT5cslMgPUhcCdcBPPY6g?=
 =?us-ascii?Q?e/ebTt9LnVew07DFPVZkHu3Helfbde+F6im1PtF6W9t3zYyebOtcxJXThGYH?=
 =?us-ascii?Q?PwhSagoIpicE5tvIkLfuwM8cEUTO4QoTvBOGjlsUJXXRE+CObC8c7bwzadt8?=
 =?us-ascii?Q?Iu3YINw/BNUWnlJrJYrn79BG/b/I3y0zxhXawpiwjM+uadn5QlPQRrTolNQT?=
 =?us-ascii?Q?s8YtxMFtUfqxfrdpOTNFETq5MbtnL+ivy1kF5GB4Wh8a3vxHh9AxRI6fnYuX?=
 =?us-ascii?Q?OhoMgDJyCfba66UPBnnjquxyA59RBTcBwdelDBCWJyQvG1Jp98nBsIGPhjFW?=
 =?us-ascii?Q?yTOdHARIq29DwIw26KJ5WcxEDVRoeMSk+jsNkdNW/DUi7B7FgUy8uxyVd6CR?=
 =?us-ascii?Q?6sduh6HcMQr4my1RlDEDmSel3NVAXczoGCCwNKz0rDEKQAqwin8x1lNv3ob5?=
 =?us-ascii?Q?JVITUidCn5EjQ4WYfgJM0xlfqxQbFgVy35kR4q190Q5qk2IO699omc1UQgHx?=
 =?us-ascii?Q?ADhVXrCm6TSjnVtZqsrjncgCGFn9CDu0tj8Cmx2lucULS/Kn+wKDvtddtxrI?=
 =?us-ascii?Q?bL2sTuR5EX3I9Kby0XkXcHXL9V4pNXyk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vsCA5HyGGs7e6tMrMWsYsYoiqv/RzuGFY+gMZcnL88S8zh2yp4CTg936ub4N?=
 =?us-ascii?Q?fghfAQZC90EqFSUoVH330yl1a5VxdoLxKpoBRvbx3ZAxAJJ9SXhcd77FLYBt?=
 =?us-ascii?Q?o09eozsT/v64dU9js92XnIV5plarLR/udGCFaRPxWev8wE1mQE0qql0d9DgJ?=
 =?us-ascii?Q?DLF2b9egnKznziTFPo/Zxki3eMNnI/dMFGXkE0nxUip1i0gLgPQrlkVUe3Ga?=
 =?us-ascii?Q?w6PBbXYec0eU2zRkZDtE/u4X8ndL6QOWTky23DLhiIgeNhVhbWc/Y8QxGqg1?=
 =?us-ascii?Q?ogyrom+0t3oTmMPDMtVYJYsWMBdkj2zaeJnWVQCp/VWM776zfYuAPMM4k+U6?=
 =?us-ascii?Q?0deAVxudN1Sm2Xwfp6i4AxHmY6bh1auUarUUWX5rWSHxR/HiXJSr7OVSUVBy?=
 =?us-ascii?Q?T2OucQ+PHjDOie9/5GN0t4JwoY8wtGYXz6SJBc89BsjpHVPjlia+rpI1RxFu?=
 =?us-ascii?Q?KbLfTTCjtXK+xg3Q+3HzIUXtFnkF88fit/xwgCs9CIWdVEQBXTApFvLKDr0M?=
 =?us-ascii?Q?zHHmE3SIYsLfUTgnk8vqvKXOO+hZdGMfjR6q2VDu+KNKXOJXD3uXswe2g2cd?=
 =?us-ascii?Q?i3rrzFGeXO2vlAmGoeaufnXmbnwniLGPkar969b6qPwJ6R7kUVy0OJXA1frj?=
 =?us-ascii?Q?4YMJ7/dTfiEBycUloIFmXytroWfD4JNHDKq0lIOY5RRxyribrXAq3MJ4D//m?=
 =?us-ascii?Q?X5m4sFIz1KkpvKfCmrkYgzKLW2pqgUKl/tAF3/oqKOoms1cJr996kJaecCv/?=
 =?us-ascii?Q?AvCoN94o9zyBSCSauBtQ8uD3rA8fAmXixQvJmCxRBoVtPhjTBdZKbNfpUfrq?=
 =?us-ascii?Q?L4iMbD9sPWtj14C5hZB3T5oc0zCH6OP+ust8RNHSay2SIiXcoocKj0FsXuSp?=
 =?us-ascii?Q?r2pc4jg8mrDUGIpfOp3qp25wB48qwFqtFvwP9xqKL0I7EUxuqSUgUzrw773R?=
 =?us-ascii?Q?Ya4coWjfk3MN7El2oRlpk5JTo2D2zh5cELMCeDSoNpzF3Gl6P47xPtXtUP9k?=
 =?us-ascii?Q?xDc9x5oRJAw7RDcCuf01enPzTLm+RUcpt5eHcFjGqrTwa3hzi3kym8HUNEiE?=
 =?us-ascii?Q?4lwd17/TJ3F/KkRk7cpvroT0XFUls9l9yEEYT9mQaOLTqxZ6PHuv+kdxTZsN?=
 =?us-ascii?Q?zUvRb7omoa+hiczOr2SRBPVhp0KlKZRf5O5nDetQ+231/V3jhZyU+KtWsyR1?=
 =?us-ascii?Q?ec2VlNNQVNAfPZKY/8uUFeK2P3n3osIaPsqcILliWaO/9lC04eUeuObYNAkO?=
 =?us-ascii?Q?ZwWEC64UlRUbr3j+9mjfvwpSuXbzdcVyvX1qmCv/gimwHOBJ7nojiyTVWmyD?=
 =?us-ascii?Q?mpCS+5kVms/Mq06OAF4+zalsCKmqfy9SreKkTyPIqHm+TspxrK5tVCFPTtWk?=
 =?us-ascii?Q?Q8dwQVCqWtJmwvS4X4aMl25n6+WV7LZbvLvPAeWBoEug2qSDwTeWFyKQ8QIe?=
 =?us-ascii?Q?gSw3GayWU+pOYwDtoehKLo7y7e/TCwhpCToUSWXrpTeSCcQJ+/sX+NYM3DGq?=
 =?us-ascii?Q?KQsNSX46EqJNRZ9naI2A2wEbKYsKkVxA0vxM9EnkPxMZ471CMJTdmvD06doo?=
 =?us-ascii?Q?rhTdHPWw++x8WJCR+pM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f94f6c-37b4-40a1-7646-08dd1f8378bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 16:46:08.2827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gVLT5VvCtvlIc6IAKhaVanIDTHNexblWAo3sft/NRIrue/v4Iv6MeXXrY1oOJzmWBo+1ASrgQ+fvDsVfgA5mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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

> From: Tobias Klausmann <klausman@schwarzvogel.de>
> Sent: Wednesday, December 18, 2024 10:54
> Hi!
>
> I have been hitting kernel messages from AMDGPU since v6.13-rc2, for
> example:
>
> [Wed Dec 18 15:56:24 2024] gmc_v11_0_process_interrupt: 10 callbacks
> suppressed [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhu=
b]
> page fault (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
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
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
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
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
>
> This happens when loading nontrivial (~6g) models using PyTorch. There is=
 no
> immediate crash, but if exercise the model for a few minutes, evetually, =
the GPU
> crashes (sometimes the whole machine).
>
> I bisected this betwee -rc1 (which works fine) and -rc2, and I landed on =
this commit:
>
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
> I am not sure what the causal relation ship between the commit and the me=
ssages I
> get is, but I thought this report might be useful.

If I had to guess I'd say that somewhere used the pdd->proc_ctx_gpu_addr be=
fore add_queue_mes is called, and since this patch moved the init into add_=
queue_mes null is passed to the GPU and we get the page fault.

+Alex as well for awareness.

> Since I am not subscribed to the list, please CC me on replies. Thank you=
!
>
> Best,
> Tobias
