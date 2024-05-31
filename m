Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6920AC25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 02:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768E114A2E1;
	Fri, 31 May 2024 02:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WV3kc4Xg";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C39714A2D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 02:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EydxRFygMkIc4FBdlWKRifM+fmTBTZn9/KzNiHA57lyllBZM2mqvF9Q6rHJVETyDXB0KL5q74AAii7eMnsJu/tAvBOp2iAU52sJAvmDvMU9T420HcERWCgWWXyz8BjuCNcCB4XmPBcDujXfG6+RJJ+61199PcQYbBirVzxWZVChE3XzyP1K3Y2qnCmEAKOuZoqFO7nQSQuDBIG7dPGFtDCRXSZaWnM7paLnmtOor6JExyxG6LCQKacl+Cz9iUMy5YHaJEsLw4WALRf1S1eGxPg0QylOH3Vtxlq/jCb5FJZ9w9yYUCIMzMD0uvwMkyaV5CsSUh6LDRc9MzAuy1fAzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VdS9izasYCJwJePNwHCpNJznfSzg/c30e/E3h3qy3s=;
 b=m6p8cJoAbrN11FROEp6lH58krU3fEFyL+jUzLwiZuK3pvMQz2GDfkzh3IlfXgsLzWorkXoR0/ENHMwwpLTZ8U/oK6NqRfCwB79XSz2q5KqNekdK4W7ne5J2PEAALlgu2EFD97r+/txLyKbnNcFt0r3VlPowGdQpdrtCkhV38OBAH/oMGd5YH7NfS/OHsWExXcrwrzYA1/IfUEg8PXQSju/rjOFPWVAF1KE92AW/Q0rZlKNvBBNlwYPildC+K/7DNkXyPFl9H9Ag3yqxA/E9U7Wpz+No5kEhyrWMrEVb6a2q8gIY2aDpF02cYpBrs0I1cVxLbQQRN5tIyvl16pwnh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VdS9izasYCJwJePNwHCpNJznfSzg/c30e/E3h3qy3s=;
 b=WV3kc4XgCz+e+27q5lWi3IBT4wC9rjCkyMamFFeaqHhR/B6oBpQ/uh1edxbw6ajP+nmzBm3S0suqomrIXsR+PvIL8nKmcLb3ItQAna9BFyFVntGHk8zwezIyx0vdxL/TDwBdtVurF4EsC97eeZCDmqgjLN84uOL7BlBRWAf6SN8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 02:41:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 02:41:43 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 5/8] drm/amdkfd: fix the return for the function
 kfd_dbg_trap_set_flags
Thread-Topic: [PATCH 5/8] drm/amdkfd: fix the return for the function
 kfd_dbg_trap_set_flags
Thread-Index: AQHaskRP9/q74ca65kuQ30nL4yEXn7GwPoiAgABkxWA=
Date: Fri, 31 May 2024 02:41:43 +0000
Message-ID: <BL1PR12MB5144EE5E19FA2B38244AF96BE3FC2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240530034848.2341406-1-jesse.zhang@amd.com>
 <aaba2dbb-ca5e-41c7-bc60-7f65cce6b775@amd.com>
In-Reply-To: <aaba2dbb-ca5e-41c7-bc60-7f65cce6b775@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=590abaa1-da2d-4c77-afc4-3f462c8b936d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T02:40:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB7820:EE_
x-ms-office365-filtering-correlation-id: 26cb4275-44af-4e54-af3f-08dc811b3505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UkdxZk9nUnBBMUtweW5qaTgvdm5nOVNBbUNkdFJqZGkveDV5MlJGK2NMaG9I?=
 =?utf-8?B?RUd4VDROSjY0WlN5UWxobHM1SWpHRmMzbUVFQ2NKblQ5KzJ1V0ZtaHdmQktZ?=
 =?utf-8?B?TXJXZG5OWURkekZIRXJJbFFreEJVZFBlMGhvSWRoSEZCcExqb1ZIdUVGMHFv?=
 =?utf-8?B?RUVYYnRqOXpjTTlOUVJYMHZHcFErbHNTdHJ4WlRlRG1vZ3h4WUlwRkYwODl6?=
 =?utf-8?B?WGtqc0lUTFllbWlKdU5hU2t6SnBFTEJZWnN4b2M5VlYyNVRGUlczTHdwMnBJ?=
 =?utf-8?B?NFVYaEVETWozZkxSb0t5elc0c3VLWHdQbTdwM3BzbUpYWjh0Q0dtSVp6NkVH?=
 =?utf-8?B?ekhBMCthRkZDRURORWJoRE9rWUJaMkh4K0Vzb210REV3NWM4RDQvQXBDYjR1?=
 =?utf-8?B?bVhzNXZaaEJtK3lNZnN0cmtPdXVhN0dVaytqSk1sdkFWOGFZTTZ3dzFRWUZv?=
 =?utf-8?B?WHh3cDF5SU95eHM1V1NyVFZ2NTFDMlQrYXJQUUNlZGFLcDA0ODZxK2I3UE5u?=
 =?utf-8?B?cGY2Ty9sUGVNRTRJYWYzSVFVVHI1NWEzY29BVzFidkVVcHhvRFdDRXlHMHUy?=
 =?utf-8?B?R0h5dHl3azBabEJRYjRJKy9FdjRsdXNMR1NJZk0zaHM3VUhndlBUeTk1ZGJh?=
 =?utf-8?B?V2NER00xOTRicmxQbFBlcXdjMmxNbkc2dE45NUpSNTk3Y21tZGF0ZDMzeUs3?=
 =?utf-8?B?ampCK1dKaGZxQlQvRkdKdm5VY3oyZk1mQlFJTGZsYXNPTkEwZVI1Z0dHOWk1?=
 =?utf-8?B?WVBDekV5YTNJMHZwWmpuV2RRdmY1UjdiNzAxa2h6TWNBUkJlZ0xlSDhwSTQr?=
 =?utf-8?B?d0pXNFJvRGV4bC92T21lQ05hNGhGaTQwdThyQ08xTlVycFErcVNVUHh3azlZ?=
 =?utf-8?B?V0NhUDE5eTJsZnA1TmRBc0U5MVY0bTZWYlo4YUh6ZEc3RHlaeE1HZUI0cklt?=
 =?utf-8?B?ZlE5MFROQkRVREc5ZGFXa1ZmWmI2K0xkaUVZZ3MxWDFaSEhJakpKTU8rQnR6?=
 =?utf-8?B?OHBabTBxamt6S0ZIKzJnZzFZdmVraHQwY01kalJwR0YweWhXYjBKNk0rR0dm?=
 =?utf-8?B?dTlnS1k1SEJWcGdxakZRRmZBbHJVYkxtQ3I1bXVydjFoRnJBSERHRUdaaG9r?=
 =?utf-8?B?Y250SWIvYXVMSWV4NWc1TS9BUUh5Y3BxT0c3YzMxQk56dHFaUzhpV2lUa3ht?=
 =?utf-8?B?aktEUjA0cHAyai9EVkpHc1dzaUVEcFU0Z0RXQXpwZ0s4Vm02U2NDbEE4b3h2?=
 =?utf-8?B?eW5DUEltVERvVHFMY2hJRlJ3Wm1iQklNOVNDbHZMU1VMQ2xSOE1VR1l1Qy9M?=
 =?utf-8?B?M2R6UU9WcjBINU5YS2l5VnlDWVVsb2hvaEJNTW5SNnRJNTFndldDSHZQbVgv?=
 =?utf-8?B?ZGRwVnBZQU82eVZ0N1BET3FNRHZydUhyemkzZ3UxalZTZGxSazl3R2UxY2VV?=
 =?utf-8?B?RnFWaCsvN01OYk9DZ1hNV3c0dUpOR0FaY2t4OHlKbDZzRXpQakJSMDhPdnV1?=
 =?utf-8?B?dUJURy80UGgxMjlOMzB6WUx4dUNqL3JjT25jV0VKTitiMzVrWXg4MC9NZzQ1?=
 =?utf-8?B?dmpEUU85czQya242cnFLRzZxZmVuM2pVUkJuRzljY3pKaGJydk9rcTBhelRV?=
 =?utf-8?B?MUllaC9iZVM4VTByU21GUFl6UFkvWDY1NnVwU2xDUm1WY2NJaEY0RzB3RjNs?=
 =?utf-8?B?QkE0L2kzYlNvNFZPam8yc2FiaCtrUWd3dmtBZkVzNnJxNS93Mit2Ri9VRXo5?=
 =?utf-8?B?ODdObC8vRVJ2eERBNGRwWG44RUtkZ0pSWXdmVHNUN3Y1VXVDSnBjSjVCOTdZ?=
 =?utf-8?B?U0N5Sm1sOVN2blEzcHJydz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0kwS3VFMGVBVXVsVlhLWkgrdWorSkJMRm9WOVp4VHJSWHZPNU5OaVBVMUZK?=
 =?utf-8?B?Q0pOempXWEFCU2NrdDZFWW5BTVFWc3BkQUNIVUZWNWZoOUdWSnFlMXA4bHdH?=
 =?utf-8?B?UVVrYjhiRGh3S3VGaHFxK3k5Y2pvcjRCQnJtQUFETzBaM2FjTENiMkhNRDV4?=
 =?utf-8?B?UTZlQzJyOW52c1MrUGZwRldyYWt2RWxEYm1IZ2JPTWErd0U2WTQzbzhuY0Vl?=
 =?utf-8?B?bGsvc1NpT2xCV0ZvV3ZuNlJEL2h6N0p3UTZBRXJpNEVGMThjdWdGQlhFZWRD?=
 =?utf-8?B?aG1YZ2JRdzkzd3l0U1RIRmc5UzJiY0UxczM4L2NJcWZhV01rTldsWkNBTXcr?=
 =?utf-8?B?SVVmY1c5UThNaVU1RGFsV1hnVC9Yd3V4eGREYlBmMHRuWTVlVm5zYVBTYkVU?=
 =?utf-8?B?QW1PNHlRb09ueUxZVWpnelV3a1ZtRTNHWndycm15aEt0QnNOdGFGbHFoMk9G?=
 =?utf-8?B?SzNpODIrOHAzNEh3Q0RWcTBwcUFOa0dNaUg0UGFYa0JNcFpBTlhxRWZMVkRP?=
 =?utf-8?B?YUJhWndib3NHcVIxTEhQMDRrWVptck1yclhiOVRsbUtsa1ZzTWVnNHBITDh2?=
 =?utf-8?B?dUQ1UXM3REhlSnFJRElWaTAzMjhlcjB4TmU4b2hhTlZCYTNDVyt6c2pCNmZR?=
 =?utf-8?B?RHBhSERNQmZPL1A5SmlOK1BEVTBId0J5RndlNHRtSXJzQkhPRVhrYTJOTnZM?=
 =?utf-8?B?TmJNb0lWWDlVZnlvMjdDQ1JyTHNmRmFNMDlNU3dZbkV1Qnk1YTdQdDNTNjRQ?=
 =?utf-8?B?MkxiMldyN21FVjM3U0I2am1sMGpjRUpqWWhHc2lYb1NvcXpUb2tGdjJZakpQ?=
 =?utf-8?B?NzBrU254VWVjVzMxUktQWkRUSzFHczJ0bE80Y3BQdnF6bkxyZ3Y4OC9KeitW?=
 =?utf-8?B?eFZlRUs2cmFGb1FZWVd6UVpRUjR1WXN6S2VLNk9URDNGbE9RTUtRcWVaVlBt?=
 =?utf-8?B?Tk40b0Rjdk9Xb0hDYXlNNkVwY0FOSzQ2N1BEYVUweGhEQmdxejdueG9JQzJV?=
 =?utf-8?B?ZVg2N0RNS0tjcVQzRTVTTm9jQ1JnVnVTa0Jmb0RTOEtKa0IwK1ByMmp6SzlP?=
 =?utf-8?B?OWtUU25kd29QcDV5SlRCbFJpMlFmci9Vc0tLOWhrY1Zvc25nc0YyTTRRcnZS?=
 =?utf-8?B?UFRyTlFnRWRldkRlZ2Q4S01Nbk9TVzhvWGdobC9lUEFNNi9xWnRjN0tqeVdR?=
 =?utf-8?B?dVZESXR1QXJIZ1hFRWZPU2VJME41M2VUMUovWnVJQVhobE5uL2s1MlhJdHBu?=
 =?utf-8?B?VmxNVDJDeU9JNDhJT251MjZBTWtjWTNyVVBlS2lpUFhmZVI2d1ZlY3RDaStC?=
 =?utf-8?B?d21KN0dnRXJkdmJDTU5Ia0l0eG1SN0lEOGVFSGg2N0xpUGpPUEsxQlJRYSta?=
 =?utf-8?B?bXVoWW1CRGpwOXh1VTVKaEx4cnhMZFN6TXNRTjBKejVUb1JYK004VzFpODJw?=
 =?utf-8?B?a0xzSGIwV1RSK25wK2lwakdlNG5meVJjVC9LNit6VnVodUd0VVF2THVvRGhm?=
 =?utf-8?B?U2w2UHNHM1ozWVltWVVmUnlvWWJzcU13RkdPRlc3RHZFS2kwVjBQYmR5b0Iw?=
 =?utf-8?B?VHVtQnpUMkF3SlJELytZaVVHb1ZqVEF1V2xnVTdka3hnREh2enVNY3RqSUFF?=
 =?utf-8?B?c3RmZmpoTGNZR0xOUmNxRkpGUHJTREYrQU1aOTk3YUVFdVZkNEh3S1VIWHhI?=
 =?utf-8?B?aFlIaG5wbERHRjJVYXg4K21FZCsyY2tiZGwvMll5MHdFSzZKU053cHdXdmFI?=
 =?utf-8?B?RXFjQ2JiN2g3a093T0ZzNXBxQ3ljUFFZSlU2emZnYjFZYXp1aWtaUTV3ZWJo?=
 =?utf-8?B?RzJwdTVySHN6a2s2U0ZzZGZYQUJTMGR2bkxEZGFEMmhUQkNtdGVrbkpoTEhJ?=
 =?utf-8?B?THc2TlBkV2UxRzgxaE5DdzVUZXVPQVlBTmoySmhZYzZOa091Z1B3dGo2VVVq?=
 =?utf-8?B?S056K2oxQzJYY0pzR0kxZmwvWE5QczlLNEFGK0Q1L2YwUTJDcHN3SHhkWkxJ?=
 =?utf-8?B?ZUpYUFNiOHVYWXl2NTNrQUtsdGhrRk0venFBbDdFY2RaVi9jVi9EU0VTRFdR?=
 =?utf-8?B?ajVmZjN1WGxzNk40aDNIeHlJa1BhdDMzV3JWT2VvVTdaZFRhZXhvTHIzTHpR?=
 =?utf-8?Q?kdCE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cb4275-44af-4e54-af3f-08dc811b3505
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 02:41:43.2869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbQORKj11V8dk5p1pLdLkdbs+GtiDqQo1Y5Ssu30M+DNvDYaU8JSqgMXTDSpuEOiuN2qoNNtNNSbifc/enxRWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
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
Cg0KSGkgRmVsaXgsDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBhbmQgd2lsbCBkcm9wIHRoZSBw
YXRjaC4NCg0KVGhhbmtzDQpKZXNzZQ0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClNlbnQ6IEZyaWRheSwg
TWF5IDMxLCAyMDI0IDQ6NDAgQU0NClRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQu
Y29tPjsgSHVhbmcsIFRpbSA8VGltLkh1YW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
IDUvOF0gZHJtL2FtZGtmZDogZml4IHRoZSByZXR1cm4gZm9yIHRoZSBmdW5jdGlvbiBrZmRfZGJn
X3RyYXBfc2V0X2ZsYWdzDQoNCg0KT24gMjAyNC0wNS0yOSAyMzo0OCwgSmVzc2UgWmhhbmcgd3Jv
dGU6DQo+IElmIHRoZSByZXdpbmQgZmxhZyBpcyBzZXQsIGl0IHNob3VsZCByZXR1cm4gdGhlIGZp
bmFsIHJlc3VsdCBvZg0KPiBzZXR0aW5nIG1lcyBkZWJ1ZyBtb2RlIG9yIHJlZnJlc2ggdGhlIHJ1
biBsaXN0Lg0KDQpOby4gV2UncmUgcmV3aW5kaW5nIGJlY2F1c2UgYW4gZXJyb3Igb2NjdXJyZWQu
IFdlIHdhbnQgdG8gcmV0dXJuIHRoYXQgZXJyb3IsIG5vdCB0aGUgc3VjY2VzcyBwcm9iYWJseSBy
ZXR1cm5lZCBieSByZWZyZXNoaW5nIHRoZSBydW5saXN0Lg0KDQpSZWdhcmRzLA0KICAgRmVsaXgN
Cg0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29t
Pg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVidWcuYyB8IDQg
KystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVidWcu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZWJ1Zy5jDQo+IGluZGV4IDRh
YmQyNzUwNTZkNi4uZDEyZTVmMjk5MTlhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGVidWcuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfZGVidWcuYw0KPiBAQCAtNTQ4LDkgKzU0OCw5IEBAIGludCBrZmRfZGJnX3RyYXBfc2V0
X2ZsYWdzKHN0cnVjdCBrZmRfcHJvY2VzcyAqdGFyZ2V0LCB1aW50MzJfdCAqZmxhZ3MpDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCFwZGQtPmRldi0+a2ZkLT5zaGFyZWRfcmVzb3VyY2VzLmVuYWJsZV9tZXMp
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlYnVnX3JlZnJlc2hfcnVubGlzdChw
ZGQtPmRldi0+ZHFtKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgciA9IGRlYnVn
X3JlZnJlc2hfcnVubGlzdChwZGQtPmRldi0+ZHFtKTsNCj4gICAgICAgICAgICAgICAgICAgICAg
IGVsc2UNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAga2ZkX2RiZ19zZXRfbWVzX2Rl
YnVnX21vZGUocGRkLCB0cnVlKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgciA9
IGtmZF9kYmdfc2V0X21lc19kZWJ1Z19tb2RlKHBkZCwgdHJ1ZSk7DQo+ICAgICAgICAgICAgICAg
fQ0KPiAgICAgICB9DQo+DQo=
