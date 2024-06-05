Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E571FC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 641F810E075;
	Wed,  5 Jun 2024 12:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qpmhaQ3/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EF410E075
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 12:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqbqSudLn7NI4rwB2g9J/85wK/2HSIs3/ciQ1bWYGKpnUMLO4qxStbYwNY1UxyWBURIlIXEiSyPti0XJqt3XV3ygPIqiMY2sM0tZ5HAd+1hlu1vLaenUmmHpcEqJldcd9U7TgQRj3FRUxQYlkxo9pA5THmqwIv8DL/sb4ZTw/IPa19BAJ4D8rUoZ4icQg7Fq2gFyaQZgf//yrTACnq9RV9M1WEsIwjVfhsZpqgsAKnYQ1u3m/pQPbxxurP8ujIdsffeRB5vyqtFecthJF6zmoE0H2KJ/3aIfZmZbCZ9RDjApec2ywEqDY9r2I4g4kOKzVdAAdFaSBkwumGXL1EfbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wz0AS3XOQRNW4V7Yz0xpowuBgsz6X6Oba3JYDbOJo8E=;
 b=NCNSgz+kEp2CQYbKsY0hY7kXgY1vXtdhpoImYZ6i0N4mOqgXhSlZOmtahAG9H2bgDqykLTZCqwabV+Zgzea8RWkicadxcwAKI0A984APKGZZgK2R7iHEhnAhc7L+NK31TSAGMoKhuAyUmOG8aILjwTnyEhugd9bktqcHghBrj9ezQP6SL6ZFeA8XOG+v42kIcdorL7lGPE9cTtvTYWNqVPWg1P9EV3E1eeQts6hOXuICVujOH+QWO4+gXlD4PhwUPZ6lHdyt5Hgadk5puKYir/ccRl2Jl/aflyPf23dmGbEtIw30aCuQRSxyQoBO0Ld3LfRbLfZ0a75Yh2gqkjmjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz0AS3XOQRNW4V7Yz0xpowuBgsz6X6Oba3JYDbOJo8E=;
 b=qpmhaQ3/eBQyTup3qhCQtHU5W+FICI8B4UIPNQ53j8ldQHbVhUG2MAz3Ajq9OwjdHcRcCtVeUpIbJFeXQHLp3csaLw2A4Bc57duUN6/dxpSe4H6TY/H7OkMt5umYH7kNvIE4a5J6ykTRSdHE+o4hEyoLZVXcirv/1RXaaAMGO9Y=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 12:17:55 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 12:17:55 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Zhang, George" <George.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH] drm/amd/display: use pre-allocated temp structure for
 bounding box
Thread-Topic: [PATCH] drm/amd/display: use pre-allocated temp structure for
 bounding box
Thread-Index: AQHatpb9oVhmMImF/UOBeahTT7r6MbG30RuAgAFGK50=
Date: Wed, 5 Jun 2024 12:17:55 +0000
Message-ID: <CH0PR12MB5284AB4DA3FEB753DCBF77F48BF92@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20240604155027.542271-1-alexander.deucher@amd.com>
 <CY8PR12MB7415814E1314E87EA7F1D23C94F82@CY8PR12MB7415.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7415814E1314E87EA7F1D23C94F82@CY8PR12MB7415.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T12:17:55.163Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|IA0PR12MB9011:EE_
x-ms-office365-filtering-correlation-id: 70e265be-5d33-416f-e35d-08dc855987b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?7bBC8Gzk9974UpTIzPZRX1SP3pEWq+S/6R3vE3nl6iWHCWlBwBBSeMW6JZOq?=
 =?us-ascii?Q?COXFJsxevGiuEqsGPy6SOdNmVM6mPK7/qLOYxE1P3rBjgayFkLkKyzXy07gT?=
 =?us-ascii?Q?kIW25I2bogZvVE1pTcf8aaUKMhAziYWb/M11bJ6+FDcid+jYVS7Y9W/c793K?=
 =?us-ascii?Q?V+appMfRPko238zYStPg9I9zKfhyoX1kg7GVfNsb+bB4O/TF9KBOgJo40O+e?=
 =?us-ascii?Q?3wcPv8uHFwYJ15SsAL5sBYcV3JyjnlhrT/ebSYl497Hl9S4PvPt2dCpw/lzh?=
 =?us-ascii?Q?dpjxt7G2JY6cWdGPLtctUquvEq7096I60lKPga86jrmsMkonbivuZNlLhFJF?=
 =?us-ascii?Q?QLyPufpuIoveMOkFFCmETMSbLHWp5UI/mN/3KzH0xH3IeL1ekKQ/pu578M9p?=
 =?us-ascii?Q?lFeIzClE0A/j+jntmY0jJkDKVuKdT6DUTSFIYXgx6+Fxa3g17Yxy6yPI2eW+?=
 =?us-ascii?Q?hjwkIW/uIWiY2RIG7wUhClqWGcwFWjSos+2zRj1Arn97FY2pLlM/LwFzKeFA?=
 =?us-ascii?Q?Wy4pHARq0U8k0mNJFqqV+sPKJEEoA/2WjyqGUIGKeTgxeL4NK3LwxcpoRTuS?=
 =?us-ascii?Q?eyYsrNzihH9f16BiNPVI8oiRjlhY4vc2goCIfRsamsCrIGqqlq9Q9Mb75AEE?=
 =?us-ascii?Q?acBUqhocYd+KmF2I2el8iDHAkoI2SBNYIOhNL3hWV4scfwTla9sOJUEHrl6C?=
 =?us-ascii?Q?tNzgcqWazXafUt+Sgoj+ormM3X0jqdgsI2sihMn1o+G8jbqitUlKyP3UhoDw?=
 =?us-ascii?Q?asMaTs4XAGqLnbxR1ZsHgfxaeTAr8kJzcoKTXZ/2Mv/MuX3Cux5/ETMxUhtv?=
 =?us-ascii?Q?hawolQ/mzoHeJwL3T0pOUYLLJMQcpkUuem34i6y1/EGT18jfGB6JtKM39C3p?=
 =?us-ascii?Q?o8FOIJ6eDGOGlNwvrsSVM4ZtWO/ljy0u3znjW04WsWwakPW6zqhWPMOFdPxg?=
 =?us-ascii?Q?GOE1Hd581dbwPGF7WTsoqdunrdcOzMBf//ytrtzZF9YQqhDxs4HIr6sdK8dg?=
 =?us-ascii?Q?7wWvJSA4lgsqR5LQ6Da+CHelFwWAYfxh7SyAXZqEHQtLEP6bo8+PiL5Ci1td?=
 =?us-ascii?Q?jz7tsk14Lu7LWnZEZ12JEIwbWgVnSbEvRuU9zvfOJxQrZGZ0tscAjmtbyUW8?=
 =?us-ascii?Q?q9GDz/7JzE0bZ3gpvER11trNFr/KbYqXWlevch22BBJDaY+SIjnA5YE1ZG7K?=
 =?us-ascii?Q?4Opy306P6PBffF+7Og5RJE0GVfyOTlMduYlW/GzQCIrX5VekDtgBHpPwLpJl?=
 =?us-ascii?Q?bbIj/ElQLkXn5qQoLQl2EsggKfZwz73QcnTxv+5nXzMHCj3Shi+FPaoslLbL?=
 =?us-ascii?Q?AK+ghkCK60NMjaHuj7JMyRlyCBVryqdjlHleAhtTJsWAF/oNQewlpW+rlb02?=
 =?us-ascii?Q?80ixu0s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DioswsM1mzOrZnWqgMiQ+pU9+g4ZHcjPmVqQJa3Xi+jUH9cgiuVreMra0SGE?=
 =?us-ascii?Q?LEcIMaY1E/GGai2Oj8gE8l/BnGVbhVV4EnVDhDGMzuQi2vUzYWp0hcNfeYJn?=
 =?us-ascii?Q?E4fnoyFsmJr7XLvfeIwjdvaklzYcgk0UtlePqgt+htkR7x1QE5pUKhY7A8fZ?=
 =?us-ascii?Q?WWmWZcyJZRNh/2u57CK1xrUYAHSxdI74hcWW1UfkW8Ol5S6bEySouixIs/Wf?=
 =?us-ascii?Q?jukr99ckwFWEVOH1evyDrCO65C8MQhlH6/0Z08/lzPUdnlWbGNyPUULrCMsg?=
 =?us-ascii?Q?neE+htng03JjhKtUPqqiX+4SaaxW90+5vNvXNn3tWgp/wGvhENQ6NW1cLbIH?=
 =?us-ascii?Q?QO2ArZEh7QKhyp4mgrS1cnR/YZOpbvGbHPVgmu69njdaWbeRZLF7M91QUsGh?=
 =?us-ascii?Q?JO7D1Vh3OzgchEl3q9JG9/sSTprJu3IG7Hllz6kAV0Dl4mqff93IjkkGxtnk?=
 =?us-ascii?Q?EzJ5gdhwhveYWYw3Xd6NEI+e6RJA/T4PwoI+gjetSnbTsjgBXOZBzLzdkG26?=
 =?us-ascii?Q?Ws6YtKnQ2L8Dv4jxUHZm23z36RJVy8jE0iGsiG3yUZd89+JunDqgFfOLs3E2?=
 =?us-ascii?Q?0szAPMTTpD/y49MB2ok0R4XAYy+553+vBaEPcGVFXCfw8LQlUVYQB6fTG4tk?=
 =?us-ascii?Q?K1wKQPYh4VI7yR2vJaWJMrtjFppB4V9DzNy5Bdv9as2W0Sfs56Vv8/jjWgc+?=
 =?us-ascii?Q?C2ry80iAVcS5EZqlVHNix4OWD0TNQDBrM3thPjqYdaJi6viLP6oQ9z5o18hu?=
 =?us-ascii?Q?B08/Au8pHQHBXzKGOBIm470CikY2LWbwSH8vPycHHojB97kWcQRT/sJe+dhS?=
 =?us-ascii?Q?B7lMTSF0brucfho9bKaB0A2wlgJEpwG0FM9sG0NZKQTY8+MyJPjYGXQf1dOB?=
 =?us-ascii?Q?7qI3nVb8JyioXEdggCe6DdzAjv1tMFsyxzHaKJkIUPWcXAR5gNU92dTNZhNA?=
 =?us-ascii?Q?UqRTOQ5+2bYchOehhmDY3Wwt0yqTbVMmddpjauqCC2NbSmSBtkVgvtzD/+FD?=
 =?us-ascii?Q?UKeWgB5uasKvsgHYpJ1226NWBw62HGGmROkJfO4Dv9f1i9CpxLw5QobtPpgK?=
 =?us-ascii?Q?IP9eonx+Qn9novmYBis/GEe/mNJtlxMTZ8RactzAKcXyQuE9JJP2XycbmOgu?=
 =?us-ascii?Q?XoM2tMRRor0HyBaQDNMpNrvYKVPZ2uNKelZIeu0Bw60DdRYcC3CtEJf9pSUw?=
 =?us-ascii?Q?cySwSxnfxuNi2tIx9Tj8vhe0p5PFqjmYbONdTGd6uorp1nqHqDFoFnXtVWOa?=
 =?us-ascii?Q?8kxkZuf+gD7XubBkygUnHVJYNjpijh3mivRz48qMrhLCihN4bhEIybsN5L/+?=
 =?us-ascii?Q?7HtaalJYph5V0qnDjNIBWKRIzUhYMKU7jE95y9taoJSWsfa97qpVmVjrffhC?=
 =?us-ascii?Q?qXzR9bGoa/kW6Z3qAQgsVT5aesb9P4mfMkQz/Kr8LCdNPSVjtYUT0PKWKoXR?=
 =?us-ascii?Q?xbw4VZlB2KCyWcfNvGhI2Cp1f6bS9Yi/ddDRgky24UHzJLGW/JTHjaH4kSE6?=
 =?us-ascii?Q?j/lSgj9JwV/8Xz62rXzgh77aFL6+LLPbicTP9lJCm9yTsilNl2F4nVM5NcUa?=
 =?us-ascii?Q?+m6CoU1yqyIUXerJ5xA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284AB4DA3FEB753DCBF77F48BF92CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e265be-5d33-416f-e35d-08dc855987b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 12:17:55.4472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RA9QpLTMvhNc6Lgjwi3X/KB5rYJESbSoaHsDNt66OKQKMh6jeDqe9+2t+fhG+VVN/LbnxgaFQWk00GAbiWvCcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
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

--_000_CH0PR12MB5284AB4DA3FEB753DCBF77F48BF92CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Alex,

I'll a hunk for fixing DCN401 as well to this and resend it later today.


--

Regards,
Jay
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, G=
eorge <George.Zhang@amd.com>
Sent: Tuesday, June 4, 2024 12:49 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Arnd Bergmann <arnd@arndb.de>; =
Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@am=
d.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Subject: RE: [PATCH] drm/amd/display: use pre-allocated temp structure for =
bounding box

[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

Tested-by: George Zhang <George.zhang@amd.com>

Thanks,
George
-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, June 4, 2024 11:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Mahfooz, Hamza <Hamza.M=
ahfooz@amd.com>; Zhang, George <George.Zhang@amd.com>; Arnd Bergmann <arnd@=
arndb.de>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Su=
npeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: use pre-allocated temp structure for boun=
ding box

This mirrors what the driver does for older DCN generations.

Should fix:

BUG: sleeping function called from invalid context at include/linux/sched/m=
m.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u=
64:8
preempt_count: 2, expected: 0
RCU nest depth: 0, expected: 0
Preemption disabled at:
ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAM=
ING WIFI II, BIOS 4204 02/24/2022
Workqueue: events_unbound async_run_entry_fn

Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configurat=
ion_options structures")
Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: harry.wentland@amd.com
Cc: sunpeng.li@amd.com
Cc: Rodrigo.Siqueira@amd.com
---
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++-----
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 +++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index d0ed01ac460d..d843933ad731 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1444,6 +1444,7 @@ struct dc {
        } scratch;

        struct dml2_configuration_options dml2_options;
+       struct dml2_configuration_options dml2_tmp;
        enum dc_acpi_cm_power_state power_state;

 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 0f11d7c8791c..7a8aa9396dea 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struc=
t dc_state *context,

 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_para=
ms *bw_params)
 {
-       struct dml2_configuration_options *dml2_opt;
+       struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;

-       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), G=
FP_KERNEL);
-       if (!dml2_opt)
-               return;
+       memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));

        DC_FP_START();

@@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct dc *d=
c, struct clk_bw_params *bw

        DC_FP_END();

-       kfree(dml2_opt);
+       memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 }

 static struct resource_funcs dcn32_res_pool_funcs =3D {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 07ca6f58447d..ef30e8632607 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs =3D {

 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_par=
ams *bw_params)
 {
-       struct dml2_configuration_options *dml2_opt;
+       struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;

-       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), G=
FP_KERNEL);
-       if (!dml2_opt)
-               return;
+       memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));

        DC_FP_START();

@@ -1601,7 +1599,7 @@ static void dcn321_update_bw_bounding_box(struct dc *=
dc, struct clk_bw_params *b

        DC_FP_END();

-       kfree(dml2_opt);
+       memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 }

 static struct resource_funcs dcn321_res_pool_funcs =3D {
--
2.45.1


--_000_CH0PR12MB5284AB4DA3FEB753DCBF77F48BF92CH0PR12MB5284namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Alex,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I'll a hunk for fixing DCN401 as well to this and resend it later today.<br=
>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" style=3D"color: inherit;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhang, George &lt;George.Zhan=
g@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 4, 2024 12:49 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.com&gt;; Arnd Bergmann &lt;=
arnd@arndb.de&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun =
peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siquei=
ra@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: use pre-allocated temp structu=
re for bounding box</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - AMD Internal Distribution=
 Only]<br>
<br>
[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
Tested-by: George Zhang &lt;George.zhang@amd.com&gt;<br>
<br>
Thanks,<br>
George<br>
-----Original Message-----<br>
From: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Sent: Tuesday, June 4, 2024 11:50 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Mahfooz, Hamza &l=
t;Hamza.Mahfooz@amd.com&gt;; Zhang, George &lt;George.Zhang@amd.com&gt;; Ar=
nd Bergmann &lt;arnd@arndb.de&gt;; Wentland, Harry &lt;Harry.Wentland@amd.c=
om&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Siqueira, Rodrigo
 &lt;Rodrigo.Siqueira@amd.com&gt;<br>
Subject: [PATCH] drm/amd/display: use pre-allocated temp structure for boun=
ding box<br>
<br>
This mirrors what the driver does for older DCN generations.<br>
<br>
Should fix:<br>
<br>
BUG: sleeping function called from invalid context at include/linux/sched/m=
m.h:306<br>
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u=
64:8<br>
preempt_count: 2, expected: 0<br>
RCU nest depth: 0, expected: 0<br>
Preemption disabled at:<br>
ffffffffc0ce1580&gt;] dc_fpu_begin+0x30/0xd0 [amdgpu]<br>
CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; W&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.8.0=
+ #35<br>
Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAM=
ING WIFI II, BIOS 4204 02/24/2022<br>
Workqueue: events_unbound async_run_entry_fn<br>
<br>
Fixes: 88c61827cedc (&quot;drm/amd/display: dynamically allocate dml2_confi=
guration_options structures&quot;)<br>
Suggested-by: Hamza Mahfooz &lt;hamza.mahfooz@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: George Zhang &lt;george.zhang@amd.com&gt;<br>
Cc: Arnd Bergmann &lt;arnd@arndb.de&gt;<br>
Cc: harry.wentland@amd.com<br>
Cc: sunpeng.li@amd.com<br>
Cc: Rodrigo.Siqueira@amd.com<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;.../drm/amd/display/dc/resource/dcn32/dcn32_resource.c&nbsp;&nbsp;&nb=
sp; | 8 +++-----<br>
&nbsp;.../drm/amd/display/dc/resource/dcn321/dcn321_resource.c&nbsp; | 8 ++=
+-----<br>
&nbsp;3 files changed, 7 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h<br>
index d0ed01ac460d..d843933ad731 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
@@ -1444,6 +1444,7 @@ struct dc {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } scratch;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_option=
s dml2_options;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_options dml=
2_tmp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_acpi_cm_power_state powe=
r_state;<br>
<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c<br>
index 0f11d7c8791c..7a8aa9396dea 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c<br>
@@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struc=
t dc_state *context,<br>
<br>
&nbsp;static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw=
_params *bw_params)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_options *dm=
l2_opt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_options *dm=
l2_opt =3D &amp;dc-&gt;dml2_tmp;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dml2_opt =3D kmemdup(&amp;dc-&gt;dml2=
_options, sizeof(dc-&gt;dml2_options), GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dml2_opt)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(dml2_opt, &amp;dc-&gt;dml2_opt=
ions, sizeof(dc-&gt;dml2_options));<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_START();<br>
<br>
@@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct dc *d=
c, struct clk_bw_params *bw<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_END();<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(dml2_opt);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dc-&gt;dml2_options, dml2=
_opt, sizeof(dc-&gt;dml2_options));<br>
&nbsp;}<br>
<br>
&nbsp;static struct resource_funcs dcn32_res_pool_funcs =3D {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c<br>
index 07ca6f58447d..ef30e8632607 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c<br>
@@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs =3D {<br>
<br>
&nbsp;static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_b=
w_params *bw_params)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_options *dm=
l2_opt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_options *dm=
l2_opt =3D &amp;dc-&gt;dml2_tmp;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dml2_opt =3D kmemdup(&amp;dc-&gt;dml2=
_options, sizeof(dc-&gt;dml2_options), GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dml2_opt)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(dml2_opt, &amp;dc-&gt;dml2_opt=
ions, sizeof(dc-&gt;dml2_options));<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_START();<br>
<br>
@@ -1601,7 +1599,7 @@ static void dcn321_update_bw_bounding_box(struct dc *=
dc, struct clk_bw_params *b<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_END();<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(dml2_opt);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;dc-&gt;dml2_options, dml2=
_opt, sizeof(dc-&gt;dml2_options));<br>
&nbsp;}<br>
<br>
&nbsp;static struct resource_funcs dcn321_res_pool_funcs =3D {<br>
--<br>
2.45.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284AB4DA3FEB753DCBF77F48BF92CH0PR12MB5284namp_--
