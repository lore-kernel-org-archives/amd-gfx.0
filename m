From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 2/2] libdrm: clean up non list code path for vamgr
Date: Fri, 9 Feb 2018 14:01:57 +0800
Message-ID: <c6b30b81-8b6f-3b5a-5654-e8075939143e@amd.com>
References: <20180112054554.19585-1-david1.zhou@amd.com>
 <20180112054554.19585-2-david1.zhou@amd.com>
 <e3722edc-8ca4-4730-d649-2b5a959b92c1@daenzer.net>
 <4a2036e5-820f-d62a-a773-2da1f575e1bc@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------118DA42E23D59C0D375F3846"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4a2036e5-820f-d62a-a773-2da1f575e1bc-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hui.Deng-5C7GfCeVMHo@public.gmane.org

--------------118DA42E23D59C0D375F3846
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年02月08日 17:13, Chunming Zhou wrote:
>
>
> On 2018年02月08日 17:01, Michel Dänzer wrote:
>> Hi David,
>>
>>
>> this change completely broke radeonsi due to memory management errors
>> (see valgrind output for glxgears below), so I had to revert it.
> ok, I will look into what happens. Sorry for broken.
The patch lost a "goto out" in free_va when applying patch from hybrid 
to opensource.
The attached fixes that, I tested successfully in my local side.
  please review or test, if no problem, I will submit it again.

Thanks,
David Zhou

>
> Regards,
> David Zhou
>>
>>
>> ==4831== Memcheck, a memory error detector
>> ==4831== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
>> ==4831== Using Valgrind-3.13.0 and LibVEX; rerun with -h for 
>> copyright info
>> ==4831== Command: glxgears
>> ==4831==
>> ==4831== Invalid read of size 8
>> ==4831==    at 0xAE4E79B: list_add (util_double_list.h:56)
>> ==4831==    by 0xAE4E79B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:184)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==  Address 0x151eccb8 is 8 bytes inside a block of size 32 free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==
>> ==4831== Invalid read of size 8
>> ==4831==    at 0xAE4E7B0: list_add (util_double_list.h:57)
>> ==4831==    by 0xAE4E7B0: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:184)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==  Address 0x151eccb8 is 8 bytes inside a block of size 32 free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==
>> ==4831== Invalid write of size 8
>> ==4831==    at 0xAE4E7BB: list_add (util_double_list.h:58)
>> ==4831==    by 0xAE4E7BB: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:184)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==  Address 0x151eccb8 is 8 bytes inside a block of size 32 free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==
>> ==4831== Invalid read of size 8
>> ==4831==    at 0xAE4E730: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:149)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==  Address 0x150164b0 is 16 bytes inside a block of size 32 
>> free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0xA12EADF: pb_destroy (pb_buffer.h:232)
>> ==4831==    by 0xA12EADF: pb_reference (pb_buffer.h:242)
>> ==4831==    by 0xA12EADF: r600_texture_destroy (r600_texture.c:825)
>> ==4831==    by 0x9D8490E: pipe_resource_reference (u_inlines.h:144)
>> ==4831==    by 0x9D8490E: dri2_destroy_image (dri_helpers.c:317)
>> ==4831==    by 0x538A94D: dri3_free_render_buffer.isra.3 
>> (loader_dri3_helper.c:223)
>> ==4831==    by 0x538B347: loader_dri3_drawable_fini 
>> (loader_dri3_helper.c:238)
>> ==4831==    by 0x53861E4: dri3_destroy_drawable (dri3_glx.c:338)
>> ==4831==    by 0x537F739: driReleaseDrawables (dri_common.c:481)
>> ==4831==    by 0x53866C2: dri3_destroy_context (dri3_glx.c:166)
>> ==4831==    by 0x5358792: glXDestroyContext (glxcmds.c:471)
>> ==4831==
>> ==4831== Invalid read of size 8
>> ==4831==    at 0xAE4E73D: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:148)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==  Address 0x150164a8 is 8 bytes inside a block of size 32 free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0xA12EADF: pb_destroy (pb_buffer.h:232)
>> ==4831==    by 0xA12EADF: pb_reference (pb_buffer.h:242)
>> ==4831==    by 0xA12EADF: r600_texture_destroy (r600_texture.c:825)
>> ==4831==    by 0x9D8490E: pipe_resource_reference (u_inlines.h:144)
>> ==4831==    by 0x9D8490E: dri2_destroy_image (dri_helpers.c:317)
>> ==4831==    by 0x538A94D: dri3_free_render_buffer.isra.3 
>> (loader_dri3_helper.c:223)
>> ==4831==    by 0x538B347: loader_dri3_drawable_fini 
>> (loader_dri3_helper.c:238)
>> ==4831==    by 0x53861E4: dri3_destroy_drawable (dri3_glx.c:338)
>> ==4831==    by 0x537F739: driReleaseDrawables (dri_common.c:481)
>> ==4831==    by 0x53866C2: dri3_destroy_context (dri3_glx.c:166)
>> ==4831==    by 0x5358792: glXDestroyContext (glxcmds.c:471)
>> ==4831==
>> ==4831== Invalid write of size 8
>> ==4831==    at 0xAE4E983: list_del (util_double_list.h:80)
>> ==4831==    by 0xAE4E983: amdgpu_vamgr_deinit (amdgpu_vamgr.c:70)
>> ==4831==    by 0xAE4D883: amdgpu_device_free_internal 
>> (amdgpu_device.c:134)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_reference (amdgpu_device.c:164)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_deinitialize 
>> (amdgpu_device.c:307)
>> ==4831==    by 0xA0FFD9A: do_winsys_deinit (amdgpu_winsys.c:84)
>> ==4831==    by 0xA0FFD9A: amdgpu_winsys_destroy (amdgpu_winsys.c:101)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==    by 0x535BD4E: glx_display_free (glxext.c:244)
>> ==4831==    by 0x535BE8D: __glXCloseDisplay (glxext.c:299)
>> ==4831==  Address 0x150164a0 is 0 bytes inside a block of size 32 free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0xA12EADF: pb_destroy (pb_buffer.h:232)
>> ==4831==    by 0xA12EADF: pb_reference (pb_buffer.h:242)
>> ==4831==    by 0xA12EADF: r600_texture_destroy (r600_texture.c:825)
>> ==4831==    by 0x9D8490E: pipe_resource_reference (u_inlines.h:144)
>> ==4831==    by 0x9D8490E: dri2_destroy_image (dri_helpers.c:317)
>> ==4831==    by 0x538A94D: dri3_free_render_buffer.isra.3 
>> (loader_dri3_helper.c:223)
>> ==4831==    by 0x538B347: loader_dri3_drawable_fini 
>> (loader_dri3_helper.c:238)
>> ==4831==    by 0x53861E4: dri3_destroy_drawable (dri3_glx.c:338)
>> ==4831==    by 0x537F739: driReleaseDrawables (dri_common.c:481)
>> ==4831==    by 0x53866C2: dri3_destroy_context (dri3_glx.c:166)
>> ==4831==    by 0x5358792: glXDestroyContext (glxcmds.c:471)
>> ==4831==
>> ==4831== Invalid read of size 8
>> ==4831==    at 0xAE4E98B: amdgpu_vamgr_deinit (amdgpu_vamgr.c:69)
>> ==4831==    by 0xAE4D883: amdgpu_device_free_internal 
>> (amdgpu_device.c:134)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_reference (amdgpu_device.c:164)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_deinitialize 
>> (amdgpu_device.c:307)
>> ==4831==    by 0xA0FFD9A: do_winsys_deinit (amdgpu_winsys.c:84)
>> ==4831==    by 0xA0FFD9A: amdgpu_winsys_destroy (amdgpu_winsys.c:101)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==    by 0x535BD4E: glx_display_free (glxext.c:244)
>> ==4831==    by 0x535BE8D: __glXCloseDisplay (glxext.c:299)
>> ==4831==  Address 0x150164a8 is 8 bytes inside a block of size 32 free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0xA12EADF: pb_destroy (pb_buffer.h:232)
>> ==4831==    by 0xA12EADF: pb_reference (pb_buffer.h:242)
>> ==4831==    by 0xA12EADF: r600_texture_destroy (r600_texture.c:825)
>> ==4831==    by 0x9D8490E: pipe_resource_reference (u_inlines.h:144)
>> ==4831==    by 0x9D8490E: dri2_destroy_image (dri_helpers.c:317)
>> ==4831==    by 0x538A94D: dri3_free_render_buffer.isra.3 
>> (loader_dri3_helper.c:223)
>> ==4831==    by 0x538B347: loader_dri3_drawable_fini 
>> (loader_dri3_helper.c:238)
>> ==4831==    by 0x53861E4: dri3_destroy_drawable (dri3_glx.c:338)
>> ==4831==    by 0x537F739: driReleaseDrawables (dri_common.c:481)
>> ==4831==    by 0x53866C2: dri3_destroy_context (dri3_glx.c:166)
>> ==4831==    by 0x5358792: glXDestroyContext (glxcmds.c:471)
>> ==4831==
>> ==4831== Invalid read of size 8
>> ==4831==    at 0xAE4E978: list_del (util_double_list.h:79)
>> ==4831==    by 0xAE4E978: amdgpu_vamgr_deinit (amdgpu_vamgr.c:70)
>> ==4831==    by 0xAE4D883: amdgpu_device_free_internal 
>> (amdgpu_device.c:134)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_reference (amdgpu_device.c:164)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_deinitialize 
>> (amdgpu_device.c:307)
>> ==4831==    by 0xA0FFD9A: do_winsys_deinit (amdgpu_winsys.c:84)
>> ==4831==    by 0xA0FFD9A: amdgpu_winsys_destroy (amdgpu_winsys.c:101)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==    by 0x535BD4E: glx_display_free (glxext.c:244)
>> ==4831==    by 0x535BE8D: __glXCloseDisplay (glxext.c:299)
>> ==4831==  Address 0x150164a0 is 0 bytes inside a block of size 32 free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0xA12EADF: pb_destroy (pb_buffer.h:232)
>> ==4831==    by 0xA12EADF: pb_reference (pb_buffer.h:242)
>> ==4831==    by 0xA12EADF: r600_texture_destroy (r600_texture.c:825)
>> ==4831==    by 0x9D8490E: pipe_resource_reference (u_inlines.h:144)
>> ==4831==    by 0x9D8490E: dri2_destroy_image (dri_helpers.c:317)
>> ==4831==    by 0x538A94D: dri3_free_render_buffer.isra.3 
>> (loader_dri3_helper.c:223)
>> ==4831==    by 0x538B347: loader_dri3_drawable_fini 
>> (loader_dri3_helper.c:238)
>> ==4831==    by 0x53861E4: dri3_destroy_drawable (dri3_glx.c:338)
>> ==4831==    by 0x537F739: driReleaseDrawables (dri_common.c:481)
>> ==4831==    by 0x53866C2: dri3_destroy_context (dri3_glx.c:166)
>> ==4831==    by 0x5358792: glXDestroyContext (glxcmds.c:471)
>> ==4831==
>> ==4831== Invalid read of size 8
>> ==4831==    at 0xAE4E97F: list_del (util_double_list.h:80)
>> ==4831==    by 0xAE4E97F: amdgpu_vamgr_deinit (amdgpu_vamgr.c:70)
>> ==4831==    by 0xAE4D883: amdgpu_device_free_internal 
>> (amdgpu_device.c:134)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_reference (amdgpu_device.c:164)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_deinitialize 
>> (amdgpu_device.c:307)
>> ==4831==    by 0xA0FFD9A: do_winsys_deinit (amdgpu_winsys.c:84)
>> ==4831==    by 0xA0FFD9A: amdgpu_winsys_destroy (amdgpu_winsys.c:101)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==    by 0x535BD4E: glx_display_free (glxext.c:244)
>> ==4831==    by 0x535BE8D: __glXCloseDisplay (glxext.c:299)
>> ==4831==  Address 0x150164a8 is 8 bytes inside a block of size 32 free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0xA12EADF: pb_destroy (pb_buffer.h:232)
>> ==4831==    by 0xA12EADF: pb_reference (pb_buffer.h:242)
>> ==4831==    by 0xA12EADF: r600_texture_destroy (r600_texture.c:825)
>> ==4831==    by 0x9D8490E: pipe_resource_reference (u_inlines.h:144)
>> ==4831==    by 0x9D8490E: dri2_destroy_image (dri_helpers.c:317)
>> ==4831==    by 0x538A94D: dri3_free_render_buffer.isra.3 
>> (loader_dri3_helper.c:223)
>> ==4831==    by 0x538B347: loader_dri3_drawable_fini 
>> (loader_dri3_helper.c:238)
>> ==4831==    by 0x53861E4: dri3_destroy_drawable (dri3_glx.c:338)
>> ==4831==    by 0x537F739: driReleaseDrawables (dri_common.c:481)
>> ==4831==    by 0x53866C2: dri3_destroy_context (dri3_glx.c:166)
>> ==4831==    by 0x5358792: glXDestroyContext (glxcmds.c:471)
>> ==4831==
>> ==4831== Invalid free() / delete / delete[] / realloc()
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E98A: amdgpu_vamgr_deinit (amdgpu_vamgr.c:71)
>> ==4831==    by 0xAE4D883: amdgpu_device_free_internal 
>> (amdgpu_device.c:134)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_reference (amdgpu_device.c:164)
>> ==4831==    by 0xAE4DD9B: amdgpu_device_deinitialize 
>> (amdgpu_device.c:307)
>> ==4831==    by 0xA0FFD9A: do_winsys_deinit (amdgpu_winsys.c:84)
>> ==4831==    by 0xA0FFD9A: amdgpu_winsys_destroy (amdgpu_winsys.c:101)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==    by 0x535BCCE: FreeScreenConfigs.isra.3 (glxext.c:221)
>> ==4831==    by 0x535BD4E: glx_display_free (glxext.c:244)
>> ==4831==  Address 0x150164a0 is 0 bytes inside a block of size 32 free'd
>> ==4831==    at 0x4C2DDBB: free (vg_replace_malloc.c:530)
>> ==4831==    by 0xAE4E85B: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:165)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0x9DD5067: pb_cache_release_all_buffers (pb_cache.c:241)
>> ==4831==    by 0x9DD5260: pb_cache_deinit (pb_cache.c:313)
>> ==4831==    by 0xA0FFD82: amdgpu_winsys_destroy (amdgpu_winsys.c:99)
>> ==4831==    by 0xA051D76: si_destroy_screen (si_pipe.c:515)
>> ==4831==    by 0x9D85448: dri_destroy_screen_helper (dri_screen.c:454)
>> ==4831==    by 0x9D85475: dri_destroy_screen (dri_screen.c:464)
>> ==4831==    by 0x9D82076: driDestroyScreen (dri_util.c:231)
>> ==4831==    by 0x5386222: dri3_destroy_screen (dri3_glx.c:584)
>> ==4831==  Block was alloc'd at
>> ==4831==    at 0x4C2EBA5: calloc (vg_replace_malloc.c:711)
>> ==4831==    by 0xAE4E795: amdgpu_vamgr_free_va.part.0 
>> (amdgpu_vamgr.c:180)
>> ==4831==    by 0xAE4EB2C: amdgpu_vamgr_free_va (amdgpu_vamgr.c:141)
>> ==4831==    by 0xAE4EB2C: amdgpu_va_range_free (amdgpu_vamgr.c:246)
>> ==4831==    by 0xA0FA53E: amdgpu_bo_destroy (amdgpu_bo.c:178)
>> ==4831==    by 0xA12EADF: pb_destroy (pb_buffer.h:232)
>> ==4831==    by 0xA12EADF: pb_reference (pb_buffer.h:242)
>> ==4831==    by 0xA12EADF: r600_texture_destroy (r600_texture.c:825)
>> ==4831==    by 0x9D8490E: pipe_resource_reference (u_inlines.h:144)
>> ==4831==    by 0x9D8490E: dri2_destroy_image (dri_helpers.c:317)
>> ==4831==    by 0x538A94D: dri3_free_render_buffer.isra.3 
>> (loader_dri3_helper.c:223)
>> ==4831==    by 0x538B347: loader_dri3_drawable_fini 
>> (loader_dri3_helper.c:238)
>> ==4831==    by 0x53861E4: dri3_destroy_drawable (dri3_glx.c:338)
>> ==4831==    by 0x537F739: driReleaseDrawables (dri_common.c:481)
>> ==4831==    by 0x53866C2: dri3_destroy_context (dri3_glx.c:166)
>> ==4831==    by 0x5358792: glXDestroyContext (glxcmds.c:471)
>> ==4831==
>> ==4831==
>> ==4831== HEAP SUMMARY:
>> ==4831==     in use at exit: 156,580 bytes in 1,724 blocks
>> ==4831==   total heap usage: 66,624 allocs, 64,901 frees, 32,392,118 
>> bytes allocated
>> ==4831==
>> ==4831== LEAK SUMMARY:
>> ==4831==    definitely lost: 96 bytes in 3 blocks
>> ==4831==    indirectly lost: 0 bytes in 0 blocks
>> ==4831==      possibly lost: 0 bytes in 0 blocks
>> ==4831==    still reachable: 156,484 bytes in 1,721 blocks
>> ==4831==         suppressed: 0 bytes in 0 blocks
>> ==4831== Rerun with --leak-check=full to see details of leaked memory
>> ==4831==
>> ==4831== For counts of detected and suppressed errors, rerun with: -v
>> ==4831== ERROR SUMMARY: 19 errors from 10 contexts (suppressed: 0 
>> from 0)
>>
>>
>>
>


--------------118DA42E23D59C0D375F3846
Content-Type: text/x-patch;
	name="0001-amdgpu-clean-up-non-list-code-path-for-vamgr.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-amdgpu-clean-up-non-list-code-path-for-vamgr.patch"

>From 27a2e5af2c7fa4a050288d5f926adad9511afde3 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 8 Feb 2018 14:52:11 +0800
Subject: [PATCH libdrm] amdgpu: clean up non list code path for vamgr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 amdgpu/amdgpu_internal.h |   2 -
 amdgpu/amdgpu_vamgr.c    | 122 +++++++++++++++++------------------------------
 2 files changed, 44 insertions(+), 80 deletions(-)

diff --git a/amdgpu/amdgpu_internal.h b/amdgpu/amdgpu_internal.h
index 3e044f1..75276a9 100644
--- a/amdgpu/amdgpu_internal.h
+++ b/amdgpu/amdgpu_internal.h
@@ -53,8 +53,6 @@ struct amdgpu_bo_va_hole {
 };
 
 struct amdgpu_bo_va_mgr {
-	/* the start virtual address */
-	uint64_t va_offset;
 	uint64_t va_max;
 	struct list_head va_holes;
 	pthread_mutex_t bo_va_mutex;
diff --git a/amdgpu/amdgpu_vamgr.c b/amdgpu/amdgpu_vamgr.c
index a2852b5..722067f 100644
--- a/amdgpu/amdgpu_vamgr.c
+++ b/amdgpu/amdgpu_vamgr.c
@@ -48,12 +48,19 @@ int amdgpu_va_range_query(amdgpu_device_handle dev,
 drm_private void amdgpu_vamgr_init(struct amdgpu_bo_va_mgr *mgr, uint64_t start,
 				   uint64_t max, uint64_t alignment)
 {
-	mgr->va_offset = start;
+	struct amdgpu_bo_va_hole *n;
+
 	mgr->va_max = max;
 	mgr->va_alignment = alignment;
 
 	list_inithead(&mgr->va_holes);
 	pthread_mutex_init(&mgr->bo_va_mutex, NULL);
+	pthread_mutex_lock(&mgr->bo_va_mutex);
+	n = calloc(1, sizeof(struct amdgpu_bo_va_hole));
+	n->size = mgr->va_max;
+	n->offset = start;
+	list_add(&n->list, &mgr->va_holes);
+	pthread_mutex_unlock(&mgr->bo_va_mutex);
 }
 
 drm_private void amdgpu_vamgr_deinit(struct amdgpu_bo_va_mgr *mgr)
@@ -122,41 +129,14 @@ amdgpu_vamgr_find_va(struct amdgpu_bo_va_mgr *mgr, uint64_t size,
 		}
 	}
 
-	if (base_required) {
-		if (base_required < mgr->va_offset) {
-			pthread_mutex_unlock(&mgr->bo_va_mutex);
-			return AMDGPU_INVALID_VA_ADDRESS;
-		}
-		offset = mgr->va_offset;
-		waste = base_required - mgr->va_offset;
-	} else {
-		offset = mgr->va_offset;
-		waste = offset % alignment;
-		waste = waste ? alignment - waste : 0;
-	}
-
-	if (offset + waste + size > mgr->va_max) {
-		pthread_mutex_unlock(&mgr->bo_va_mutex);
-		return AMDGPU_INVALID_VA_ADDRESS;
-	}
-
-	if (waste) {
-		n = calloc(1, sizeof(struct amdgpu_bo_va_hole));
-		n->size = waste;
-		n->offset = offset;
-		list_add(&n->list, &mgr->va_holes);
-	}
-
-	offset += waste;
-	mgr->va_offset += size + waste;
 	pthread_mutex_unlock(&mgr->bo_va_mutex);
-	return offset;
+	return AMDGPU_INVALID_VA_ADDRESS;
 }
 
 static drm_private void
 amdgpu_vamgr_free_va(struct amdgpu_bo_va_mgr *mgr, uint64_t va, uint64_t size)
 {
-	struct amdgpu_bo_va_hole *hole;
+	struct amdgpu_bo_va_hole *hole, *next;
 
 	if (va == AMDGPU_INVALID_VA_ADDRESS)
 		return;
@@ -164,61 +144,47 @@ amdgpu_vamgr_free_va(struct amdgpu_bo_va_mgr *mgr, uint64_t va, uint64_t size)
 	size = ALIGN(size, mgr->va_alignment);
 
 	pthread_mutex_lock(&mgr->bo_va_mutex);
-	if ((va + size) == mgr->va_offset) {
-		mgr->va_offset = va;
-		/* Delete uppermost hole if it reaches the new top */
-		if (!LIST_IS_EMPTY(&mgr->va_holes)) {
-			hole = container_of(mgr->va_holes.next, hole, list);
-			if ((hole->offset + hole->size) == va) {
-				mgr->va_offset = hole->offset;
+	hole = container_of(&mgr->va_holes, hole, list);
+	LIST_FOR_EACH_ENTRY(next, &mgr->va_holes, list) {
+		if (next->offset < va)
+			break;
+		hole = next;
+	}
+
+	if (&hole->list != &mgr->va_holes) {
+		/* Grow upper hole if it's adjacent */
+		if (hole->offset == (va + size)) {
+			hole->offset = va;
+			hole->size += size;
+			/* Merge lower hole if it's adjacent */
+			if (next != hole &&
+			    &next->list != &mgr->va_holes &&
+			    (next->offset + next->size) == va) {
+				next->size += hole->size;
 				list_del(&hole->list);
 				free(hole);
 			}
-		}
-	} else {
-		struct amdgpu_bo_va_hole *next;
-
-		hole = container_of(&mgr->va_holes, hole, list);
-		LIST_FOR_EACH_ENTRY(next, &mgr->va_holes, list) {
-			if (next->offset < va)
-				break;
-			hole = next;
-		}
-
-		if (&hole->list != &mgr->va_holes) {
-			/* Grow upper hole if it's adjacent */
-			if (hole->offset == (va + size)) {
-				hole->offset = va;
-				hole->size += size;
-				/* Merge lower hole if it's adjacent */
-				if (next != hole &&
-				    &next->list != &mgr->va_holes &&
-				    (next->offset + next->size) == va) {
-					next->size += hole->size;
-					list_del(&hole->list);
-					free(hole);
-				}
-				goto out;
-			}
-		}
-
-		/* Grow lower hole if it's adjacent */
-		if (next != hole && &next->list != &mgr->va_holes &&
-				(next->offset + next->size) == va) {
-			next->size += size;
 			goto out;
 		}
+	}
 
-		/* FIXME on allocation failure we just lose virtual address space
-		 * maybe print a warning
-		 */
-		next = calloc(1, sizeof(struct amdgpu_bo_va_hole));
-		if (next) {
-			next->size = size;
-			next->offset = va;
-			list_add(&next->list, &hole->list);
-		}
+	/* Grow lower hole if it's adjacent */
+	if (next != hole && &next->list != &mgr->va_holes &&
+	    (next->offset + next->size) == va) {
+		next->size += size;
+		goto out;
 	}
+
+	/* FIXME on allocation failure we just lose virtual address space
+	 * maybe print a warning
+	 */
+	next = calloc(1, sizeof(struct amdgpu_bo_va_hole));
+	if (next) {
+		next->size = size;
+		next->offset = va;
+		list_add(&next->list, &hole->list);
+	}
+
 out:
 	pthread_mutex_unlock(&mgr->bo_va_mutex);
 }
-- 
2.7.4


--------------118DA42E23D59C0D375F3846
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------118DA42E23D59C0D375F3846--
