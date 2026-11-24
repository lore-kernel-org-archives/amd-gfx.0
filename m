Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2EF606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=09+ZoIjA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EEA10ECF2;
	Tue, 24 Nov 2026 02:25:54 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC1210ECF2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 02:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=To6162IGxfaivgraggX8aqKNg4hvAhxJZ8SQssE6SFpoAI+tvPGfkzmCcMnrF1BfbtOeR9OkN00fSMu+f1296q/UjmBOVe/lYwwnLnz62NtvzRI5RN6dZ7SgrWnts9WNlsfVjFfofSVJNshPgMjqXn0KPU2104HF8ykoiJihs09Y3KFlaGKwi6/5AXRDN26SbsJLhZGyXJCy5uyypfJ8V5N/aPXPDvKkUp8xYeuBf4wiANXdcOVfl7K7CPKJGAlRWY0HdzNW/yIBQPjm8pyUiowckIY/XsEwbQbDKbvMXRGAqiXbFt6QntYcOeXAfhQLRYrvucU9vSx8JLdauPsagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjfccEc0sDRmv6gt+VMyk5nDbIvcwZxaQnOKDnOdT+I=;
 b=RRQycmp0C+0NegaSZ3fp5bZEI48vT/ipcKKCxstOIgjrOcjVMSQ7PQ16lI1MFM86safV6f6JxAR9Z7SffN+MNZPHuWuI+U08gf3VBeoLPXl2T2OFVmn5ix0NmzETinv4TeLSwwRhu/zb8ovNgg30N7VhWs9fEninfSKo9sFZLRrO/atOGACh06HsCXZOOY8MYztiSuvZPAI3kibCEQ8B0HCA8kdg7m2R4HhZGzpTC7vOZxdBjiI+k5+OHFuylxMADLfFeMTHEpxehHx/epMfHhznqh/syQHsy+LXK3IuDTiezH88NyU0nDhJXfe7T55mq0eDjUaIiQzARXG+RGGDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjfccEc0sDRmv6gt+VMyk5nDbIvcwZxaQnOKDnOdT+I=;
 b=09+ZoIjA+SUKZjtHekW1C7nDR0Y3tLttTCe4ZwQKnH+3J8M7dEnvl6nnyz/cfPsbdF9BTjADbAIQ72aa8KmSx7fDb6QTcoz0fCKyKq5FjdsUXyYYS2/BSsFfnAOgcFcVldzY9uOqZOqN3y5qVQDy2kkiHvcFut7UYrGptv7sxUI=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 02:25:41 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 02:25:41 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [RFC PATCH v3 0/5] drm/amdgpu: prepare updates across page-table
 allocation
Thread-Topic: [RFC PATCH v3 0/5] drm/amdgpu: prepare updates across page-table
 allocation
Thread-Index: AQHddohWP/nteJU8CE2R+q4Copw+Fbc7fDoAgAA3TICAANWYkA==
Date: Tue, 24 Nov 2026 02:25:40 +0000
Message-ID: <MW3PR12MB4572839BE70D2095A2345D759E442@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <MW3PR12MB4572DA4F9D571938FB7C4A999E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
 <awQUEmwUoWSSDDOV@quatroqueijos.cascardo.eti.br>
 <3b7ff1c0-94a7-4377-a04a-bc7c56e50ebb@amd.com>
In-Reply-To: <3b7ff1c0-94a7-4377-a04a-bc7c56e50ebb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|PH8PR12MB8605:EE_
x-ms-office365-filtering-correlation-id: 1fdf1676-89fb-4784-111c-08df49d23ba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261022105027099003|261028144727099003|261026140227099003|38070700021|11063799006|261026121527099003|56012099006|4143699003|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: +BO2Y0I5sgym9LiFNnwbktXYEeEDoey9ysc3uPbGwzaCePzD0rIUBtIAVIMMSTChkR7y959x5zs5KSD9N7JV856N4hahZFau5mdvY0k0ciIbEGNmozIaNlN9DDCVH3S+W92I8jW7RbTHyQH8U+EqypAsM4xgnPmr8ZQmwzXa18SuyTmD++YSc9U5AmsSLMH5fl58Tzg+UUV5kKZAtVsVa2Y7XMhr2U6eiS8OiTyqA1KAUj4G4+TDrYtq/4f/cMvw/IMEiqHF+2HYvL01vIFcKVHVv/6IC7cHvwU9RWu5lZhrQiLiaQToBBbaIhrHUVnWfKZMTmq2ySu5N+8Uf/bRgzmj+H/5oGrmRtHDpPyYH18g9sKzrMEljNsLIWDq8VvJICmoUvUierhRzBsrCkD2kkTXn+k7eL1FV55OMjNk3eY+FhgR4SD5z8ralTCKLlAW+QL44V4BYo/UoRd6F9h6gGXRRV0drCUzp9j3+YUmtu8OxrM/UicWAXO/ehMf8Ux6EYK/4igD/3kvUlUNTUgOvNmBhE5a5PP9OR24Iaws98z1O7UNcA3iup+AABVVDMgTnLqNeotAzwQdVJDT8mdWsys3b0I+tRuhkbRORrjj/Nant3jXpe0tFG6k7UOuabkE5LftOT4QawAs7e+FVniqt91qGNFUn/JKLhRj0RAvy1xR+uaZZlvmNX8hPsvaWjRr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261022105027099003)(261028144727099003)(261026140227099003)(38070700021)(11063799006)(261026121527099003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W5RLZOuEuCcQsg7ShljuzBksjdjmrultDaq0gcNam3a2OUfZtBRfFohvsd55?=
 =?us-ascii?Q?FtauUMsAaZcFdsaCLOLUx5g8NsAKrYPUK8SRD/onjsStji6vNCEy4Dn0QLKC?=
 =?us-ascii?Q?T3z5+xM34nmO9xTJTNXSjwIsmLGUDsYobEZ+VqOOeNldUmTAltlBYJznkG1n?=
 =?us-ascii?Q?gbyJwLM52vK8+TUoiVpqemr+n7E0GYnShc9Y6ags+7MndAkU8pGu+WLWrxyJ?=
 =?us-ascii?Q?FP9s2oVy7o6lzbCVZhYDrPTo6smO7LSbhqTgLZhxrHuJ4bB2K0yJHRiidKVx?=
 =?us-ascii?Q?ZnO9+TXmgzV7Ly0t7LEe0iyNmz4I2gLMlvwzsuXuYM0na1m+fskluNkZ4gBp?=
 =?us-ascii?Q?2K/K4LeAXNN1RIsMA6U4GDCI0WD8sCIgz7AMaL5k6r7TeAEDMyjW8XxzQ/1u?=
 =?us-ascii?Q?ZDm9c6oZ8rK2X0O8bUDdMv0w4ZGY66npKSYzp34axF4IzbJ1/Lb0aVl9DbuX?=
 =?us-ascii?Q?mHaXAhvRJV38HjYpAmSUwNQDiNHYXbp0HUJOuneXLQ/WIEDmctf3mv4YPeCI?=
 =?us-ascii?Q?Xa8tFsBU31LIYI7DQvJsuk5xDWzuE1+jIpDSQ7Z/QxIOGHcwVYCSHUizXRf8?=
 =?us-ascii?Q?YOQvXl1mB3poncBQTrWDNnRMHS/rDgi5YRZjfq9R/G30VDPtPUJ1VW10AFPu?=
 =?us-ascii?Q?s2uNlfC1LzUdxqK6b7ctn8xmxoRue4HF0BrEiTk7GfB9nb6FW5GQkn0rvKuI?=
 =?us-ascii?Q?cWteBKSkErN5I1Rtl4YQaG5Bq6Cmu1Jl4GKoJ1G97wVA/2GZHQjqnRuY/H0V?=
 =?us-ascii?Q?a5IILzQTEyivMEX+AUkKGdJibPsxkp3fllvSx6CDzdnDiiJd9iQDm6mLOo8C?=
 =?us-ascii?Q?wLQ6C8aCg7t2rmvzvK8El4CQQnXe9rSSe4WvwJIAKBp4JzCqEeOXpvOSRoBu?=
 =?us-ascii?Q?RQexi+verfn1nGqF43j3rngQw7h6dyfxZ64rBR8YG0Tv4o9vdQtQM5r7VTSe?=
 =?us-ascii?Q?0TvB1yOCqYW2UA7lTNi1RhMHHYoEJ/muuQAwe3Uetv97ppiIKskvnvo0SzbN?=
 =?us-ascii?Q?s8J/tCspBYjKmY0pyxRJvfRf1uGnFBtegoIgnb9A0JRJM6iGXi8/oXbXobfH?=
 =?us-ascii?Q?0ofe2gWwtay+4BjnntpJjnnM2SJeXGAiECQb7neKhYdcq5m+oBqIsM+rTJSB?=
 =?us-ascii?Q?Gw0P9neZRnhsh4d9ON7WDLAGayk4KxnVqzcH128DCtjf6Dkh1JDtkFug5a4E?=
 =?us-ascii?Q?WVCluHRpOt1QewPzu93eV6xWBK56CbN9+hwsG8M+ZGlU/6kIPOhsoRDsy9ym?=
 =?us-ascii?Q?PdDqre2+yAUk9x0A+R6wt+qcjwwHGP1MacgpfW2pWJJlT3kb6NRUUpm3gAcM?=
 =?us-ascii?Q?0W2FmVHH3Hm/LzvRGOfZCH7UKhNn7uo3sQ/S6OK1UQiOq+cGyqOlsrN9jC8H?=
 =?us-ascii?Q?yu291Fleq9ww06855jf6Wnd52Fq0pWM26uScOUxvQP+Gohms3WSVvfUVu8Yv?=
 =?us-ascii?Q?WJnxgOpVneRGeVuq2+hXno4NCAnx+PDaobbWHrozsPK1/Ro0epbCvp+XZp6R?=
 =?us-ascii?Q?uDmxiW8dUDta5cvZ67FEdDWrUmTElTrdMJuIBhnFfUjP8f3twoTG3TD+RjPr?=
 =?us-ascii?Q?YAUergQesJ8Q+OpRApQYvji5Kpi6W6bx4d4U8q8HcaI/4xmCrQx4bM1uG5vV?=
 =?us-ascii?Q?PRDEu1ondZY2hm7n9Qjs9jv22ruvzXBHVhHB2L/apqC4Ls1u719RfM1+nzAc?=
 =?us-ascii?Q?5i74x2ELKoXFRSfAQ3cyvLTjNsJqNWUMCgozGL6FaYdW4En3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdf1676-89fb-4784-111c-08df49d23ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 02:25:40.2643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCifXsbwzSItz22S5f/ZtHOqNItZURRgdH5PYthgKFnCchGnyjw/O+Z+EU8PE95+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian and Cascardo,

Thanks. I'll leave the page-table clear failure fix to the existing
submissions. Cascardo, is there a current posting of your SDMA
NULL/empty-job fix [1] that you would like me to follow?

I've split out the void commit callback and the job ID change. Would
you prefer to post those two cleanups yourself, or would you like me
to send the rebased patches with your authorship?

I'll start a new thread for any patch series I send and keep the
allocation and CPU wait changes for a later series.

Thanks,
Zihao

[1] https://lore.kernel.org/r/20260914-amdgpu_vm_fixes-v1-1-d6d835591e0f@ig=
alia.com
