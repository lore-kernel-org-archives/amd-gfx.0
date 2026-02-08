Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C399EF06E2
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 06:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B46F10E2E2;
	Sun,  8 Feb 2026 06:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4q/3GqOi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6467110E2E2
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 06:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCKB03ogRiWOIA0G7hYBa920gNkc5t5VPJWLJ8UCihq8lMgXYBJxYL19X06Cd8nVQGqHY/6wsURiWqlliR+8skILN+fpqT3jdL9IXTTtvCEYEj7ClODziYV7yr6JOJQLq01LfS1o6tEod96RvwmuQKAwtkE1sJyfuWVKX+B+CajTCsGrVblyKijWipevBQLgsuxDvyqanwu0DveuY7yH+vO1cyczQhRAXRoeIMj9yOIeFR5tjkLpUIiEkZ/U/W8uWxVBIAjwDfYT/P1z5qrQKgrlue4Cg3jjUcoeJrTdOYBt5tJIjIPigL7e5wTNkbG7I20vZ1EIhrcXkofcRO6JbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Kk0FidSvNUHlCtALYknu1ja8I+ewX1fHDLVtb6g9HM=;
 b=Km5G3lnwBvO6wX4nLSYFrqrcBc2sSf6xBLmPrgswFUV/3RsyoJBlkRBNn7I5/uvmSg8wCzkMWQAQSjPhEKkZulRoVP1Cj46uQbdz7FyLNoySfyAMEeV5vE4qylfBsYupRCsunhMBMTuhLw08K9oPaMB3bYNulm6ckf3lc3qkvisABEe2E1KrVgqTgVUIu54UM6XT/UED+Zv7ldAI/TSv021r4UZUFvGwe7FH/FUE+PGDqAh+7sKIDojUXPCdoOdR5EhVMY9unaaeMR1GY3lpVFU1nGTI7az4a3wlKMvAsLqYKJIF4uFTcF4bZOVRCI6WjJ/gC+46sJTPmtrBGaa6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Kk0FidSvNUHlCtALYknu1ja8I+ewX1fHDLVtb6g9HM=;
 b=4q/3GqOi+ybA2nut3UTixJuCYK4jwTRqIcEK95TPZSx/wrc4IGf2MxH/zcfuB8rHiUhRIt20/HIvx01FlNjodaG+TiVZQajAlD8ZrQTCOGbaTE2RQ5dVb3sOYa5+EobUe9hAavhGw9MHhM7+klSsLzAjT/o04aZFgLkCY8ydGHY=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 06:31:07 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9587.017; Sun, 8 Feb 2026
 06:31:06 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amdgpu: Fix missing unwind in amdgpu_ib_schedule()
 error path
Thread-Topic: [PATCH] drm/amdgpu: Fix missing unwind in amdgpu_ib_schedule()
 error path
Thread-Index: AQHcl3RfrOA+ZIBeH0q/VIIpF3ZHZLV1zMkAgAKM3KA=
Date: Sun, 8 Feb 2026 06:31:06 +0000
Message-ID: <IA0PR12MB82088B4B8C846AB28F2447229064A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260206142445.1476609-1-srinivasan.shanmugam@amd.com>
 <1608dc23-cbea-48eb-9dd2-dc1bd9e5804f@amd.com>
In-Reply-To: <1608dc23-cbea-48eb-9dd2-dc1bd9e5804f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-08T06:29:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS0PR12MB8070:EE_
x-ms-office365-filtering-correlation-id: 19202162-e0d5-4800-fb56-08de66dba405
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?UHJCbHB6RWRkL0p0ZU5xb1JpNUFaTjBodFZIY1RLY0IxSXpxQ1Qvb0ZwOWxS?=
 =?utf-8?B?Q3hkUlZwTUZnYlJROHV5OHNaRFpFcWZGenI1Tk5MdnF0elVJRVFYSlYxSUYw?=
 =?utf-8?B?MXdYU3RubUpRRW5ueDNZYTVGWVdsK2dkMnRjeHpqY3U5R09BaldxcTV0VzU0?=
 =?utf-8?B?UWc3amlMbm05VnM4eVJiNGE2ZkNQZWRqYVRhVGN1RmFJQnV1Tk01ZlJzNHYw?=
 =?utf-8?B?UW1NMTVteFFwREhLTktjYXZjNmQyekp0ZkdtMHdRTzh4Q3d1R2dJcDdxcDA0?=
 =?utf-8?B?b3FhU3cxUGVabXFOMlV0b0dEc2lPTDNDZlV2SzhtOUoxVkk0dFc5WVZnSWtq?=
 =?utf-8?B?a0ZESngrN1hyVWFiSTZTaG1aSjRlZFJWNE9YMUpONTk0V3JpbWs5SFcyY0pn?=
 =?utf-8?B?Y2xvSDlCMFhQaHhQcUZPWE8xbGVEbG96SmRmV2RqUzFBOGNmVnFCdjVaQ3Fk?=
 =?utf-8?B?TXViWUU0ZjhlZ0IxS2NmSXNtb3diaVVKYWJOSVhFeGVTSDczek9sSXowemRG?=
 =?utf-8?B?Wm1rZm9ubllsVFNuT2s1SmpoeXhFNEpJeWI5cWRGSk9wSnNJL2I2cU9BTXNp?=
 =?utf-8?B?ZXh3SWJhSDV4N3BySmNMNE5nSFY0aVlpTkNrOHZIMEZFU2t1THB6SEUrN1Zs?=
 =?utf-8?B?aGtkQlJSV2YrMlRYcjRPVXV6OCs0YVFuZ2VBVDFuY0xTQ1VMZW9aQnFWK3hH?=
 =?utf-8?B?WlphOUFxejNJT2VCSHRteWNkUzdRWkNSYXF2aDVMWVF0WWttaTd2MDZqTjhJ?=
 =?utf-8?B?L2FjRDlYcEs3RjgzMnBlYWxmZDhUU0pwVThWOWhCd2Y4ckxpNUc1by9QTFhY?=
 =?utf-8?B?dW9RNld1bDM0eVlpUm16Ukh5OFJEZDdqSXE2dFRoS3FoVEEyQXlGeU9mbTRC?=
 =?utf-8?B?TEZKa0pDSGEvSFJ6K0VOT0RIZnc2ZkI1SWJWTWJoc25zbCtObE8yOHcrd0pR?=
 =?utf-8?B?NVpsVVMzdTdmaXFPQ3J4RW03Vkk2SXB4R1hDdFdKRm1vTndUTU50bmx6ZFVN?=
 =?utf-8?B?VzkwNlhGRXEvRS92cmVsUHN4QlEraWlydSs4empKTGs5ZGR6dy9KU3ZiS09T?=
 =?utf-8?B?TnJuWFJ5S1FJV2gxZHI0eXFacm95VlozNDZGSGFyYXoxN2NDdDUxUTltenBu?=
 =?utf-8?B?ay9LazlmeGtGSGJuNk9sOTB1cjdmS0FQL1d1dFpkaUIybi9aNlhjN1ZiMlNu?=
 =?utf-8?B?bG9aOUJOUVRqaFhtdUpIR09ZR0RKSkJIV1lBSis4ZGc4YXVPU0JtaWdwbG9y?=
 =?utf-8?B?WmpkZUdVWnl1YlI5cUxiZEhFLzNMTDJWd3lHelZHaVloR3BXT2hpdXQxVEU0?=
 =?utf-8?B?dkxJOEYyQmVpTWxLd1MrRlpTbUd2aGNseS9ESFI4K2tyUXRVTHlZc3ZmSGVD?=
 =?utf-8?B?M2h3U1JaOE4wV1F0OWdLakMwMkNSSmFrbkVZTHR1cy9VOFI2MC9CZmpnQkgw?=
 =?utf-8?B?T1poNVpoaDF3dTFraFJDeFZQMXlsOXkyZk1EekIvaG82aERUZWNibFZLOXNE?=
 =?utf-8?B?SEluUU5mYStwR01vVEg1SmpqT3BYcTVYcWRiT2x3Y2Z6V1VhaDg2SUlRalJw?=
 =?utf-8?B?QlF0QU52WllXZDdUdEU4QUh1OWhWK2IzZVpoMENTOEFxQXIvTGhVaVBtT0p0?=
 =?utf-8?B?eEExNE1zOUhLUUhZOFA5YUp4SC9Fam1FQmt2dUFFMXdXVU8vUmthZFc4MlY1?=
 =?utf-8?B?T2NNUkxTRldQMnNFa2psNU1ZbEtsMElYWFJsUGtpTnpjanFEZW1kc0ozc2dW?=
 =?utf-8?B?cjZha1VSUGY3dmhwNzRFVmxiRThvdTBMWXRtOWNBWHU2V2RGL1UvemxXcjJ5?=
 =?utf-8?B?UGNZL1Q2dFcwZ2cvdUFCcnJ6bVlxd3NJamt0bEV5T1IrbXBBQ2pWWm1VeGY0?=
 =?utf-8?B?WlpLNW02Mi9yYmdJdFVtTG1kSEFuaW05RjdpU0xubm5oSnFNeUovbm1IWGVK?=
 =?utf-8?B?b1pVUU44ZXp0bjluSFVFcWJWUlpZUWRqeDJvb2MxRFlhMUtQLzZ0U2h2K3Ax?=
 =?utf-8?B?VThmWDdaV085RXFaemk0R2dXZjB4SWJla1ZDN04xbjBleVRkZUFGQmJjOUtC?=
 =?utf-8?B?eWQza0pGVXZ2SmtZRUlzSTZjQkZUT1c2RDdnMUZidi9zTitvWFpTMW9OVUlB?=
 =?utf-8?Q?Jx35GnVAtoRTFKmDTrcLqToC7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXRQNWxOSUFwVEE1ZUxJV29VRVA0dkREcTVXYlRrVTI0RnJtR2xHTDcxZ3R2?=
 =?utf-8?B?b3BPZG9TbytkL1N0QVhraVozTTEyS2k1dlgrK0xveXUvc2VVZGV3cDgrelVE?=
 =?utf-8?B?bDEyRmZaSTRuc2FyVk9rNkRqM0ZOV2hkTG1uUEZuR3NWcHY0ekI2VlNDc3dq?=
 =?utf-8?B?d2x1bmFBYlp6dWZ3RDJCa3pneUhUd0d2T1NsS1NqcjZRN3F6NE1VVW81Y3N6?=
 =?utf-8?B?RCsyOTRqRVhGMTAxNG1CZ0xUbTZua215cDJDNyt3WmlHdEJXcjhydmFCYTVo?=
 =?utf-8?B?TVAzcW0ydmVVWXJCd0lYOXFnVWF5MFpPaGU0d2ZYaWc3VHkyK2dGNFpteXVz?=
 =?utf-8?B?WVBzYmpzL3FlNWwyRml4enNmT3dsbndoNUo1TmgyQkNuUkdJc0dod3FnbENq?=
 =?utf-8?B?UkJBdFFCSFlvOC9OWDF4OEUzb3owTU5DTWZtT1lTUXJZZ1NoU09JQW8xUmlF?=
 =?utf-8?B?T1NoMXk5bnVyL0dGWGpTMTBvV016OTdGK2hhOFJWbzVEdXFqdTA2Qi85bi9o?=
 =?utf-8?B?ZmNoUDVLRWcvbzByUnRYTkdqYzlxckhkQ1lYU1ZyeTNtamJZbVh0SEM5WklO?=
 =?utf-8?B?Z3lVR09BUUpOMXRmbjYwN2hKc1gyQkpoSCs4bkJaMkZBSGVpR1I4QVJBU1VR?=
 =?utf-8?B?Qm41VWh2WWVFeWdCUWFvQ05rRHRoWWdjYm0yWmticUhoSktSdzVZWkU0ZHM4?=
 =?utf-8?B?MWVSYkVZTm9ydGY5YXlvWEpweTg1a3UxaENyVnMzSlpnRFBPVzFKY2s1bkZG?=
 =?utf-8?B?M3E4RlhISXFmNXVoY2Q0VzhUS3Z3akpaUHhod01uR25GUlN0M21TZjJIaXpt?=
 =?utf-8?B?SzZab1pyZTJTTkE4dFptTnNHVnViOFhqbS9TKzdoVU41NXA3dWlmcDlPbDZv?=
 =?utf-8?B?WjR6blIrU0tJOXhySElESjc4L0NuTzliMUdtU0JVV3VlNWxjMmpBRzF6dVN6?=
 =?utf-8?B?RjhNUi8wU3piMkM5K2hiUEhQS2w1alh0Tm56eVVzOHdkUHMrVlVQenZveVgv?=
 =?utf-8?B?dHoxMG5vbUdockNkbWpBWW9RTFNxeXRyWng0eW9mMWp3THRZOWsyNEtMU0c4?=
 =?utf-8?B?K21YVStieWNLVVRvYldjSUJ0R0JVayt3YUJZNUVMWDJzSXBoN2JIaytTektC?=
 =?utf-8?B?OWg2OENDTFFZNWJCMmpVQ1NkTWdHYXg5S2lNSjdhMng1c205NUh0N3ZjcEdD?=
 =?utf-8?B?MFJ1SEsraDArU0o1STRJbnFmdUF0anF3b20wRU8xSTcxUFhWblp1cWRPQ1JY?=
 =?utf-8?B?bVh6eEdWcWFUR1ZvMzByNE9NY015NVF0YVNGSHlzczBkc3RRTmV0MUt1NHl6?=
 =?utf-8?B?M0l5dThreVV6Ri91THJ6dnZwYlVxWGRXREpNRDkxaUo0MGlLL3hHRlFNa3Z1?=
 =?utf-8?B?dG5ya2FaMU1GL3BjWjBuV3hnYTM3ZWZFK2Zocnh2SVl0MUpiLzA3VytGTEdX?=
 =?utf-8?B?WXl4eXVpZnVrU010Z1A4U09PUGZzVWhzN08xaXU2b29TRW83TWM5cVRyT2s3?=
 =?utf-8?B?WmpyZVIvRTREaXNDc3pHY2kyU2JGcHJwR2RVMHNkUDJPcGpZUmk1RGE4S0pE?=
 =?utf-8?B?R25KcmNpY2xVMjdvY2FVTE1hWVphK290NmRJOUYxdDlwMmtLWDZyR1g4T2hu?=
 =?utf-8?B?M3ZlN0pjVm5ZZlY0bmdEVXF3T05wWDNUV2ZORTJCTWNETktvNVlLTXlGdlQz?=
 =?utf-8?B?ZHdiS203L3RVWXZMRnZTK1ZMS3l5emFoYjUzU2RKUUtUclVHL1d6SHlodFZu?=
 =?utf-8?B?VWRuTTFERmFiaVFaT3RRUEw4TTh0c0doaXlHczZ3MjgzTGpDdzBhTG1FZ3VI?=
 =?utf-8?B?UHN3cnY4RitIa2xGS2xNRnpEMW1rZ2JBd2pIOHJmSzlqdG1NSVhpTDR1b1dr?=
 =?utf-8?B?RFZTa1NPT2lmZW02REtIc2Y0aEVnM1I3Z3kvNW5icm4vT01TUjF4c2sraXp6?=
 =?utf-8?B?T1YxKzlheXpMeHUxMm14SEtjTndtV2xhYVdDOTRzbXhhblg0UFpIeHRSS0dN?=
 =?utf-8?B?eEpxUGVjdkdJbllQWFJqcHQ4MXRTNFN0WkpVMEhQM3NkWVk1cFdCU3gyQW9Q?=
 =?utf-8?B?MUVpc1RTVW1UT3NOVlU5d3lLck14VEtuNkxmWDRGeFJwek1lWkF6U2M2UEJQ?=
 =?utf-8?B?QU1CVXVabHp0SmR4NWZXeE9PTHliTnhJbHNMK3BLc0YwQ2NGZUMyeXc1cmFN?=
 =?utf-8?B?QXRjRVoyZ0VpTDF0Ly9Ea0lkcG1sTXJEdGVDUTFXK0orSEhkRkZXZjNrd0RP?=
 =?utf-8?B?RGVDV2l3d29qS1hXTlBOT0lSbkM5OXhtRFFQcGplUDBsNmVRb1ZqMTZ4QmFH?=
 =?utf-8?Q?Xicn2uyItCH1+MJgwa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19202162-e0d5-4800-fb56-08de66dba405
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2026 06:31:06.8425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HziLhPLt+y7aabS0bZIqrLIYcCcPjz/LY855OHiz2HzGaf/16pKZs3nWiuDnCvVANlNcI3cLG0r2yYdD8y+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDYs
IDIwMjYgOTowMyBQTQ0KPiBUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNI
QU5NVUdBTUBhbWQuY29tPjsNCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERhbiBDYXJw
ZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogRml4IG1pc3NpbmcgdW53aW5kIGluIGFtZGdwdV9pYl9zY2hlZHVsZSgpDQo+
IGVycm9yIHBhdGgNCj4NCj4gT24gMi82LzI2IDE1OjI0LCBTcmluaXZhc2FuIFNoYW5tdWdhbSB3
cm90ZToNCj4gPiBJZiBhbWRncHVfdm1fZmx1c2goKSBmYWlscywgYW1kZ3B1X2liX3NjaGVkdWxl
KCkgcmV0dXJucyBlYXJseSBhZnRlcg0KPiA+IGNhbGxpbmcgYW1kZ3B1X3JpbmdfdW5kbygpLiAg
VGhpcyBza2lwcyB0aGUgY29tbW9uIGZyZWVfZmVuY2UgY2xlYW51cA0KPiA+IHBhdGguICBPdGhl
ciBlcnJvciBwYXRocyB3ZXJlIGFscmVhZHkgY2hhbmdlZCB0byB1c2UgZ290byBmcmVlX2ZlbmNl
LA0KPiA+IGJ1dCB0aGlzIG9uZSB3YXMgbWlzc2VkLg0KPg0KPiBJbiBnZW5lcmFsIGdvb2QgY2F0
Y2gsIGJ1dCBhbWRncHVfdm1fZmx1c2goKSBuZXZlciBmYWlscyA6KQ0KPg0KPiBJIHdhbnRlZCB0
byByZW1vdmUgdGhlIHJldHVybiBjb2RlIGFmdGVyIEFsZXggaGFzIGNsZWFuZWQgdGhpcyB1cCBi
dXQgaGF2ZW4ndCBnb3QNCj4gdGhlIHRpbWUgZm9yIGl0IHlldC4NCj4NCj4gTWF5YmUgeW91IGNh
biBnaXZlIHRoYXQgYSB0cnkuIEl0IG9yaWdpbmF0ZXMgaW4gYW1kZ3B1X2ZlbmNlX2VtaXQoKS4N
Cg0KSGkgQ2hyaXN0aWFuLA0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2ssIHByb3Bvc2VkIGEg
Zm9sbG93LXVwIGZvciB0aGUgc2FtZSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcv
cGF0Y2gvNzAzNjM1Lw0KDQpUaGFua3MsDQpTcmluaQ0KDQo+DQo+IFRoYW5rcywNCj4gQ2hyaXN0
aWFuLg0K
