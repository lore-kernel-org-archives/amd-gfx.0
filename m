Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9D7C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 09:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AEF10E22B;
	Tue, 29 Apr 2025 09:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u86K9A2j";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A93A10E22B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 09:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwRQHx7pXkcltv34ZKIHOg2FGOQKX6/wL5SKXI7sovK5JeHW7r/0ctP+slYp+s3ff/kPiy/ldHrMUUCJ0XLzH7hzv3VzZw5ZrnGPXbkjFJlGJVneuNriogU1ulHUThQ+efRX3HB0hV015VEjncCRr33z4OVLb0hWooi/ZrjQ0arDK0orJRLXwJa1KI27Kuk1qHSig5w2hOO5F3MJwiT8c+rmydzv3iMiJioCZ4DiLzkzzBg5zBlynjdkPAz0/OgcGHZC8x9HgnVzOL3MNAAmu24jqFpflt82nn5pANLh3dZ/G747CK8QX04pBl3hb7jPQoQ0Zw5O0ZVaj9+nOGPu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMZjeyT2rsloWdCerh1UDPHVXgxvf8MpbybcaSIqVHs=;
 b=hbCr4ASMx8oz5XuWPpYxhapDPRrJ6BPS3YxO9HCGorXjHns+n+CWxL3UJAY5zDXJuobJT/9HsKCzIXcvlfX1chrmyzerYj4PMOhhgO5PoJHtdJdmnUXhXqaZmp/1X4imcr8k/IfB53CWl+qSk7gb6pcXJ+FL+OW7inf5/74QzANbEJr59d7ekjtwr4sEMIS/w88ASHx2PucwtORTZxFgYBScPbc4npK45sAuffIC7Ebdm7mt8HaqP6XFl3MTcEwknDOitvDm5yuUY95EGjpYnGcKmAUboRkCEAHh8b9RG9dEXwMShH8phn12PMEIOMuwrOHjcbSC84vcLt3Stbj8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMZjeyT2rsloWdCerh1UDPHVXgxvf8MpbybcaSIqVHs=;
 b=u86K9A2jGGMnwT0JgGXU4eKPyndytdj96SBj5rPV7aEPADuSYXp1j/ljv+PKIF0H9yDCUSZyQCeiT0VCPz9t0pLcq4MLGeNtiIyCrb+1nSeXdk9v7PyGtB4Mu1zL1M0rN4BbzW3MUi8sQ05Sa9RVI1VW4pLtgYm/CNOfFX5uPvM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.30; Tue, 29 Apr 2025 09:12:35 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 09:12:35 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: validate the eviction fence attach/detach
Thread-Topic: [PATCH 3/3] drm/amdgpu: validate the eviction fence attach/detach
Thread-Index: AQHbtbDAK0+RbwMcVE+XP4ZvVxZ9F7O5YPmAgAD/YnA=
Date: Tue, 29 Apr 2025 09:12:35 +0000
Message-ID: <DS7PR12MB60053400E90B33F0CC727DFDFB802@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
 <20250425070730.4033803-3-Prike.Liang@amd.com>
 <79b1950d-436e-40bf-a9f1-1bc1974f42e0@amd.com>
In-Reply-To: <79b1950d-436e-40bf-a9f1-1bc1974f42e0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=79b77104-4bc1-4fe5-ac56-ff0473a99d92;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-29T09:05:55Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ0PR12MB5635:EE_
x-ms-office365-filtering-correlation-id: 13f13041-3fb5-4f77-8de1-08dd86fdfb08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UVdHR0RxWVNhWGNxQ2lhS05zR3MvSklRNXBxUE0yNkdFTDBXdmw2aU5sQ1VE?=
 =?utf-8?B?TnFZd1ZZMXltaklINlhxQi9RdTBFa2trVGFtTWthNXdGVzJzOHVaYk5wNGF3?=
 =?utf-8?B?SDVBVjA4NHV2Y28wT0ZQaCs2ZE1kdnJiQW4rSU8vbEVlMlF0NmdqQmxSY29r?=
 =?utf-8?B?V1J3eXVzVjVsMHFSUHhjeTc3MEhvek4xSGE4VmQ1eDN1eUdBOVYwZ3dmSmhm?=
 =?utf-8?B?bDJRTEdUb0JVblc2YkpSalg4VEl1b050OCtxTnY5Tjc4Y1hGY1l5YU9SLzRV?=
 =?utf-8?B?Y1lBWHlIZm53M1JzenI4UWgxSk1WSmp5aFRmT1d6K0lFOGRsRTk5K1VKUllZ?=
 =?utf-8?B?MTJNZlBTMDhRU2t6QnRHUWlwTmtxWVhlZk85eFBXbnZzanRBYXhyOFdZYjVI?=
 =?utf-8?B?YVc2MTlrbHNxOGNMNHlPQ0V1VVZPc0pseWJTcXMzeVE2RWMycXR2MUV6L3Nx?=
 =?utf-8?B?ZUozdnlSZDdRdElDNUdnVnkzVktvdkVXOGNDYm9OTHNRVDFlSGg1alVoQ0J1?=
 =?utf-8?B?WXB5V0tsdjc4bS9KSDloZktIK0J3QkRxTUxDVzBXTzltSlZwQlRQS0lEMXY1?=
 =?utf-8?B?L3M1T0lGYjBXNWloOXJYMFJob3dzcnlMZGUvL09scFplR2hYb3dseXJKd2Ft?=
 =?utf-8?B?ME1sTVFLVnNPaEJ4ckxwK2QvMDBqZ3lLWitKY1V5M3FGSWlDYURkeDN2ZEhI?=
 =?utf-8?B?akhvSFRRWDdtQlBwVWpqMkphUEJIUW5lTTAwZlA4RWpHUE1idVEwKzEzYlVG?=
 =?utf-8?B?MGh5T2JFQU45WTdCZkZMUTQ1ekxYaG93Y0V0WHJpQytpQWJSa2FGZVVNb2Rh?=
 =?utf-8?B?Ri9ZNWlpN0ZlaGtjVCtCdFVMMVpyU2tnSXRYaUI2MDVLZi9RK0dUa21EQXNK?=
 =?utf-8?B?K0RDdFVFRGZEei9CS2orZ3czeHRZUDhlV0hrZnJsbTI3M1FqelFyZ2Z2S2Ir?=
 =?utf-8?B?LzlSa0VPR3RabnpXcEFpb2tpendTaE9MNHIrRktmOXBlMmI4NFpJdFVGNGcz?=
 =?utf-8?B?M05CSjVTaW9MbXhmQnNNcGllK2xTY01mL2k3cFdqVm9VdzR1VVJDZll2S1VV?=
 =?utf-8?B?WTFvL1libWNidk5jU0hTUlZRZXcxUmZKdDFiUDBMdjg0WGUwMkhGbnRtUUNB?=
 =?utf-8?B?UU1VNGdYUU5zWDBGV3RaZS9obmowbFBzNklSVmVmUlJJa2FjL0MzanBoVW52?=
 =?utf-8?B?aUVpM0NYbk9IWFlFVmRnOGs5bTEwa1hwdzlVZHgrdjNXNzRPdk42SEE5MkpP?=
 =?utf-8?B?VGRVQTFyeXZmdjZtUGNnc2s1R1ZaM1BkRkwvOFZyTXhZQmFsNUR3b3AxY3Bk?=
 =?utf-8?B?Sitla2JhU2drMFVKQWdtOU5FekZsMm5MN3E0VUVWekJ1OEVuN2RVTWp0NS82?=
 =?utf-8?B?QnAwQVRrRU0wMHEvWTFTOTAvVnNlcWtyc3QxY2wxZ3JKeDFqdHIrVVl1YjNa?=
 =?utf-8?B?RmM5aGc3cEErR2xSa25iejkwb2xtblhVTmRlK2h4c0J0cisvTEcwanFRZnE5?=
 =?utf-8?B?WWFFMG41by9aWTlreTNWSTJpK3Nqc0hUMlNZbGk0SW1nbmpyT1FaQTlTWm1s?=
 =?utf-8?B?Z01CNzZtSzZ6R1p4TTBJTVFuVkxmWjdaTmRsaGlOMkFXMnptbmlONDBaQWZi?=
 =?utf-8?B?SndZY1RkUm9FQ3dTZU1oQ3JFNEMzcVlmWGdqQXRsUkt1RTZ4S3p2dnBTcGxT?=
 =?utf-8?B?N1oxNGtGZnZVblYyZGx0WFFPT3ZCMktJOTlPeXJxSFJaNXhvc2t0Y0kzVG5h?=
 =?utf-8?B?a3dNS0hzVjBndXdNcTF1aXpRWVNTeUxsTUpJb1M2ZUh3RGVLSTRLeWtXT3Vt?=
 =?utf-8?B?TDEzUGxkV1pRT1JVcndPeHAySmhFS0UvQzNsZE1tSm9OemJrS1hDQ21ySlVT?=
 =?utf-8?B?WlJRSkp3TzQ1cGJKRW5kbjdWN2NzaWRQcUdpWGJIUmRpRTZYNWt0cEVkQm81?=
 =?utf-8?B?Y2phLzUvbG1ZRS84L0ZYYVdmc2ZxVVVIRS9nMDBmYnZyajBhVitiaEVTZVFy?=
 =?utf-8?Q?09Dg89YzgeQ24FEfnCx6yYHMX8zCkA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnpsNUNyclpNUUlQY1dEMFhwYllqaFVBS3p0L0JlR0drZ2ZBYVlWazhFOU11?=
 =?utf-8?B?NTdIRTMyT2lpZGlSelViQVoxWWhWQU5INXBobGthaDdnTDBYbU1leEhlVXVp?=
 =?utf-8?B?aUIrdnRiRXFYTzFUZEFRSEZRMm1kRkZSSnRCdy90Z3dQTlVBRk0rZXJhYkJS?=
 =?utf-8?B?RmRWQUc1Z1RhQTFpbjVtR1IvOWs2c0lUU0NnaEp4ZkttS0Z3MUp2ajNRMGhn?=
 =?utf-8?B?eUVMZjJxMzBwNEhaVmxHa1N5d3hUZkRZYis0L3ZtVUxiRm56MERZZXVhY0c2?=
 =?utf-8?B?MFcwMXdTV2x3Vm1jblNEc0dQdmtWaUVQNnVPcjAveEFKeGpzekREL2RGMk5a?=
 =?utf-8?B?TXBkOEtYeXkzbExVZVRBay85V1dKYjFhM0cxcThibGovUUExdXByT3BMSVZR?=
 =?utf-8?B?NVdhVjNmSzNJNllaWHVNMkpjZm1mWlBOTVhTaXJ6U0NON1ZzbklXVnQ5RVJm?=
 =?utf-8?B?WjFqSit4TGwvdTIxRUErQmZsSzZpRFJQY1lyczJBT2R3TzhDeFJJSjJIV3pJ?=
 =?utf-8?B?NUIxWGJCRE5SaFU1Q2pESVhNVWVxdzhoWVgzcDRFdCttNWl1MEVvUWxEeEVv?=
 =?utf-8?B?Um5FNzk1b3B1QVVJUWdIWnlOZTBPa3lvbzl6cTNZQmRiM0hRR2RrSGd3WFNr?=
 =?utf-8?B?elJLa0JVRzU1dStEMWNsOTlQTVN2ZVhjQ1U5dEJhc1hZZUtEa1FSNTdSSlVZ?=
 =?utf-8?B?N3NXMEJGelZLOS80S0t0L3BGWkxCUXIwd0FpMDZ2ajVIeW1FMDZGcUdQTWtW?=
 =?utf-8?B?Tk1YN1VyUjRpa2NTaWZSSkdGRFI5SHhXQXBZWk9RV1FmVlR3WkdDYWJMbDFj?=
 =?utf-8?B?b00vR0JKdUZxajF3ekV2K3I4UkxqVnZEZnlhZmlETGpGa1RvbGxUYVRNVmsz?=
 =?utf-8?B?aFFSY1p4d1hUSUl3eDBLc0FIZWFINDc3Z3IzU0VDZkxuUE1wUWc3UzRXRFpO?=
 =?utf-8?B?cWo2d1N5OHJIZFgwdy9pcWY5QnhDQTBsMWEvV24ycGhRSFR4Tk4wcWJ6QUZU?=
 =?utf-8?B?UzgzSmNsQ09qZnpKMDJ1dTc3a2FUa29nR3d1dEpvRTJNdjFNSU5ZVjRmemJq?=
 =?utf-8?B?UmRQOUJnTUJCdVVQNEJZWGVHYmpaN0o0SzR4Zm5sQlFvUXRkRHJ1WDJ4MGFD?=
 =?utf-8?B?bm55OGtESWJVY0d0NWJWR2I3SkY1Y21SNE03M2xHY1NPQzVrZi9ETkRpR1gv?=
 =?utf-8?B?Z3lOc2NhM0VPdnRVcC9OODlESW1LSCtGbmlLdHBsRkxPdzI4WUU1WFNJOW1v?=
 =?utf-8?B?RksxR0ovKythMUsrN05KbWVlYXBvc01QS04waXVvVWZLeFNoSlJYUDRnRHFo?=
 =?utf-8?B?aU1jVVpwenJBSmJ6YmkzRDBmV3VSUGNGNll5S3VMc1VWVkNsYXNVR2xTR2dm?=
 =?utf-8?B?TkxtWFNjT3lrTnVyblhLMDZIZHFSMzZJT1FxcGJJZjV1Tkc3Z1RVOFZNb0x5?=
 =?utf-8?B?ZVowSHkybFFEcmIzQWZhWDFIOTJ6VnlGYVp1YlQ4cEpRN05ncmNXdjduZzlh?=
 =?utf-8?B?NCtrbEZla2lkZUh4UHpkUFM5RmdYZkRjUzRNbHpYayttMm9hSGI2Ui9WNjVl?=
 =?utf-8?B?WGU1dEY2aktyUGJuSUNqc084YUxya29ZSVRSdC83bUJ1eFNKQmYwZVVBVWgx?=
 =?utf-8?B?K2trMVM2VEUvL015a3Ewa3lRWnVabE52bVVLcU1mQ0ZTQ0VJalFrU0pKNE9B?=
 =?utf-8?B?SjN5UEgyN0lPU08vUnZBanJROXdEbjBNMGJYZ2xaS0ZTYXJoZ2JQWTZPQjFP?=
 =?utf-8?B?ZEwwUHFrTnNCNklrVDNtejc1dll2aVBsRUI2M012OEx6MGc3UTdUVWt0V25p?=
 =?utf-8?B?ZGFGem9yZTRIZ2hzUXAvRERyc01CeFZ5cWpwR1cvbWRsRG50cG1kd3QvelR2?=
 =?utf-8?B?YnRNUU5tVEZJMmVkajhEQUZhNEIvalVVemh2UHJnY3RVOWJmZkowSFdyRjlB?=
 =?utf-8?B?TDZqWUppVTN2dm9UMXZIME83UDNaZTdPQ2pIOHdaRkJKZkVmSm02K0t1OUha?=
 =?utf-8?B?TmthVXpTV0RNRUdVZmkveGk2WjZvUTJoa1lWNlZKSFRHSzl4aU1XRVFodmVq?=
 =?utf-8?B?VVFGY1pTUzdXWVh3elNnQ205TW9ZT1kyRGJpcGRTY2sxLzR0ZkttWFpGVG5X?=
 =?utf-8?Q?e/ZY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f13041-3fb5-4f77-8de1-08dd86fdfb08
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 09:12:35.2856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTyhHq6+Qz6r7VRL7xJ4PL0VBPWHxly1XPCcAf4DVFIXLEL0EODAeK4hmwdO3AUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyOSwgMjAyNSAxOjUyIEFNDQo+IFRvOiBM
aWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gZHJtL2FtZGdwdTogdmFsaWRhdGUgdGhl
IGV2aWN0aW9uIGZlbmNlIGF0dGFjaC9kZXRhY2gNCj4NCj4gT24gNC8yNS8yNSAwOTowNywgUHJp
a2UgTGlhbmcgd3JvdGU6DQo+ID4gQmVmb3JlIHRoZSB1c2VyIHF1ZXVlIEJPcyByZXN1bWUgd29y
a3F1ZXVlIGlzIHNjaGVkdWxlZDsgdGhlcmUncyBubw0KPiA+IHZhbGlkIGV2aWN0aW9uIGZlbmNl
IHRvIGF0dGFjaCB0aGUgZ2VtIG9iai4NCj4gPiBGb3IgdGhpcyBjYXNlLCBpdCBkb2Vzbid0IG5l
ZWQgdG8gYXR0YWNoL2RldGFjaCB0aGUgZXZpY3Rpb24gZmVuY2UuDQo+ID4gQWxzbywgaXQgbmVl
ZHMgdG8gdW5sb2NrIHRoZSBibyBmaXJzdCBiZWZvcmUgcmV0dXJuaW5nIGZyb20gdGhlDQo+ID4g
ZXZpY3Rpb24gZmVuY2UgYXR0YWNoZWQgZXJyb3IuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
cmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYyAgIHwgIDMgKysrDQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyAgICAgICAgICB8IDE2ICsrKysr
KysrKystLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiA+IGluZGV4IGQyMjcxYzEwNDk4ZC4uMzc1
ZjE1YjZmZDU4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gPiBAQCAtMjE2LDYgKzIxNiw5IEBAIHZvaWQg
YW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2RldGFjaChzdHJ1Y3QNCj4gPiBhbWRncHVfZXZpY3Rpb25f
ZmVuY2VfbWdyICpldmZfbWdyLCAgew0KPiA+ICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpzdHViID0g
ZG1hX2ZlbmNlX2dldF9zdHViKCk7DQo+ID4NCj4gPiArICAgaWYgKGRtYV9mZW5jZV9pc19zaWdu
YWxlZCgmZXZmX21nci0+ZXZfZmVuY2UtPmJhc2UpKQ0KPiA+ICsgICAgICAgICAgIHJldHVybjsN
Cj4gPiArDQo+DQo+IENsZWFyIE5BSywgdGhhdCBpcyByYWN5LiBZb3UgY2FuIG9ubHkgYWNjZXNz
IGV2Zl9tZ3ItPmV2X2ZlbmNlIHdoaWxlIGhvbGRpbmcgdGhlDQo+IHNwaW5sb2NrIHRvIG1ha2Ug
c3VyZSB0aGF0IGl0IGlzbid0IHJlcGxhY2VkLg0KPg0KPiA+ICAgICBkbWFfcmVzdl9yZXBsYWNl
X2ZlbmNlcyhiby0+dGJvLmJhc2UucmVzdiwgZXZmX21nci0+ZXZfZmVuY2VfY3R4LA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHViLCBETUFfUkVTVl9VU0FHRV9CT09LS0VFUCk7
DQo+ID4gICAgIGRtYV9mZW5jZV9wdXQoc3R1Yik7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+ID4gaW5kZXggYzFkOGNlZTc4OTRiLi4wNDI1NmRlNGJl
ZTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+
ID4gQEAgLTI5MiwxMSArMjkyLDE0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2dlbV9vYmplY3Rfb3Bl
bihzdHJ1Y3QNCj4gZHJtX2dlbV9vYmplY3QgKm9iaiwNCj4gPiAgICAgZWxzZQ0KPiA+ICAgICAg
ICAgICAgICsrYm9fdmEtPnJlZl9jb3VudDsNCj4gPg0KPiA+IC0gICAvKiBhdHRhY2ggZ2Z4IGV2
aWN0aW9uIGZlbmNlICovDQo+ID4gLSAgIHIgPSBhbWRncHVfZXZpY3Rpb25fZmVuY2VfYXR0YWNo
KCZmcHJpdi0+ZXZmX21nciwgYWJvKTsNCj4NCj4gVGhhdCBoZXJlIGlzIGJ1Z2d5LCBmcHJpdi0+
ZXZmX21nciBjYW4gb25seSBiZSBhY2Nlc3NlZCB3aGlsZSBob2xkaW5nIHRoZQ0KPiBzcGlubG9j
ay4NCj4NCj4gPiAtICAgaWYgKHIpIHsNCj4gPiAtICAgICAgICAgICBEUk1fREVCVUdfRFJJVkVS
KCJGYWlsZWQgdG8gYXR0YWNoIGV2aWN0aW9uIGZlbmNlIHRvIEJPXG4iKTsNCj4gPiAtICAgICAg
ICAgICByZXR1cm4gcjsNCj4gPiArICAgLyogYXR0YWNoIGdmeCB0aGUgdmFsaWRhdGVkIGV2aWN0
aW9uIGZlbmNlICovDQo+ID4gKyAgIGlmICghSVNfRVJSX09SX05VTEwoZnByaXYtPmV2Zl9tZ3Iu
ZXZfZmVuY2UpKSB7DQo+DQo+IFBsZWFzZSBkb24ndCB1c2UgRVJSX1BUUiBmdW5jdGlvbnMgb24g
bWVtYmVycy4NCj4NCj4gPiArICAgICAgICAgICByID0gYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2F0
dGFjaCgmZnByaXYtPmV2Zl9tZ3IsIGFibyk7DQo+ID4gKyAgICAgICAgICAgaWYgKHIpIHsNCj4g
PiArICAgICAgICAgICAgICAgICAgIERSTV9ERUJVR19EUklWRVIoIkZhaWxlZCB0byBhdHRhY2gg
ZXZpY3Rpb24gZmVuY2UgdG8NCj4gQk9cbiIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgYW1k
Z3B1X2JvX3VucmVzZXJ2ZShhYm8pOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7
DQo+ID4gKyAgICAgICAgICAgfQ0KPg0KPiBXZSBzaG91bGQgYWx3YXlzIGhhdmUgYSBzdHViIGZl
bmNlIGluIGZwcml2LT5ldmZfbWdyLmV2X2ZlbmNlLCBzbyB0aG9zZSBjaGVja3MNCj4gYXJlIHVu
bmVjZXNzYXJ5Lg0KSSBjaGVja2VkIHRoYXQgd2hlbiBlbmFibGluZyB0aGUga3EgYW5kIHVxIGF0
IHRoZSBzYW1lIHRpbWUsIGFuZCBiZWZvcmUgc2NoZWR1bGUgYW55IHVzZXIgcXVldWUgdGFzayB0
aGVuIHRoZSBldmljdGlvbiBmZW5jZSBpcyBOVUxMLg0KQmFzZWQgb24gdGhlIGN1cnJlbnQgZGVz
aWduLCB0aGUgZXZpY3Rpb24gZmVuY2Ugb25seSBiZSBjcmVhdGVkIGF0IHRoZSB1c2VyIHF1ZXVl
IEJPcyByZXN0b3JlZCB0aW1lLg0KDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gPiAg
ICAgfQ0KPiA+DQo+ID4gICAgIGFtZGdwdV9ib191bnJlc2VydmUoYWJvKTsNCj4gPiBAQCAtMzYy
LDcgKzM2NSw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdA0K
PiBkcm1fZ2VtX29iamVjdCAqb2JqLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRf
dW5sb2NrOw0KPiA+ICAgICB9DQo+ID4NCj4gPiAtICAgaWYgKCFhbWRncHVfdm1faXNfYm9fYWx3
YXlzX3ZhbGlkKHZtLCBibykpDQo+ID4gKyAgIGlmICghYW1kZ3B1X3ZtX2lzX2JvX2Fsd2F5c192
YWxpZCh2bSwgYm8pICYmDQo+ID4gKyAgICAgICAgICAgICAgICAgICAhSVNfRVJSX09SX05VTEwo
ZnByaXYtPmV2Zl9tZ3IuZXZfZmVuY2UpKQ0KPiA+ICAgICAgICAgICAgIGFtZGdwdV9ldmljdGlv
bl9mZW5jZV9kZXRhY2goJmZwcml2LT5ldmZfbWdyLCBibyk7DQo+ID4NCj4gPiAgICAgYm9fdmEg
PSBhbWRncHVfdm1fYm9fZmluZCh2bSwgYm8pOw0KDQo=
