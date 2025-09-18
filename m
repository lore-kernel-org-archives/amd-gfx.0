Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7510ECAC5A0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 13:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA2610E8BA;
	Thu, 18 Sep 2025 13:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5XW9O0Q6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB1310E8BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvKuW6FqKp1FA15lHcI59VNsOxeG+Il7i3G5jLbXkzvcpsm/np9gTFTgujhTpYtuvJCmjjQjTDmgOZ2jZ0D8Z3utNADehuvJE4vrIcFWJcitUHADulfHBf5df9TST0tAYyQyCQ3jYE9fuSG4eFyKA64cF7+el5mrHAIkjw8heFGC/pJ6BZGacBeBZIl3WY8EGUh+0ZfPEocYrcwUnZa1uDsE2dCiJTJ72tZVyAzuGXeFjwNJD24uS5zDmBO/4JfWJ6zfhr0sNBnkZgmL5OMAgmHLrAbb/S/bharJ0UtoSplBWOqKv8uQ+xPMKMs1hGEUaXwC6plzFRWK1zkT+OOI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR0F2m3FFJUc8i4TRUQX5UttmzM/RwuBTymGjzY3E6w=;
 b=OZEMqsYD50Ci+Li/FPxx3G2tj0WCPTWdk7t+z+Dm7QB8fcRXQMJ0j1wlXhEK1HqlGrPfAceInNVvqXXdL4uSbuE5kNKQLy1dZ/LIMdZoHyP9giUeajYCS9OACQ3yKAbh4XPazDwlilzw0OQD4OpsbKtN4SCa4dYp67FoKt0YyDiSp5+LcYu94RBVf9jovbXB1cskerzSk4rR5Du57ysBiocrlWFOAGIH7LPWvAfKEb6MnF+rqf0BqmFO/OZRAdv4aoRRxbbPBGy5mJPytwL28GHBG0eFt0IMublhq2QGZsZihfiqdTG1eTNi8qfJwx/sCsapslyBooAXykNchQcOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR0F2m3FFJUc8i4TRUQX5UttmzM/RwuBTymGjzY3E6w=;
 b=5XW9O0Q6yQOjoOqbgUTs/uwBJTkbQPtzjkzj5Z+6uGmW37BeTj8+3BBLMtuw9a7k/F8ZiGygQ8EFWiyFUnGbdT0xme+RyEW1WOLGo0IxZL3wcVSgiGgPLYcr9p7uCtES4HZwFAtd5iis9mss1W0AScdtXyh/1QVVNcTuVmjQ0+s=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 13:40:50 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 13:40:50 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH 2/2] amd/amdkfd: drain kfd process workquque before switch
 partition
Thread-Topic: [PATCH 2/2] amd/amdkfd: drain kfd process workquque before
 switch partition
Thread-Index: AQHcJ4S5GkooZBGItkGE8JeZvMEFC7SW30CAgAIVUsQ=
Date: Thu, 18 Sep 2025 13:40:50 +0000
Message-ID: <CY5PR12MB6369AEFA12BC5C99516ABC3DC116A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20250917033918.904142-1-yifan1.zhang@amd.com>
 <20250917033918.904142-2-yifan1.zhang@amd.com>
 <DS0PR12MB7804220F7920A96DA14B4FA69717A@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7804220F7920A96DA14B4FA69717A@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-18T13:40:46.636Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH3PR12MB8902:EE_
x-ms-office365-filtering-correlation-id: 66a81db8-1ac5-483f-e87b-08ddf6b8fb15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?fcnwgxMbX2QQ8kasXP/5duYRAbv05g7zttJNThfXSBMTq8PXEe+VjeiC?=
 =?Windows-1252?Q?8qzkQTCQKG9P7TLtw6lJfKK5nqa5L54alOr4N7PkcZjTJwrcdML+oqKU?=
 =?Windows-1252?Q?ke3vEpI8Xzpp7EXAaUu2Sw+yKPCCJCmffIZnfrr4/OhDNlihIuuQpt1Y?=
 =?Windows-1252?Q?ihesYJQRA8ORtBRhptIEMnB0KtBSMGbUohGPZ7xCyHu2iAo1yXyVTE7I?=
 =?Windows-1252?Q?j+W7wUN2QEHQRH4E56nvnHgzzgZ4QjzZ/QxVMlseGzvV+x0PHOJ1L6uT?=
 =?Windows-1252?Q?twVPxSmjlbW98SEbWX/LnLo9mS8DzBHmgpT+37EWNILMFW49aaX3fLbt?=
 =?Windows-1252?Q?/etTaSDfm9/LlFTJchVEFYjHIlHZzUILGW90Nn/QeBHoBLOMfUoV9Ywi?=
 =?Windows-1252?Q?Z1nUOssYvtxtKizXpKRNjykAc/sGeNZolYQzXnpJ1xTNsBKJnRAyhGGV?=
 =?Windows-1252?Q?Yn2Pqjx/oh1z0Yw/fFJAdt5+L9LKvsTpSmV1jGpdczirMp5sJ4AvVrJ4?=
 =?Windows-1252?Q?nQOrNtqXgkWKsCtkbDZ2/ewya802om8UBzAvJy8IDbLVQx/advmB3yTe?=
 =?Windows-1252?Q?MZ5Z7IWkILY5JzVyE4keZROzfEM1kOiFVsTlZaJMPW3VD6+N2PVMQfUi?=
 =?Windows-1252?Q?KK2t8FKjHsjycvN/O0OWkle1fRlr+Nq6O8fed6FmCxlpTQaZ4I9z8PDJ?=
 =?Windows-1252?Q?mQev1AEnudojNtGWb0ZC1+Z7+HTQLWTo1hUOPOxRMIKRYaHskSS9U6JS?=
 =?Windows-1252?Q?f7NDqGJdP7OUGgWit8ADP5iLPJtiqfC7kp9ZDAmbw7rP6NhPVcf8kaNs?=
 =?Windows-1252?Q?UKLwzsxNDIuIrVfvu+3fSCuuaHLZiFAx/u1Z1RhTiVaVTVY05nYNG8Kj?=
 =?Windows-1252?Q?XT1tDuwa/PbL6pH7bJ2Htc5GWzKn1lMsx6bSofboA1ySyWChqrzyeyel?=
 =?Windows-1252?Q?Gi5PgPwb+8tkbEtgu48wut8TLQqsK3XIIt/SLHkSEU/zsfHifh0LCDf5?=
 =?Windows-1252?Q?cqVMWaKOSl+pAkRponH6rnLq4PxgKc3p6fUCNURPuurYG+nIofrDWYIT?=
 =?Windows-1252?Q?sI9m06jKFpNVXPUBI/tzYT6srPZlz3/NGn0JsFGFdtWILw0I3RaWh35q?=
 =?Windows-1252?Q?o4G75AfXFrtKJoXuU+xGClHwH37X0Y8gGHbirSCUYIRHpkTTIMYsL9/c?=
 =?Windows-1252?Q?suurhh/yjMJ8eeOHtMgKRzIztjcIOWsVPISaohZJ96Xn6BvqYgtkAghK?=
 =?Windows-1252?Q?z8Xd3gpxoq72/0pYPEI6aLF4rN929FjRcpaVmTolN/uOVaL2BLJJ2Pi7?=
 =?Windows-1252?Q?2ifCANujP1kptkxSio8yDD9c89VRVUxMn/zvHjl8PE+lnRdk/GdE71kY?=
 =?Windows-1252?Q?HSIiIOAyEBl+IM0+c7QIB8pwM6SWEghFqhObefHPcWuU7Ybuv06MjmbV?=
 =?Windows-1252?Q?EyXeh0k4v7CXutgSn94/wgxaLKplDFKHnjtKdtukp2xxLoI+rf7dylJG?=
 =?Windows-1252?Q?VMjvI1jfl5wDk62R5EQ+QmpCtpDtkkaX34xo8NqeMUJ0hggDzX5+bpah?=
 =?Windows-1252?Q?kmVqJymgFnYq8FsbQFgni8f7ZybQ8fLVPOY1P8aENhsP1P9IRYStPLws?=
 =?Windows-1252?Q?C5g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?jVMmQ0dP8MexeH8EocoKcgGtDIzGk0TU6f/7i4/zixmbQq5FVscWRJ8N?=
 =?Windows-1252?Q?sOCme7e5j5+/YBtXzIaMIwbO5FHJRhYVt7RvfceRiYPogKCjA4jjAnxn?=
 =?Windows-1252?Q?2YB0Er7sukPwf5Mmp+w+pgklk85pOppl8WfD49i9giYCzpVneviG9Vy0?=
 =?Windows-1252?Q?Q0cBb4cOXruPc2TeIkKUS8vQAUr8dlibYZVthU9/9WsIjQ9IfMjHVEIH?=
 =?Windows-1252?Q?cMMIYI9WsHcZuCc9Sk0ZLkdX8AHpOKDIRbrRjb4jaWh2kWGBkYrMtWXY?=
 =?Windows-1252?Q?/oM9KWEB/ChHyuFd4geLjfFa6+Dri+rgHOtO0ZLML61FCt825oC4ufiU?=
 =?Windows-1252?Q?hcs492VA6UNsIBslWbLJsn+XceJWnWlNhb0bUNNoxeu8dLQiFxZZTdN1?=
 =?Windows-1252?Q?h5YmtBtTajoirKWc3bRK2pQY2YbESk+Fy4I6KclBEmn7QlQFe8zBQffM?=
 =?Windows-1252?Q?MURuZao2H+7FStqFV2GKxVdK7GBm6yGhI0djMj+gHjLjfqojtpRtAEyO?=
 =?Windows-1252?Q?J+IF57I1iKZvnS+SpgsI4P8Y1bMEv8xxyaNPwzjkrQDAjx9HaFPJWIGz?=
 =?Windows-1252?Q?WftWMUnqfX5RjTDnvIQzG0vsC1pTDXQkZh92CyOYMDE/GCyLLyE8q5Oh?=
 =?Windows-1252?Q?cgjIDJvxB4So1BhOUFmb/vjpv7MawD5vioLBYXpejL6qFtXN1KPtSaNi?=
 =?Windows-1252?Q?0jmt8PKQPLhMQSZi9mSceohQmsYD6WmysKso5yASEsTvudm5P8Pk2DgF?=
 =?Windows-1252?Q?VVsAFrWNkACKgQqG0A1E9/vY/FOEQnmC0CiQsErHqGK/xFpgTFILLWCy?=
 =?Windows-1252?Q?EdQ+3NHn/phW5tPnvQDmQAd/yvZgC804OSWbRS3CnMA8TtrZvHvUsryy?=
 =?Windows-1252?Q?O3Ut8TMFyk3+JXyBiwmqU0XnZUezyN9ruYi35L+pN/Ytjfw2QJGEG1Xf?=
 =?Windows-1252?Q?bRdVm5DCXi+PLF13bnHBXU5AGWbP4uNdVZi71m+0jV5mf+GVoQJG0uvW?=
 =?Windows-1252?Q?4rfOqvf41/Jn+L2j2twHjqki+gYQgNeg9jf6b7UUxO72UkB9Onn+lawG?=
 =?Windows-1252?Q?nYvWiczLvlqBAjVcKVHbxv1yrJHnHckyseEVV150TyAhZDqm16z1V1Q3?=
 =?Windows-1252?Q?GB9ct3RLMng3TeTIBxZ+4flLhmTGpy5n93iM8dyn0GsOtK7ZaWqME3Ur?=
 =?Windows-1252?Q?NKNhmLXEBjmHXtm6lT0jSYXP8PTEAJavCqJxG7VMuWsaNxI4+tSnqhpu?=
 =?Windows-1252?Q?1nn28GCAh0UDAaIx4OMXx0o5VNkV57nFARTl9siSxpORBG04tqWrMbqZ?=
 =?Windows-1252?Q?zFiIH97LbkfKe8paxnnMh9VnJZDxCsYaP/TuCrs0zC6/srSDBVsTujpT?=
 =?Windows-1252?Q?Gb3FId0byMhu9dCqfyMzScIMBveC7+g5nS7+7b4w2DWZSp71iVCbpbg/?=
 =?Windows-1252?Q?pgqsvB284pxLrj8oln1yYNMXf8f1rUOvhHg95PlGi1ZK6FLUYyX88+R7?=
 =?Windows-1252?Q?sNvZ9KfFiFzoqzEackGd3tei+5/SGV+Jbq7mX7GR90/vA5ZHqX2aeGP/?=
 =?Windows-1252?Q?2u7PMIg5H9RK0Sf8mosVINmffR0y4a6Zf+GB6Vef10pUwQkM4exrcg5A?=
 =?Windows-1252?Q?TPFhbFhlFL0/LJDCjcVk3jYKCaVONh18noDSDCTtI6sRjhmP6H8wqYJ5?=
 =?Windows-1252?Q?WYWZXt3zs14=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6369AEFA12BC5C99516ABC3DC116ACY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a81db8-1ac5-483f-e87b-08ddf6b8fb15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 13:40:50.3393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJqDxkOTwQhpz6Kn0D5AR26CANbMFsGKvVF/ESe2W0eU5CBIPnd+4LX7HPs/G6cX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
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

--_000_CY5PR12MB6369AEFA12BC5C99516ABC3DC116ACY5PR12MB6369namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks. Changed in v2.


Best Regards,

Yifan



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 17, 2025 1:51 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd=
-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1=
.Zhang@amd.com>
Subject: RE: [PATCH 2/2] amd/amdkfd: drain kfd process workquque before swi=
tch partition

[Public]

Hi Yifan,

Please wrap the KFD sequences in an API inside amdkfd/.  XCP will only make=
 use of the API and doesn=92t want to deal with KFD internals.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Wednesday, September 17, 2025 9:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1=
.Zhang@amd.com>
Subject: [PATCH 2/2] amd/amdkfd: drain kfd process workquque before switch =
partition

to resolve the race

[3966658.307702] divide error: 0000 [#1] SMP NOPTI [3966658.350818]  i10nm_=
edac [3966658.356318] CPU: 124 PID: 38435 Comm: kworker/124:0 Kdump: loaded=
 Tainted [3966658.356890] Workqueue: kfd_process_wq kfd_process_wq_release =
[amdgpu] [3966658.362839]  nfit [3966658.366457] RIP: 0010:kfd_get_num_sdma=
_engines+0x17/0x40 [amdgpu] [3966658.366460] Code: 00 00 e9 ac 81 02 00 66 =
66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 48 8b 4f 08 48 8b b7 00 01 =
00 00 8b 81 58 26 03 00 99 <f7> be b8 01 00 00 80 b9 70 2e 00 00 00 74 0b 8=
3 f8 02 ba 02 00 00 [3966658.380967]  x86_pkg_temp_thermal [3966658.391529]=
 RSP: 0018:ffffc900a0edfdd8 EFLAGS: 00010246 [3966658.391531] RAX: 00000000=
00000008 RBX: ffff8974e593b800 RCX: ffff888645900000 [3966658.391531] RDX: =
0000000000000000 RSI: ffff888129154400 RDI: ffff888129151c00 [3966658.39153=
2] RBP: ffff8883ad79d400 R08: 0000000000000000 R09: ffff8890d2750af4 [39666=
58.391532] R10: 0000000000000018 R11: 0000000000000018 R12: 000000000000000=
0 [3966658.391533] R13: ffff8883ad79d400 R14: ffffe87ff662ba00 R15: ffff897=
4e593b800 [3966658.391533] FS:  0000000000000000(0000) GS:ffff88fe7f600000(=
0000) knlGS:0000000000000000 [3966658.391534] CS:  0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033 [3966658.391534] CR2: 0000000000d71000 CR3: 000000dd0e=
970004 CR4: 0000000002770ee0 [3966658.391535] DR0: 0000000000000000 DR1: 00=
00000000000000 DR2: 0000000000000000 [3966658.391535] DR3: 0000000000000000=
 DR6: 00000000fffe07f0 DR7: 0000000000000400 [3966658.391536] PKRU: 5555555=
4 [3966658.391536] Call Trace:
[3966658.391674]  deallocate_sdma_queue+0x38/0xa0 [amdgpu] [3966658.391762]=
  process_termination_cpsch+0x1ed/0x480 [amdgpu] [3966658.399754]  intel_po=
werclamp [3966658.402831]  kfd_process_dequeue_from_all_devices+0x5b/0xc0 [=
amdgpu] [3966658.402908]  kfd_process_wq_release+0x1a/0x1a0 [amdgpu] [39666=
58.410516]  coretemp [3966658.434016]  process_one_work+0x1ad/0x380 [396665=
8.434021]  worker_thread+0x49/0x310 [3966658.438963]  kvm_intel [3966658.44=
6041]  ? process_one_work+0x380/0x380 [3966658.446045]  kthread+0x118/0x140=
 [3966658.446047]  ? __kthread_bind_mask+0x60/0x60 [3966658.446050]  ret_fr=
om_fork+0x1f/0x30 [3966658.446053] Modules linked in: kpatch_20765354(OEK) =
[3966658.455310]  kvm [3966658.464534]  mptcp_diag xsk_diag raw_diag unix_d=
iag af_packet_diag netlink_diag udp_diag act_pedit act_mirred act_vlan cls_=
flower kpatch_21951273(OEK) kpatch_18424469(OEK) kpatch_19749756(OEK) [3966=
658.473462]  idxd_mdev [3966658.482306]  kpatch_17971294(OEK) sch_ingress x=
t_conntrack amdgpu(OE) amdxcp(OE) amddrm_buddy(OE) amd_sched(OE) amdttm(OE)=
 amdkcl(OE) intel_ifs iptable_mangle tcm_loop target_core_pscsi tcp_diag ta=
rget_core_file inet_diag target_core_iblock target_core_user target_core_mo=
d coldpgs kpatch_18383292(OEK) ip6table_nat ip6table_filter ip6_tables ip_s=
et_hash_ipportip ip_set_hash_ipportnet ip_set_hash_ipport ip_set_bitmap_por=
t xt_comment iptable_nat nf_nat iptable_filter ip_tables ip_set ip_vs_sh ip=
_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sn_core_o=
dd(OE) i40e overlay binfmt_misc tun bonding(OE) aisqos(OE) aisqos_hotfixes(=
OE) rfkill uio_pci_generic uio cuse fuse nf_tables nfnetlink intel_rapl_msr=
 intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10=
nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm i=
dxd_mdev [3966658.491237]  vfio_pci [3966658.501196]  vfio_pci vfio_virqfd =
mdev vfio_iommu_type1 vfio iax_crypto intel_pmt_telemetry iTCO_wdt intel_pm=
t_class iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul ghash_c=
lmulni_intel rapl intel_cstate snd_hda_intel snd_intel_dspcfg snd_hda_codec=
 snd_hda_core snd_hwdep snd_seq [3966658.508537]  vfio_virqfd [3966658.5175=
69]  snd_seq_device ipmi_ssif isst_if_mbox_pci isst_if_mmio pcspkr snd_pcm =
idxd intel_uncore ses isst_if_common intel_vsec idxd_bus enclosure snd_time=
r mei_me snd i2c_i801 i2c_smbus mei i2c_ismt soundcore joydev acpi_ipmi ipm=
i_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad vfat fat [39666=
58.526851]  mdev [3966658.536096]  nfsd auth_rpcgss nfs_acl lockd grace slb=
_vtoa(OE) sunrpc dm_mod hookers mlx5_ib(OE) ast i2c_algo_bit drm_vram_helpe=
r drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_help=
er ttm mlx5_core(OE) mlxfw(OE) [3966658.540381]  vfio_iommu_type1 [3966658.=
544341]  nvme mpt3sas tls drm nvme_core pci_hyperv_intf raid_class psample =
libcrc32c crc32c_intel mlxdevm(OE) i2c_core [3966658.551254]  vfio [3966658=
.558742]  scsi_transport_sas wmi pinctrl_emmitsburg sd_mod t10_pi sg ahci l=
ibahci libata rdma_ucm(OE) ib_uverbs(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) ib=
_umad(OE) ib_core(OE) ib_ucm(OE) mlx_compat(OE) [3966658.563004]  iax_crypt=
o [3966658.570988]  [last unloaded: diagnose] [3966658.571027] ---[ end tra=
ce cc9dbb180f9ae537 ]---

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 27 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 +++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 127927b16ee2..cefb82ea1981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -194,6 +194,7 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_devic=
e *adev);  #if defined(CONFIG_DEBUG_FS)  int kfd_debugfs_kfd_mem_limits(str=
uct seq_file *m, void *data);  #endif
+void kfd_process_wq_flush(void);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);  st=
ruct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f); diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_xcp.c
index 1083db8cea2e..e12a28074b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -23,6 +23,8 @@
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_drv.h"
+#include "kfd_priv.h"
+#include "kfd_device_queue_manager.h"

 #include <drm/drm_drv.h>
 #include "../amdxcp/amdgpu_xcp_drv.h"
@@ -673,8 +675,31 @@ int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_=
mgr *xcp_mgr, u32 flags)
         * Stop user queues and threads, and make sure GPU is empty of work=
.
         */

-       if (flags & AMDGPU_XCP_OPS_KFD)
+       if (flags & AMDGPU_XCP_OPS_KFD) {
+               int i;
+               struct kfd_node *knode;
+               struct amdgpu_device *adev =3D xcp_mgr->adev;
+
+               if (!amdgpu_in_reset(adev)) {
+                       /* If there still active proccesses or queues, retu=
rn busy */
+                       for (i =3D 0; i < adev->kfd.dev->num_nodes; i++) {
+                               knode =3D adev->kfd.dev->nodes[i];
+                               if (knode->dqm->active_queue_count > 0 ||
+                                               knode->dqm->processes_count=
 > 0) {
+                                       pr_info("kfd process or queues stil=
l active: active_queue_count %d,"
+                                               "processes_count %d, partit=
ion switch abort\n",
+                                               knode->dqm->active_queue_co=
unt,
+                                               knode->dqm->processes_count=
);
+                                       return -EBUSY;
+                               }
+                       }
+
+                       /* Flush process wq. Make sure all user queues and =
threads finished */
+                       kfd_process_wq_flush();
+               }
+
                amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
+       }

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index d01ef5ac0766..21fe588ea559 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1547,6 +1547,7 @@ int kfd_send_exception_to_runtime(struct kfd_process =
*p,
                                unsigned int queue_id,
                                uint64_t error_reason);
 bool kfd_is_locked(struct kfd_dev *kfd);
+void kfd_process_wq_flush(void);

 /* Compute profile */
 void kfd_inc_compute_active(struct kfd_node *dev); diff --git a/drivers/gp=
u/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5be28c6c4f6a..d15583dfa0f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1196,6 +1196,12 @@ static void kfd_process_wq_release(struct work_struc=
t *work)
        kfree(p);
 }

+void kfd_process_wq_flush(void)
+{
+    /* expose flush work interface for partition switch */
+       flush_workqueue(kfd_process_wq);
+}
+
 static void kfd_process_ref_release(struct kref *ref)  {
        struct kfd_process *p =3D container_of(ref, struct kfd_process, ref=
);
--
2.43.0


--_000_CY5PR12MB6369AEFA12BC5C99516ABC3DC116ACY5PR12MB6369namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks. Changed in v2.</div>
<div class=3D"elementToProof" id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
Best Regards,</p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
Yifan</p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
&nbsp;</p>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 17, 2025 1:51 PM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedes=
ktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;; Yang, Philip &lt;Philip.Yang@amd.com&=
gt;; Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] amd/amdkfd: drain kfd process workquque bef=
ore switch partition</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[Public]<br>
<br>
Hi Yifan,<br>
<br>
Please wrap the KFD sequences in an API inside amdkfd/.&nbsp; XCP will only=
 make use of the API and doesn=92t want to deal with KFD internals.<br>
<br>
Thanks,<br>
Lijo<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Yi=
fan Zhang<br>
Sent: Wednesday, September 17, 2025 9:09 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &=
lt;Felix.Kuehling@amd.com&gt;; Yang, Philip &lt;Philip.Yang@amd.com&gt;; Zh=
ang, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
Subject: [PATCH 2/2] amd/amdkfd: drain kfd process workquque before switch =
partition<br>
<br>
to resolve the race<br>
<br>
[3966658.307702] divide error: 0000 [#1] SMP NOPTI [3966658.350818]&nbsp; i=
10nm_edac [3966658.356318] CPU: 124 PID: 38435 Comm: kworker/124:0 Kdump: l=
oaded Tainted [3966658.356890] Workqueue: kfd_process_wq kfd_process_wq_rel=
ease [amdgpu] [3966658.362839]&nbsp; nfit
 [3966658.366457] RIP: 0010:kfd_get_num_sdma_engines+0x17/0x40 [amdgpu] [39=
66658.366460] Code: 00 00 e9 ac 81 02 00 66 66 2e 0f 1f 84 00 00 00 00 00 9=
0 0f 1f 44 00 00 48 8b 4f 08 48 8b b7 00 01 00 00 8b 81 58 26 03 00 99 &lt;=
f7&gt; be b8 01 00 00 80 b9 70 2e 00 00
 00 74 0b 83 f8 02 ba 02 00 00 [3966658.380967]&nbsp; x86_pkg_temp_thermal =
[3966658.391529] RSP: 0018:ffffc900a0edfdd8 EFLAGS: 00010246 [3966658.39153=
1] RAX: 0000000000000008 RBX: ffff8974e593b800 RCX: ffff888645900000 [39666=
58.391531] RDX: 0000000000000000 RSI:
 ffff888129154400 RDI: ffff888129151c00 [3966658.391532] RBP: ffff8883ad79d=
400 R08: 0000000000000000 R09: ffff8890d2750af4 [3966658.391532] R10: 00000=
00000000018 R11: 0000000000000018 R12: 0000000000000000 [3966658.391533] R1=
3: ffff8883ad79d400 R14: ffffe87ff662ba00
 R15: ffff8974e593b800 [3966658.391533] FS:&nbsp; 0000000000000000(0000) GS=
:ffff88fe7f600000(0000) knlGS:0000000000000000 [3966658.391534] CS:&nbsp; 0=
010 DS: 0000 ES: 0000 CR0: 0000000080050033 [3966658.391534] CR2: 000000000=
0d71000 CR3: 000000dd0e970004 CR4: 0000000002770ee0
 [3966658.391535] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000 [3966658.391535] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: =
0000000000000400 [3966658.391536] PKRU: 55555554 [3966658.391536] Call Trac=
e:<br>
[3966658.391674]&nbsp; deallocate_sdma_queue+0x38/0xa0 [amdgpu] [3966658.39=
1762]&nbsp; process_termination_cpsch+0x1ed/0x480 [amdgpu] [3966658.399754]=
&nbsp; intel_powerclamp [3966658.402831]&nbsp; kfd_process_dequeue_from_all=
_devices+0x5b/0xc0 [amdgpu] [3966658.402908]&nbsp; kfd_process_wq_release+0=
x1a/0x1a0
 [amdgpu] [3966658.410516]&nbsp; coretemp [3966658.434016]&nbsp; process_on=
e_work+0x1ad/0x380 [3966658.434021]&nbsp; worker_thread+0x49/0x310 [3966658=
.438963]&nbsp; kvm_intel [3966658.446041]&nbsp; ? process_one_work+0x380/0x=
380 [3966658.446045]&nbsp; kthread+0x118/0x140 [3966658.446047]&nbsp;
 ? __kthread_bind_mask+0x60/0x60 [3966658.446050]&nbsp; ret_from_fork+0x1f/=
0x30 [3966658.446053] Modules linked in: kpatch_20765354(OEK) [3966658.4553=
10]&nbsp; kvm [3966658.464534]&nbsp; mptcp_diag xsk_diag raw_diag unix_diag=
 af_packet_diag netlink_diag udp_diag act_pedit
 act_mirred act_vlan cls_flower kpatch_21951273(OEK) kpatch_18424469(OEK) k=
patch_19749756(OEK) [3966658.473462]&nbsp; idxd_mdev [3966658.482306]&nbsp;=
 kpatch_17971294(OEK) sch_ingress xt_conntrack amdgpu(OE) amdxcp(OE) amddrm=
_buddy(OE) amd_sched(OE) amdttm(OE) amdkcl(OE)
 intel_ifs iptable_mangle tcm_loop target_core_pscsi tcp_diag target_core_f=
ile inet_diag target_core_iblock target_core_user target_core_mod coldpgs k=
patch_18383292(OEK) ip6table_nat ip6table_filter ip6_tables ip_set_hash_ipp=
ortip ip_set_hash_ipportnet ip_set_hash_ipport
 ip_set_bitmap_port xt_comment iptable_nat nf_nat iptable_filter ip_tables =
ip_set ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6 nf_def=
rag_ipv4 sn_core_odd(OE) i40e overlay binfmt_misc tun bonding(OE) aisqos(OE=
) aisqos_hotfixes(OE) rfkill uio_pci_generic
 uio cuse fuse nf_tables nfnetlink intel_rapl_msr intel_rapl_common intel_u=
ncore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_=
thermal intel_powerclamp coretemp kvm_intel kvm idxd_mdev [3966658.491237]&=
nbsp; vfio_pci [3966658.501196]&nbsp; vfio_pci
 vfio_virqfd mdev vfio_iommu_type1 vfio iax_crypto intel_pmt_telemetry iTCO=
_wdt intel_pmt_class iTCO_vendor_support irqbypass crct10dif_pclmul crc32_p=
clmul ghash_clmulni_intel rapl intel_cstate snd_hda_intel snd_intel_dspcfg =
snd_hda_codec snd_hda_core snd_hwdep
 snd_seq [3966658.508537]&nbsp; vfio_virqfd [3966658.517569]&nbsp; snd_seq_=
device ipmi_ssif isst_if_mbox_pci isst_if_mmio pcspkr snd_pcm idxd intel_un=
core ses isst_if_common intel_vsec idxd_bus enclosure snd_timer mei_me snd =
i2c_i801 i2c_smbus mei i2c_ismt soundcore
 joydev acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acp=
i_pad vfat fat [3966658.526851]&nbsp; mdev [3966658.536096]&nbsp; nfsd auth=
_rpcgss nfs_acl lockd grace slb_vtoa(OE) sunrpc dm_mod hookers mlx5_ib(OE) =
ast i2c_algo_bit drm_vram_helper drm_kms_helper
 syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm mlx5_core=
(OE) mlxfw(OE) [3966658.540381]&nbsp; vfio_iommu_type1 [3966658.544341]&nbs=
p; nvme mpt3sas tls drm nvme_core pci_hyperv_intf raid_class psample libcrc=
32c crc32c_intel mlxdevm(OE) i2c_core [3966658.551254]&nbsp;
 vfio [3966658.558742]&nbsp; scsi_transport_sas wmi pinctrl_emmitsburg sd_m=
od t10_pi sg ahci libahci libata rdma_ucm(OE) ib_uverbs(OE) rdma_cm(OE) iw_=
cm(OE) ib_cm(OE) ib_umad(OE) ib_core(OE) ib_ucm(OE) mlx_compat(OE) [3966658=
.563004]&nbsp; iax_crypto [3966658.570988]&nbsp;
 [last unloaded: diagnose] [3966658.571027] ---[ end trace cc9dbb180f9ae537=
 ]---<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c&nbsp;&nbsp;&nbsp; | 27 ++++++=
+++++++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp; |&nbsp; 6 +++++<=
br>
&nbsp;4 files changed, 34 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index 127927b16ee2..cefb82ea1981 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -194,6 +194,7 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_devic=
e *adev);&nbsp; #if defined(CONFIG_DEBUG_FS)&nbsp; int kfd_debugfs_kfd_mem_=
limits(struct seq_file *m, void *data);&nbsp; #endif<br>
+void kfd_process_wq_flush(void);<br>
&nbsp;#if IS_ENABLED(CONFIG_HSA_AMD)<br>
&nbsp;bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)=
;&nbsp; struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence=
 *f); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_xcp.c<br>
index 1083db8cea2e..e12a28074b07 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br>
@@ -23,6 +23,8 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_xcp.h&quot;<br>
&nbsp;#include &quot;amdgpu_drv.h&quot;<br>
+#include &quot;kfd_priv.h&quot;<br>
+#include &quot;kfd_device_queue_manager.h&quot;<br>
<br>
&nbsp;#include &lt;drm/drm_drv.h&gt;<br>
&nbsp;#include &quot;../amdxcp/amdgpu_xcp_drv.h&quot;<br>
@@ -673,8 +675,31 @@ int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_=
mgr *xcp_mgr, u32 flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Stop user queues and thr=
eads, and make sure GPU is empty of work.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; AMDGPU_XCP_OPS_KFD)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; AMDGPU_XCP_OPS_KFD) {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct kfd_node *knode;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_device *adev =3D xcp_mgr-&gt;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_in_reset(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If there stil=
l active proccesses or queues, return busy */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; adev-&gt;kfd.dev-&gt;num_nodes; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; knode =3D adev-&gt;kfd.dev-&gt;nodes[i];<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (knode-&gt;dqm-&gt;active_queue_count &g=
t; 0 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; knode-&gt;dqm-&gt;proc=
esses_count &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pr_info(&quot;kfd process or queues still active: active_queue_count %=
d,&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;processes_count =
%d, partition switch abort\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; knode-&gt;dqm-&gt;acti=
ve_queue_count,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; knode-&gt;dqm-&gt;proc=
esses_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return -EBUSY;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Flush process=
 wq. Make sure all user queues and threads finished */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_wq_f=
lush();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_amdkfd_device_fini_sw(xcp_mgr-&gt;adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index d01ef5ac0766..21fe588ea559 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -1547,6 +1547,7 @@ int kfd_send_exception_to_runtime(struct kfd_process =
*p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t error_reason);<br>
&nbsp;bool kfd_is_locked(struct kfd_dev *kfd);<br>
+void kfd_process_wq_flush(void);<br>
<br>
&nbsp;/* Compute profile */<br>
&nbsp;void kfd_inc_compute_active(struct kfd_node *dev); diff --git a/drive=
rs/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_proces=
s.c<br>
index 5be28c6c4f6a..d15583dfa0f9 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1196,6 +1196,12 @@ static void kfd_process_wq_release(struct work_struc=
t *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(p);<br>
&nbsp;}<br>
<br>
+void kfd_process_wq_flush(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; /* expose flush work interface for partition switch */<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_workqueue(kfd_process_wq);<br>
+}<br>
+<br>
&nbsp;static void kfd_process_ref_release(struct kref *ref)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p =3D contai=
ner_of(ref, struct kfd_process, ref);<br>
--<br>
2.43.0<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB6369AEFA12BC5C99516ABC3DC116ACY5PR12MB6369namp_--
