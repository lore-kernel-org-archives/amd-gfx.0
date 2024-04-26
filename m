Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1440C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10105112555;
	Fri, 26 Apr 2024 18:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5c48KBna";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5FB8112555
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FebEt0kNF+IqK/f4IdRLVNEx+2fXkK3IpAi0sbtA3jkMeH6zZ0sI4jeudF4pHII4UUhcDNVXxU1XLdreC80obdVOoj65tJclMxdVExxC0s7sZhpeHcwtuuoQYCoRpizZ0BH7/CZXALz9N2Qtz2qOiBexoPViTqIIzUE0ZK3ewwFCsLhbFDGURzEic4jsNp/R9MKsoVwVBzn5d57ARH04B11gHATRLq75RSV/d5tQSnPuJuYvBdADTpMy4a/uLN4nMPnnZKlZWzJF5TgY4RbLi6T9i8lsWV6xi7/BBNN/tF3K9uIyX9P3RhS4kW0NkKFWqGTQEQotZP7PEpyHANNSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/wn6lBpk4818TOM89IRC2Ifv1g6shevHXvipNhO4wU=;
 b=btAjHUUxDmKx91SX6fotjqPkmCr1PdUz+E8BxSMJtfStmSCSon5Df5EPPbr3xtnbDm1Pz7iSGK6fDGg+WxoYZm2MCyKmEcaAveRfRdR5g3bqSCHk3O/WEdwe2zXtiVlwl1kCeC5XHGCaudwT3ejSSw5xsD+KoMpMtYVvW55uRsNf6YyU/P56WFzUt1kEvCGHevgw4iOVaEZ7bpDrVm8jojpQycvJwq4TXTPQjkhxc5mhm6juybhCgcYsKSV895ehgrrjAu1PV0OgZc1b1X80S6ibV7G+87lNBUTycyxPbzYOT//0LSfnQr9uoCGMuE+d3v+if54NmqFgg2ECe3i3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/wn6lBpk4818TOM89IRC2Ifv1g6shevHXvipNhO4wU=;
 b=5c48KBnaregzRhiFn4GGq1D3fhen9WkTucn6fPMNY/c7vbEDOsioSxs0wSpJjhfHXODm6tR+cob1a2JZ8B4T6AgML9R0RxIgXl+QtfMSpTy4DTumlqH5trY+XGkRAuar6xFRtqyAAbVx6A8OFBFCbh+PRKJA9jDDRMXL/ZyOTok=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 18:23:48 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 18:23:48 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry logic
Thread-Topic: [PATCH 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry logic
Thread-Index: AQHal44YJqcaEVKxE0e+k257DFTSmLF6PCiAgABSNhA=
Date: Fri, 26 Apr 2024 18:23:48 +0000
Message-ID: <SA1PR12MB8599F20B90F6B3B2270391FDED162@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
 <20240426035742.90560-3-Yunxiang.Li@amd.com>
 <PH0PR12MB54174BB456485AF0340981E78F162@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54174BB456485AF0340981E78F162@PH0PR12MB5417.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=93226658-ca43-4250-bd8b-9bc4da01c771;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-26T13:36:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|CY8PR12MB7753:EE_
x-ms-office365-filtering-correlation-id: b0bd8297-b1d4-473a-ed2a-08dc661e043d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?uaBZXGRow3N+B7FEbLWHxZlYm1RfrZk/fkoUU4BAsPUPwsiwRhi3e41TFiKX?=
 =?us-ascii?Q?OiS9mIwJvFm4tLw/VTyvYBWHPiYUD2HpH0ypJhYuSRdgu77qiawX+65FVa3Z?=
 =?us-ascii?Q?YZwPo+cPEn6xqQGeqdAZnvva7j0oAZ0P/PZAFHUwfYU/kJvUQHA4HYblAsVH?=
 =?us-ascii?Q?llMPEhc/MeXLSV+G9Ef+/pOCQu82Ilq7guI4WTKM/ykQsFNI0ISdfcjtwoia?=
 =?us-ascii?Q?1JX2wJA2iE+W0S3btfePthfEfW8GWRxtGIrjBlEBiNCNpcTXuEZN4E8kGsQD?=
 =?us-ascii?Q?kAiM5z4joA1m0y63iBU01nvaqcx8i/rg6ZJHWELPV+i3s7O3dI4jld68tx+6?=
 =?us-ascii?Q?WlXhCtsetF67kX+TuJu9Lt83TtjUow7fSwOkmmuCoV5z0aW6iAD89jf9PTrs?=
 =?us-ascii?Q?1ceulRKHHtmKi4knSzotItgcU0Vnpgr9UVSysGHVXDWh0Zf8af72U8CqVBot?=
 =?us-ascii?Q?arCU0IL2ttWGUjbNEiyy7jnvHpJhNyuifuNpnyesWs8JHHON+mp+EN5xjJgl?=
 =?us-ascii?Q?65DsYIQtuPgg5D+Bd0qsXCd6AurxmBh4z6ZLl/ZxDZSBogsY/xv8tsGEs8vn?=
 =?us-ascii?Q?Vk/LUU/5NJ4mgut33DaTGWzlbAMIaY0+jbTqCIh3rCCs7bieM1hXn+TdDKbD?=
 =?us-ascii?Q?ikZ4DVyQb/x9l5+9Nn5UR7fZD+Y9v9b1KjQrMta/K22O58LdpkobVPSlMWSG?=
 =?us-ascii?Q?LlABo1XTWRIBFcTw1AOHk0nvWiud8aqrHWMX8TmwAy33bWbfpGx+7rBAMr6J?=
 =?us-ascii?Q?3vAu8RttGAX6qrfiNY2VcOBGg2YT4q7dx9wbP4xZk/HuEEJJGtOcSqEPpQ69?=
 =?us-ascii?Q?CA4WCJB9R4EBN30dR4jM9jpeKAQXSpsZN8r9Z5p6CEZZWyEVLDwkXwEeCdgL?=
 =?us-ascii?Q?z4BD+zihbGoMj0tGjfhG+ouwnlNOBZV2JTpqDvlGQOhx2DoJucaqgetgHMec?=
 =?us-ascii?Q?B/KpxK8zrdF65UlwQPq2O4ueIhfTk4YdSKBAUoI3I2NZXLNh5sju8DXrCF7Z?=
 =?us-ascii?Q?ZDrBiubim+TZ2d2+c6TMKnuO5ws8Lwam8L2vQdEzMGurrVya7q75RCXykr6i?=
 =?us-ascii?Q?ZaBRifQoewyZtq1PNTbwSyXRSJEKcXX+45pBeum31cD3AtYm84+kw8AILNIL?=
 =?us-ascii?Q?7pIYgpFSCNcgFF+RQrq3nA9r+/fOGVK4olMH5/Nt7tKUWamfcN0LP9dFcnym?=
 =?us-ascii?Q?9pnr7nmsH+rnPFns3+kA+33+LpbCp5Ufon3bQno8lVvYNb++WDxkA0QxNVFZ?=
 =?us-ascii?Q?a5hysi1ucqx5CqZF9IpvTE/S4nf54tIMHJLHLx//dEpALCT8PHUq4oGG9VHR?=
 =?us-ascii?Q?OWr6DQnkCy3bdDyhGzh7dJ4+BYk+SItyamcmgXJnUy2k6g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d753bXMJoaYl0dTcoZYz9Ey6zhucT/d0irtMcb37WRzszI+KuZ2Jyh0NJct0?=
 =?us-ascii?Q?bX5cMz1ndFn8cg5m9YAqKj3P+ACM5RzA3w1ZRDMGdFXjxXlYv3TKX9n48wBx?=
 =?us-ascii?Q?OphGc8WhnSyiHCjt3wI8d58lhcZK3TaYC8a1WraHEoiIFwHu84q9strDmZQD?=
 =?us-ascii?Q?jOO9Op9LcjN635CsVVgauUQCqMsZwhl9Lei2ZneAsnsXkxAB8chGpSjbbWrk?=
 =?us-ascii?Q?B5BndCa0JVyp4jgpjJOok0kG6ZEgB61tCCX6NmALsm36kn7XSl4TpKWXvcji?=
 =?us-ascii?Q?UHtbQy5fIkCQXMSMo9u+7bTFI3NxTvqJ5QdvjFx1nlI0Wg3yyfP1P/xLUO7L?=
 =?us-ascii?Q?PvqVMKKY07a/RuSD2qjct8JlLV83HmQO736hS2yLfjpmx6nmJvWlnBsw5kzK?=
 =?us-ascii?Q?+gwF9f7Ya0k7XiSk6A9Xp9AANWWo4hiKsK3CTZO/9nd+zlYS2DUNe+rM0Aei?=
 =?us-ascii?Q?v75LGbyscRtdb11x7/xXkJeJGbWizkWYitiRWBn3clMn88/vkLUbVL0oTLn1?=
 =?us-ascii?Q?VCjuYZBt7IgNj/CFXTaQaENj/+SgW/FPub8GUkGJEoCBO5BV6DTElM8X8Mi5?=
 =?us-ascii?Q?4F513UcYdAmESNOrRNn3wjrua9XutsBWZD42KScu3ndSeU0ZvsgEB6NDvuZ/?=
 =?us-ascii?Q?5/6UqAA6Lo1JmPJ4j+vVM/w/pXh2PO9gvkOW0zVekWbytSRd/VsppVkN2m+/?=
 =?us-ascii?Q?vAJPxe8oyx211KpAKt9/Ke+BQjkBgev0dfhaJ4qot+9e7ok+Iz44N9f/DSd/?=
 =?us-ascii?Q?RVSVqWQZt1gkQN3lsbP1I3hD/5zrhXIpjbIj6XrejzmEJA/MFAIMh3HtM3Uk?=
 =?us-ascii?Q?V4YB7EBE+bdfNqIj1F2kmRKX5Zt/88Cmv3qRLZKbaodzDo2Mz0ZUgqV24eDT?=
 =?us-ascii?Q?SZaiVIv8Gkqa+3HJ6gk/56rV9+d3jKSVA+/i5nz86kaOC2/oYG6Kep0UtwUN?=
 =?us-ascii?Q?qCtDZZndgt0tXmS1myRe6bMWYJorh743orgkmjiKmEGI4jlRHy2vy5wVVd2K?=
 =?us-ascii?Q?uRTKnnL4mJXA68zyjifKrwHQtCoJ9+sb+8Rg719BNv5pdQoX8JzNKu62bbxz?=
 =?us-ascii?Q?qJfpD8ZkGXXYi1Fe1LLBorl4a66LYvBzizIdbBAsOn3Sc/KKf7dmDhRIeM54?=
 =?us-ascii?Q?SA3urCeSNa9Z7pyl4E8c+Tsdp9oGbwvTHH+4NhO4Oxv/FFrkih2TMj+njvqY?=
 =?us-ascii?Q?/DXiSIl2YMsmpQ7WFRgabxNqzmutTDZ0SCzAVBXHQ3ndk00C02C2P0IxG85I?=
 =?us-ascii?Q?muTDm73lafGXOmROXvKntFXmrrOC+pscK/pXlQWg2rIyw7M6Gl5TRz7tT+mR?=
 =?us-ascii?Q?1YgXmfgMM41kxi9cdlUjvyKFIxTTXqmhROPw7lyQ85tqGQD8eQjYRfTkqKWP?=
 =?us-ascii?Q?vdMJGwMV1T3TcLLj0nus2stN2wDXNxxE2kGWZhsHyLn/k9LMJRfqOrIrwdaM?=
 =?us-ascii?Q?I6HDs+DzvSvz//WiaR/5A3gX8dC9U6tncwndxCGHZRWZp7c8G+twvbUKkYg9?=
 =?us-ascii?Q?Wor+dVJfvLX8P+NAMWCGDnxpsYT6ckywMsbYpz937dPteqSqi1zWbeYlMQJV?=
 =?us-ascii?Q?ZrftFCcVA1zRWlwQgek=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bd8297-b1d4-473a-ed2a-08dc661e043d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 18:23:48.5433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taXp/ORPyAzwQhmjjsq+JWZiMK4424gKUzSRtB85E0NIrpc/jrhgIAJrjn4uFgdLIJH8PLO++CvAHw6xjf4uhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753
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

> Why remove this?
Oops it's a copy-paste error from the previous revision

> Need to call amdgpu_virt_release_full_gpu(adev, true) before retry, and t=
he same as below.
I thought we talked about if we call amdgpu_virt_{reset,request_full}_gpu a=
gain we don't need to release full gpu, I must have mis-understood. I'll pu=
t it back. Yeah checking the code it seem we still need to release.
