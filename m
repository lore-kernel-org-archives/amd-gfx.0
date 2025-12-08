Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB730D3B7E7
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 13:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4D910E44D;
	Mon,  8 Dec 2025 13:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=northeastern.edu header.i=@northeastern.edu header.b="GxUpMBBv";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11021109.outbound.protection.outlook.com [52.101.52.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2315610E0D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 09:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNt31KMUXrMW4YuUZGJ9JW+ttT3oYuTRvewZMAIKSqDQyzVRoryXWRbrIoTNXnuJ4i+4k9y1E2tiggn0nnM4Lq5S1BgDiv5GXkf1wonR3bubef6xQb7zLIgT4ItBhmD3XaNdyV+q7xqiMAz0m22/8alWZRqWN9/4GDMfvyvbjX0X+zJSflHzflQvDoba3YGxe1ZigQzaJ3d8er+IUW6NH2WS4/HTKoj4IqBwcnrjS8TTaRdcpEbmysW5D3fWaOveKIhORAXuc1C/SaBx4cauA+ARRwFqm8oJtdGtf5Tm0CHqicJnUzmv2oyLHQ7LqzxIgJSrpTTiAhLZup+PHYLmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWdz2zr7ND5hbl73sOYCNig9dBJhh9Y2vJ5Fr7zCBzU=;
 b=rX3QWOBzPrbfuXej8HU8pUAUeGS5WroxNcOQffFMjHrsbtaQ5NAwn0lecFsJ+pfACezSOi00DV9ElL8BRXAyINjprioyurQ5Kck3evAv/9skXKvTHEZ2bcmiOC6+Yp9w7Br6UKScMQb2OhoK1Aohl/l8puThmHbGbk8JQVyoldIxN75FZA6I7wcsWLvR43pInigTRymc+DZ2Jecp0KHf43bTyaRjwLzcu8mYTlpok0qKDD0mILQejDR8/OThJYC99Pn+eRwDoTsYO0h7YB+4L4n+BrHdcpdM99iW23jE3+NhMH7KGAMa36N5WiP2+tAPU4pvn0ICortucLygF3/m+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=northeastern.edu; dmarc=pass action=none
 header.from=northeastern.edu; dkim=pass header.d=northeastern.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northeastern.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWdz2zr7ND5hbl73sOYCNig9dBJhh9Y2vJ5Fr7zCBzU=;
 b=GxUpMBBvupyRiyiVM7q0qKHCggAPej013zdeoQ3ZTXAaKi+qCSIivdHnPzcPtxFczUUUzpWd8uQCcvqkaHCA5gWZJWiqop4RHOJW04lRBLhHd/x1KktX2hRKyiDAgTZxnmBMmuWjzmt5Iizfv4t2qbdzC3KuFm1Bg4nE8s8TC0EmgseKl7zMctKFJSXiX3rghqkKstnMu7qgdI9lHGjcJroc2O+y24sWvuVWX/38Z5+7KTy4+98qHaCl7rhgd2gmPV+9kFFvd2miP+UwFp/UfKYpdaS+aR46emhA2qym0nB9FB9D9AfiVlZA3zphDkYfVBVGnaiYgNyeLih4qaKhuw==
Received: from SJ0PR06MB7178.namprd06.prod.outlook.com (2603:10b6:a03:2c9::13)
 by LV3PR06MB9524.namprd06.prod.outlook.com (2603:10b6:408:19a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 09:23:40 +0000
Received: from SJ0PR06MB7178.namprd06.prod.outlook.com
 ([fe80::ecea:ba74:4e20:b700]) by SJ0PR06MB7178.namprd06.prod.outlook.com
 ([fe80::ecea:ba74:4e20:b700%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 09:23:39 +0000
From: Mack Wang <wang.yunche@northeastern.edu>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [bug 6.18] Failures and Resets on GFX1037
Thread-Topic: [bug 6.18] Failures and Resets on GFX1037
Thread-Index: AQHcaCRWth7k07MMqkGIMxJDvrqZ7A==
Date: Mon, 8 Dec 2025 09:23:39 +0000
Message-ID: <aa6e3fd2f20baf83d5bf56f880bf01e975829cd2.camel@northeastern.edu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=northeastern.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR06MB7178:EE_|LV3PR06MB9524:EE_
x-ms-office365-filtering-correlation-id: 13b7dcf9-20d4-4a4b-9178-08de363b793d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SHNsaWY1QjVHb2NlSjdDcWJhc2YzN1BsamRYY0daVFlVYk4vTUlGRTBBVE9C?=
 =?utf-8?B?VXUwdXhNYWpjTmhuRXdTVE9jQWd4Y3FxY2JqV0w1MVRkYWpoZUhQUlJ3TGhQ?=
 =?utf-8?B?UStBZlFIci9WRmNOd0d3TmVZa01oSWNaR0dUL1ZhSUlrSC9wS0tuVGJpMXRn?=
 =?utf-8?B?emR5YlVramFRVjlsa3k0Vm8zWC9YVm9TZXIvbVFLcVhuWGNjaGora3JxUmtR?=
 =?utf-8?B?UGsycFl1czRnZE5GUmlsSGNBclg2WHhWdjZybi9CSjFsUDBOQS9GT1ZsdFpa?=
 =?utf-8?B?Mi9JQW1welYrQlBPZWFIMjlKOExqYlBpNDFmOWkvUHJSMzk5QWxMVWR3cEZo?=
 =?utf-8?B?Nlh6am9tR3RnMkFVd2F5a09aMGFHLytZWDZjVm5GRHhicWVVWWwzbjVNZXpv?=
 =?utf-8?B?QkFFRUxpcTNtRXVpU3VpK0hZN1Z1bWJGUS9XMWIrS256TWg4RURmS1N2Nm5C?=
 =?utf-8?B?a0JkV2pZWldlV0ZYMkU1bWk1VmkzVVJEUVJ2WGJ2VEszTzBPQWJyV0VXemxL?=
 =?utf-8?B?TThwaUg3K0JISjdSNytDbEVIbDNHZUlzMnRmVzJLYTF0cXFYU0Vhb1Rnekpa?=
 =?utf-8?B?dTNMcEo3L1B6SzdLUm9xT0ZZNWJOSGo3RndBT2plTnZXZmhkRmx6YUp5YjFK?=
 =?utf-8?B?QTdnMUU5dXNiYllaV1Y2RUllRFJTUC9BODZiNERKdktIRDFpeC9icy9HU2pz?=
 =?utf-8?B?ZGlYbFl1b0IxNVRvL1VTb0RHOFNhSjRHSG1ZT09LM3V6aWZVU2ZjcGd5ODdN?=
 =?utf-8?B?VmlyVDVpREJGeUxMSFBhcEY3VDZhTWFnNlMyZ1AyRlM3WHZrMUQ5RWlOZjg2?=
 =?utf-8?B?TzgvWGkwQkdQNlRNaFNyVVhIR2VaNzVGQzNLbEZXQ3oxa2JvTTVhVXpGMVpi?=
 =?utf-8?B?TkJDM3VlVWNlenRkbUtGU0NLT1BDcjROQ0t4dE1nNUx6Y1N1dW1hN1Bycllu?=
 =?utf-8?B?VFJiUHVta1VPY0N4QlZzN1A1R091TmFjaVNCdXNFUEFITDl3SFBxMEpPc2My?=
 =?utf-8?B?Mk41UEZoWi9Tc3hDN2ROREdtOEt4MnJRVmpwQnlXSi9VNmhqQ3RQMXU5aFdy?=
 =?utf-8?B?NTBGZ1RVNlRhb2VrRzJhRmppbWQ5SVg5anlUMll1cWtjOUNJdTNHME1JQS9L?=
 =?utf-8?B?VHBya2N0Wk40dTIydnl2dWgrZDNlSzMyTXpkdDFMSEdrVWx3MDhRc3l3OVYz?=
 =?utf-8?B?cFdCQWtuR2FPa3BPbzFKcy8ybmxkSWpDaFo4dzVrKzZOYWExSUFENXozcUdK?=
 =?utf-8?B?a28zUERDWDkxN0s3OURDSUMzVDNwblRMUGRtOE9pakZ2MXJ1MTc3VW9vS2Vr?=
 =?utf-8?B?dHdYMEFoSGc2ZTVtdVhGSVl5VDdBcHBUcEt1OGVOMGNmT3M0a09pamJzUUV6?=
 =?utf-8?B?UFFqaFhsdWRiV0IvZzNlMFJiMHFwdDZ5ZExTSWRrcnp1UXpLZmN0N1luYWgr?=
 =?utf-8?B?aDNNbVJWUGlGakl0S2hKbGZNQUxlTEExV1Blak9OSGxxK2RMNlJyU1JpTzFN?=
 =?utf-8?B?R1lmY0w4THVFZ2RhTkhidWsxUWlHUlNoNTRnTU53Rm9mcFNBWjZnK0hKSE12?=
 =?utf-8?B?bm5MM0p1bXNtekRzVFJQaDZyT1dIOTBrZ2pHMWQ4Y3RCc3JRM2tWNkg2NWJw?=
 =?utf-8?B?VHdvR0RNM0x4YmdBWUpzZTJOT2RQZ2tBT29OM0RiWllHME9OUEdUMFZxZmRz?=
 =?utf-8?B?ZVRGS3ZXclY4WExZTC9pMzIvSGZYVWJpenpYUWxHOFFkcUlUYlowbDJ2MjZX?=
 =?utf-8?B?SUN1VzE4MVFKQy8vZjA3cDZtN1F0aUtJVloreVdMRnJyNzdhK3V5eTNIQ0Z4?=
 =?utf-8?B?aitaMFJvUXBEeVdZWEs2SXVLZ1l4bHNmNm9BTURSWXFkUjRCZCtyKzNBTjFn?=
 =?utf-8?B?bEJITjNuaG10KzByRjRxeTI2TnppMU4xMFJWQ25yOTRLVEtyOUJWTGZCVlhE?=
 =?utf-8?B?bGdWYnpBV1QvR0ZqeFlOL2RuajNXdk9YbnNNc3lzd2I0NkREaTlkdm8veHZk?=
 =?utf-8?B?SUpzcjI1eXUyWDFzT3UrZ2pUd1lvTnZCc3dIQTJkYnhvR2hGTWZycXpncFNG?=
 =?utf-8?Q?oH8XCV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR06MB7178.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVpZVXNqSTFjbGRKSDQ5L3o4dkd5RGhMOW1XRnlVanNOQk4xZVoydFRCNWJt?=
 =?utf-8?B?THVkWlF2eWQ1TEozdHptNlZralpXbTJNWUYvR003Ry95YmZ1dDNLV2VJOTlh?=
 =?utf-8?B?V1VmbDVWb0I2ZHJodlhlcGNFUGJWckNJVExLYjFTeDZ3dExxc2taTXpqQWVJ?=
 =?utf-8?B?b3NucTNyWVlVVzBYckEvYlVHTHpPd1VtOUVyVjd2ZTY3TGZqTFR2dXh5bGNl?=
 =?utf-8?B?dWR2aHpsTXVESTlTcUdrd204VDFseGlqUWZMdktkeXZhWnZqK1g1Q2prUjBp?=
 =?utf-8?B?bmhncXk0OC82S0djMFJ2WjdTUEZYM3JpSUZNT2c5eitDWkRQdXl6UmkySUZm?=
 =?utf-8?B?c0ZGOUNFaWpqQXpJM1VsNVVDdGJmNDVDcUg4TEF5Qll6c1pKL0p4RHV0RXZk?=
 =?utf-8?B?QklZZXlXZ0ZHZFNIQU5SNm40MUlXeTNrQllUVEdDY2pFTGJFL0xFWFZJeERW?=
 =?utf-8?B?VWJmRzRCcXRtZlczRlhSZzdwTXM5V0JTMkE1VFMzL1YyS1VJc2NHWlJUWk56?=
 =?utf-8?B?a2h1VmVyMnBadm9rK3JVY08vS2lGVXNRd3huOTN2VWsvYlE3aGhCNHd6eDlr?=
 =?utf-8?B?UTBzTThJNElTeWgxOGJFdjZmSGl2VW43Z3BtYTFLSVhXU1hQWlNyRXJ4SjNW?=
 =?utf-8?B?TCtSYVFXYTMvUkNQQWgyL3hKdzJTaWtXbWtRWll4YUdlMDFPMldmQkhGTkp3?=
 =?utf-8?B?YlFMTzRlWHpnTVk0NlVjcTNYRUtDYk5OWllXS3BRRFdreklrV1RqTkVPTlZW?=
 =?utf-8?B?ODROZjJ2amlLUEVxS3VpT1c0Nk9wc3Z4dkQ0WW9PV2lZR1dqOGF2U2VKQ1hj?=
 =?utf-8?B?UVEwaTFxbnBkVXJMUGpQcjFqK1VXdkdYQzFJU0l5WU9PWGsxaU83T0xkaGVi?=
 =?utf-8?B?T041UGNKZFN2TXZRejdLZTFSUVVORnl4M3pON00xRjFiWXlJNFpQNjRSc1Er?=
 =?utf-8?B?bnJEelVWS1dSRTByeldYenYwVEtKWllqdEZQdXMxcmdnV2d3YTdJYnRDZ3o2?=
 =?utf-8?B?TEFMTjJYUzk1Zy9nTGFnd2Q1Zm05QjRGVnFnOU13WWxoKzc0YUlJQmRGL0Zn?=
 =?utf-8?B?bjJmVjNWeUlrVU5aUVZmU2hmVkI5dVJaQVlqaXlsRElsbUgrcTV4ODFBcVo2?=
 =?utf-8?B?SHl1RjNLTGkvUzU3cGs4Y25TSVdiZHN3RVRTbDJ1S0ZSTmlYbGZEbXdINFdF?=
 =?utf-8?B?c3JGZ2N0dUtOS0dxOHNDb3U1UDRKWkRHbFVmOE1hZzd2aUhBdmM2dU51ZFZT?=
 =?utf-8?B?N2VIZEdjN2hldndoSFRSTUxOVCtmY2lqTzN2UThLYWdneThBZUZ6djRqL2lt?=
 =?utf-8?B?NGhtQkNkYWJMUEFLK3ZuNUpmRnNraFZQR2lhMWZybEF4M1djLzVnYUZZcWtI?=
 =?utf-8?B?UkNldENuSytBUFMyamRNZlcvZUxVRlFYVGVWTHNOMytueTQ1RllDOStzVmtq?=
 =?utf-8?B?N1dLdDlXYnZCRXpYdjBPZ0I5a3k2MG5USSsvcEFCSmZMc1g1K000bk1naWo1?=
 =?utf-8?B?MVZwNGdOMEt5UjI2dEdCUkx4TEg2WDZmTEY3OTQ3R0h4Zjdwa0hsYnAwSUZX?=
 =?utf-8?B?WEpib1dLc09SdGF4Q0thNS9TN0tZaWJpZVFwbEtDTW01Z2NJcVN1alNkcCtN?=
 =?utf-8?B?U3poZG5zd1J1SFdyTVNteGJtTDVwZGxmbjZNNXltUmVvc1dxcm1hYnhqK0pG?=
 =?utf-8?B?OUVCZFRvOU5Obklield1TmlabUx3RjhYT1REK1JqUzk0aklESXF3alMya3Y2?=
 =?utf-8?B?Q1VablowWm5NRnlPKzdqMmN4Tmp2QXR6V243aWY5R2R3elFBanBGdTBqaGxO?=
 =?utf-8?B?b25DV1pQcElGMkRMM0NFeW1JVElKd0VQS3Z3NTNEbXVWc3pwdmdEMzN1dzcw?=
 =?utf-8?B?VmhXTlRiK3dxNG1mdTIzNXlmdVZaWDlRT29SVDZHWmsxTk1WYjQ0eUN6cUhS?=
 =?utf-8?B?SFB6REVLTWFUeWJrTFlHRS84aGFSMkhvTmlrL0Vzd2E1TUY3YkpTYTlIYjha?=
 =?utf-8?B?TlIrWW54SzJ5ZW4raDgwRUo4OW9BZW9UeEVJMjZTYUFjbU5Zd3QzYkk2QWFv?=
 =?utf-8?B?UGtDNWF0eEdyMTFVTHJ6ckswMzhVeVZ6c2JzWHBzRTFLOUVLeTk3R29FNWd0?=
 =?utf-8?B?OGtDT1E0YnNwTlBhZ2FLLzUwK3BNZ0JMQVRxVjJKb1IvTW9jRk1mL3lPcHp0?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4C1BB930D7BCC45A3CEFFAAD2880BF0@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: northeastern.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR06MB7178.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b7dcf9-20d4-4a4b-9178-08de363b793d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 09:23:39.7890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a8eec281-aaa3-4dae-ac9b-9a398b9215e7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yreZ/jMPLwQRL8C6t+TMfTquiRByNyWaM2HBMatoisT7j7OYKtfSWIiflfGOXypkknsLFxBjW8cvlDv46+G4a8JhOGPUEFxCcRFXajLm/M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR06MB9524
X-Mailman-Approved-At: Mon, 08 Dec 2025 13:51:12 +0000
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

SGksCgpTdGFydGluZyBmcm9tIGtlcm5lbCB2ZXJzaW9uIDYuMTggSSdtIGV4cGVyaWVuY2luZyBm
cmVxdWVudCBmYWlsdXJlcyBhbmQKcmVzZXRzIG9mIHRoZSBHUFUsIHJlbmRlcmluZyB0aGUgY29t
cHV0ZXIgbmVhcmx5IHVudXNhYmxlLiBUaGUgc2NyZWVuIHdvdWxkCmZsaWNrZXIsIGFuZCBldmVu
dHVhbGx5IGJsYWNrb3V0IChtb3N0IG9mIHRoZSBjYXNlcykgb3IgcmVjb3ZlciAoZmV3ZXIgY2Fz
ZXMpLgpFdmVuIGlmIEkgc3dpdGNoIHRvIGFub3RoZXIgR1BVIGFuZCBoYXZlIFJhZGVvbiBHUFUg
b25seSBmb3IgcmVuZGVyaW5nLCBpdCBjYW4KZmFpbCBhbmQgZXZlbnR1YWxseSBraWxsIHRoZSBh
cHAgdGhhdCBpcyBydW5uaW5nIG9uIGl0LiBUaGUgcHJvYmxlbSBpc24ndApwcmVzZW50IGluIDYu
MTcuCgpNeSBkbWVzZyBsb2dzIHNob3cgc29tZXRoaW5nIGxpa2UgdGhpcyAoYSBzdWNjZXNzZnVs
IHJlc2V0KToKClsgIDU4NS4xMDk5MzldIGFtZGdwdSAwMDAwOjA2OjAwLjA6IGFtZGdwdTogRHVt
cGluZyBJUCBTdGF0ZQpbICA1ODUuMTExNzU4XSBhbWRncHUgMDAwMDowNjowMC4wOiBhbWRncHU6
IER1bXBpbmcgSVAgU3RhdGUgQ29tcGxldGVkClsgIDU4NS4xMTE4MzldIGFtZGdwdSAwMDAwOjA2
OjAwLjA6IGFtZGdwdTogW2RybV0gQU1ER1BVIGRldmljZSBjb3JlZHVtcCBmaWxlCmhhcyBiZWVu
IGNyZWF0ZWQKWyAgNTg1LjExMTg0MV0gYW1kZ3B1IDAwMDA6MDY6MDAuMDogYW1kZ3B1OiBbZHJt
XSBDaGVjayB5b3VyCi9zeXMvY2xhc3MvZHJtL2NhcmQyL2RldmljZS9kZXZjb3JlZHVtcC9kYXRh
ClsgIDU4NS4xMTE4NDRdIGFtZGdwdSAwMDAwOjA2OjAwLjA6IGFtZGdwdTogcmluZyBnZnhfMC4x
LjAgdGltZW91dCwgc2lnbmFsZWQKc2VxPTMxNjkyLCBlbWl0dGVkIHNlcT0zMTY5NApbICA1ODUu
MTExODQ3XSBhbWRncHUgMDAwMDowNjowMC4wOiBhbWRncHU6ICBQcm9jZXNzIGt3aW5fd2F5bGFu
ZCBwaWQgMTE0CnRocmVhZCBrd2luX3dheWxhOmNzMCBwaWQgNTE0ClsgIDU4NS4xMTE4NDldIGFt
ZGdwdSAwMDAwOjA2OjAwLjA6IGFtZGdwdTogU3RhcnRpbmcgZ2Z4XzAuMS4wIHJpbmcgcmVzZXQK
WyAgNTg1LjI2OTQ4NV0gYW1kZ3B1IDAwMDA6MDY6MDAuMDogYW1kZ3B1OiBSaW5nIGdmeF8wLjEu
MCByZXNldCBmYWlsZWQKWyAgNTg1LjI2OTQ5MF0gYW1kZ3B1IDAwMDA6MDY6MDAuMDogYW1kZ3B1
OiBHUFUgcmVzZXQgYmVnaW4hLiBTb3VyY2U6ICAxClsgIDU4NS4zMzE0MzNdIGFtZGdwdSAwMDAw
OjA2OjAwLjA6IGFtZGdwdTogTU9ERTIgcmVzZXQKWyAgNTg1LjMzODczMV0gYW1kZ3B1IDAwMDA6
MDY6MDAuMDogYW1kZ3B1OiBHUFUgcmVzZXQgc3VjY2VlZGVkLCB0cnlpbmcgdG8KcmVzdW1lClsg
IDU4NS4zMzkwOTBdIFtkcm1dIFBDSUUgR0FSVCBvZiAxMDI0TSBlbmFibGVkICh0YWJsZSBhdCAw
eDAwMDAwMEY0MUZDMDAwMDApLgpbICA1ODUuMzM5MTEzXSBhbWRncHUgMDAwMDowNjowMC4wOiBh
bWRncHU6IFBTUCBpcyByZXN1bWluZy4uLgpbICA1ODUuMzYxMDUzXSBhbWRncHUgMDAwMDowNjow
MC4wOiBhbWRncHU6IHJlc2VydmUgMHhhMDAwMDAgZnJvbSAweGY0MWUwMDAwMDAKZm9yIFBTUCBU
TVIKWyAgNTg1LjU5MzQzM10gYW1kZ3B1IDAwMDA6MDY6MDAuMDogYW1kZ3B1OiBSQVM6IG9wdGlv
bmFsIHJhcyB0YSB1Y29kZSBpcyBub3QKYXZhaWxhYmxlClsgIDU4NS42MDIyNzldIGFtZGdwdSAw
MDAwOjA2OjAwLjA6IGFtZGdwdTogUkFQOiBvcHRpb25hbCByYXAgdGEgdWNvZGUgaXMgbm90CmF2
YWlsYWJsZQpbICA1ODUuNjAyMjgxXSBhbWRncHUgMDAwMDowNjowMC4wOiBhbWRncHU6IFNFQ1VS
RURJU1BMQVk6IG9wdGlvbmFsCnNlY3VyZWRpc3BsYXkgdGEgdWNvZGUgaXMgbm90IGF2YWlsYWJs
ZQpbICA1ODUuNjAyMjgyXSBhbWRncHUgMDAwMDowNjowMC4wOiBhbWRncHU6IFNNVSBpcyByZXN1
bWluZy4uLgpbICA1ODUuNjAyNTY5XSBhbWRncHUgMDAwMDowNjowMC4wOiBhbWRncHU6IFNNVSBp
cyByZXN1bWVkIHN1Y2Nlc3NmdWxseSEKWyAgNTg1LjYwMjc1MF0gYW1kZ3B1IDAwMDA6MDY6MDAu
MDogYW1kZ3B1OiBraXEgcmluZyBtZWMgMiBwaXBlIDEgcSAwClsgIDU4NS42MDc1MDhdIGFtZGdw
dSAwMDAwOjA2OjAwLjA6IGFtZGdwdTogW2RybV0gRE1VQiBoYXJkd2FyZSBpbml0aWFsaXplZDoK
dmVyc2lvbj0weDA1MDAyQzAwClsgIDU4NS44ODA3MzddIGFtZGdwdSAwMDAwOjA2OjAwLjA6IGFt
ZGdwdTogcmluZyBnZnhfMC4wLjAgdXNlcyBWTSBpbnYgZW5nIDAKb24gaHViIDAKWyAgNTg1Ljg4
MDc0Ml0gYW1kZ3B1IDAwMDA6MDY6MDAuMDogYW1kZ3B1OiByaW5nIGdmeF8wLjEuMCB1c2VzIFZN
IGludiBlbmcgMQpvbiBodWIgMApbICA1ODUuODgwNzQzXSBhbWRncHUgMDAwMDowNjowMC4wOiBh
bWRncHU6IHJpbmcgY29tcF8xLjAuMCB1c2VzIFZNIGludiBlbmcgNApvbiBodWIgMApbICA1ODUu
ODgwNzQ0XSBhbWRncHUgMDAwMDowNjowMC4wOiBhbWRncHU6IHJpbmcgY29tcF8xLjEuMCB1c2Vz
IFZNIGludiBlbmcgNQpvbiBodWIgMApbICA1ODUuODgwNzQ1XSBhbWRncHUgMDAwMDowNjowMC4w
OiBhbWRncHU6IHJpbmcgY29tcF8xLjIuMCB1c2VzIFZNIGludiBlbmcgNgpvbiBodWIgMApbICA1
ODUuODgwNzQ2XSBhbWRncHUgMDAwMDowNjowMC4wOiBhbWRncHU6IHJpbmcgY29tcF8xLjMuMCB1
c2VzIFZNIGludiBlbmcgNwpvbiBodWIgMApbICA1ODUuODgwNzQ3XSBhbWRncHUgMDAwMDowNjow
MC4wOiBhbWRncHU6IHJpbmcgY29tcF8xLjAuMSB1c2VzIFZNIGludiBlbmcgOApvbiBodWIgMApb
ICA1ODUuODgwNzQ4XSBhbWRncHUgMDAwMDowNjowMC4wOiBhbWRncHU6IHJpbmcgY29tcF8xLjEu
MSB1c2VzIFZNIGludiBlbmcgOQpvbiBodWIgMApbICA1ODUuODgwNzQ5XSBhbWRncHUgMDAwMDow
NjowMC4wOiBhbWRncHU6IHJpbmcgY29tcF8xLjIuMSB1c2VzIFZNIGludiBlbmcgMTAKb24gaHVi
IDAKWyAgNTg1Ljg4MDc1MV0gYW1kZ3B1IDAwMDA6MDY6MDAuMDogYW1kZ3B1OiByaW5nIGNvbXBf
MS4zLjEgdXNlcyBWTSBpbnYgZW5nIDExCm9uIGh1YiAwClsgIDU4NS44ODA3NTJdIGFtZGdwdSAw
MDAwOjA2OjAwLjA6IGFtZGdwdTogcmluZyBraXFfMC4yLjEuMCB1c2VzIFZNIGludiBlbmcKMTIg
b24gaHViIDAKWyAgNTg1Ljg4MDc1M10gYW1kZ3B1IDAwMDA6MDY6MDAuMDogYW1kZ3B1OiByaW5n
IHNkbWEwIHVzZXMgVk0gaW52IGVuZyAxMyBvbgpodWIgMApbICA1ODUuODgwNzU0XSBhbWRncHUg
MDAwMDowNjowMC4wOiBhbWRncHU6IHJpbmcgdmNuX2RlY18wIHVzZXMgVk0gaW52IGVuZyAwCm9u
IGh1YiA4ClsgIDU4NS44ODA3NTVdIGFtZGdwdSAwMDAwOjA2OjAwLjA6IGFtZGdwdTogcmluZyB2
Y25fZW5jXzAuMCB1c2VzIFZNIGludiBlbmcgMQpvbiBodWIgOApbICA1ODUuODgwNzU2XSBhbWRn
cHUgMDAwMDowNjowMC4wOiBhbWRncHU6IHJpbmcgdmNuX2VuY18wLjEgdXNlcyBWTSBpbnYgZW5n
IDQKb24gaHViIDgKWyAgNTg1Ljg4MDc1N10gYW1kZ3B1IDAwMDA6MDY6MDAuMDogYW1kZ3B1OiBy
aW5nIGpwZWdfZGVjIHVzZXMgVk0gaW52IGVuZyA1IG9uCmh1YiA4ClsgIDU4NS44ODQzNDVdIGFt
ZGdwdSAwMDAwOjA2OjAwLjA6IGFtZGdwdTogR1BVIHJlc2V0KDEpIHN1Y2NlZWRlZCEKWyAgNTg1
Ljg4NDM3MV0gYW1kZ3B1IDAwMDA6MDY6MDAuMDogW2RybV0gZGV2aWNlIHdlZGdlZCwgYnV0IHJl
Y292ZXJlZCB0aHJvdWdoCnJlc2V0ClsgIDU4NS44OTczMDBdIGFtZGdwdSAwMDAwOjA2OjAwLjA6
IGFtZGdwdTogW2RybV0gKkVSUk9SKiBGYWlsZWQgdG8gaW5pdGlhbGl6ZQpwYXJzZXIgLTEyNSEK
CkknbSBvbiBhbiBBU1VTIGxhcHRvcCB3aXRoIFJ5emVuIDc5NDBIWC9SYWRlb24gNjEwTS4gSSdt
IHVzaW5nIGEgZGlzdHJpYnV0aW9uCmtlcm5lbCwgYnV0IHRoZSBtYWludGFpbmVycyBhcmUgc2xv
dyB0byByZXNwb25kLCBzbyBmb3JnaXZlIG1lIGZvciBzZW5kaW5nCm1lc3NhZ2VzIGhlcmUuIEkg
dXNlIGEgY3VzdG9tIGtlcm5lbCBjb21tYW5kIGxpbmUgYW1kZ3B1LmRjZGVidWdtYXNrPTB4MTAg
dG8Kd29yayBhcm91bmQga2VybmVsIGxvY2t1cCBwcm9ibGVtcywgd2hpY2ggaXMgYSBzZXBhcmF0
ZSBwcm9ibGVtIHRoYXQncyBiZWVuCmFyb3VuZCBzaW5jZSB+Ni4xMi4KCkkndmUgY29sbGVjdGVk
IG1vcmUgZG1lc2cgbG9ncyBvdGhlciB0aGFuIHdoYXQncyBzaG93biBhYm92ZSwgYXMgd2VsbCBh
cwpkZXZpY2UgY29yZWR1bXBzIGZyb20gL3N5cy9jbGFzcy9kcm0vY2FyZC9kZXZpY2UvZGV2Y29y
ZWR1bXAvZGF0YS4gSSdtIGFsc28KaGFwcHkgdG8gaGVscCB3aXRoIGJpc2VjdGluZyB0aGUgcHJv
YmxlbSBpZiBpdCdzIG5vdCB0b28gbGFyZ2UuIExldCBtZSBrbm93CmhvdyBJIGNvdWxkIGhlbHAu
CgpCZXN0IHJlZ2FyZHMsCll1bmNoZW4K
