From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/prime: forward begin_cpu_access callback to
 drivers
Date: Sat, 16 Dec 2017 13:40:12 +0800
Message-ID: <201712161318.RAAYk5V1%fengguang.wu@intel.com>
References: <1513355282-20248-1-git-send-email-Samuel.Li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1513355282-20248-1-git-send-email-Samuel.Li-5C7GfCeVMHo@public.gmane.org>
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
To: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v4.15-rc3 next-20171215]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Samuel-Li/drm-prime-forward-begin_cpu_access-callback-to-drivers/20171216-125056
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: i386-randconfig-x016-201750 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_drv.c:36:0:
>> include/drm/drm_drv.h:494:14: warning: 'enum dma_data_direction' declared inside parameter list will not be visible outside of this definition or declaration
            enum dma_data_direction direction);
                 ^~~~~~~~~~~~~~~~~~

vim +494 include/drm/drm_drv.h

    59	
    60	/**
    61	 * struct drm_driver - DRM driver structure
    62	 *
    63	 * This structure represent the common code for a family of cards. There will
    64	 * one drm_device for each card present in this family. It contains lots of
    65	 * vfunc entries, and a pile of those probably should be moved to more
    66	 * appropriate places like &drm_mode_config_funcs or into a new operations
    67	 * structure for GEM drivers.
    68	 */
    69	struct drm_driver {
    70		/**
    71		 * @load:
    72		 *
    73		 * Backward-compatible driver callback to complete
    74		 * initialization steps after the driver is registered.  For
    75		 * this reason, may suffer from race conditions and its use is
    76		 * deprecated for new drivers.  It is therefore only supported
    77		 * for existing drivers not yet converted to the new scheme.
    78		 * See drm_dev_init() and drm_dev_register() for proper and
    79		 * race-free way to set up a &struct drm_device.
    80		 *
    81		 * This is deprecated, do not use!
    82		 *
    83		 * Returns:
    84		 *
    85		 * Zero on success, non-zero value on failure.
    86		 */
    87		int (*load) (struct drm_device *, unsigned long flags);
    88	
    89		/**
    90		 * @open:
    91		 *
    92		 * Driver callback when a new &struct drm_file is opened. Useful for
    93		 * setting up driver-private data structures like buffer allocators,
    94		 * execution contexts or similar things. Such driver-private resources
    95		 * must be released again in @postclose.
    96		 *
    97		 * Since the display/modeset side of DRM can only be owned by exactly
    98		 * one &struct drm_file (see &drm_file.is_master and &drm_device.master)
    99		 * there should never be a need to set up any modeset related resources
   100		 * in this callback. Doing so would be a driver design bug.
   101		 *
   102		 * Returns:
   103		 *
   104		 * 0 on success, a negative error code on failure, which will be
   105		 * promoted to userspace as the result of the open() system call.
   106		 */
   107		int (*open) (struct drm_device *, struct drm_file *);
   108	
   109		/**
   110		 * @postclose:
   111		 *
   112		 * One of the driver callbacks when a new &struct drm_file is closed.
   113		 * Useful for tearing down driver-private data structures allocated in
   114		 * @open like buffer allocators, execution contexts or similar things.
   115		 *
   116		 * Since the display/modeset side of DRM can only be owned by exactly
   117		 * one &struct drm_file (see &drm_file.is_master and &drm_device.master)
   118		 * there should never be a need to tear down any modeset related
   119		 * resources in this callback. Doing so would be a driver design bug.
   120		 */
   121		void (*postclose) (struct drm_device *, struct drm_file *);
   122	
   123		/**
   124		 * @lastclose:
   125		 *
   126		 * Called when the last &struct drm_file has been closed and there's
   127		 * currently no userspace client for the &struct drm_device.
   128		 *
   129		 * Modern drivers should only use this to force-restore the fbdev
   130		 * framebuffer using drm_fb_helper_restore_fbdev_mode_unlocked().
   131		 * Anything else would indicate there's something seriously wrong.
   132		 * Modern drivers can also use this to execute delayed power switching
   133		 * state changes, e.g. in conjunction with the :ref:`vga_switcheroo`
   134		 * infrastructure.
   135		 *
   136		 * This is called after @postclose hook has been called.
   137		 *
   138		 * NOTE:
   139		 *
   140		 * All legacy drivers use this callback to de-initialize the hardware.
   141		 * This is purely because of the shadow-attach model, where the DRM
   142		 * kernel driver does not really own the hardware. Instead ownershipe is
   143		 * handled with the help of userspace through an inheritedly racy dance
   144		 * to set/unset the VT into raw mode.
   145		 *
   146		 * Legacy drivers initialize the hardware in the @firstopen callback,
   147		 * which isn't even called for modern drivers.
   148		 */
   149		void (*lastclose) (struct drm_device *);
   150	
   151		/**
   152		 * @unload:
   153		 *
   154		 * Reverse the effects of the driver load callback.  Ideally,
   155		 * the clean up performed by the driver should happen in the
   156		 * reverse order of the initialization.  Similarly to the load
   157		 * hook, this handler is deprecated and its usage should be
   158		 * dropped in favor of an open-coded teardown function at the
   159		 * driver layer.  See drm_dev_unregister() and drm_dev_put()
   160		 * for the proper way to remove a &struct drm_device.
   161		 *
   162		 * The unload() hook is called right after unregistering
   163		 * the device.
   164		 *
   165		 */
   166		void (*unload) (struct drm_device *);
   167	
   168		/**
   169		 * @release:
   170		 *
   171		 * Optional callback for destroying device data after the final
   172		 * reference is released, i.e. the device is being destroyed. Drivers
   173		 * using this callback are responsible for calling drm_dev_fini()
   174		 * to finalize the device and then freeing the struct themselves.
   175		 */
   176		void (*release) (struct drm_device *);
   177	
   178		/**
   179		 * @get_vblank_counter:
   180		 *
   181		 * Driver callback for fetching a raw hardware vblank counter for the
   182		 * CRTC specified with the pipe argument.  If a device doesn't have a
   183		 * hardware counter, the driver can simply leave the hook as NULL.
   184		 * The DRM core will account for missed vblank events while interrupts
   185		 * where disabled based on system timestamps.
   186		 *
   187		 * Wraparound handling and loss of events due to modesetting is dealt
   188		 * with in the DRM core code, as long as drivers call
   189		 * drm_crtc_vblank_off() and drm_crtc_vblank_on() when disabling or
   190		 * enabling a CRTC.
   191		 *
   192		 * This is deprecated and should not be used by new drivers.
   193		 * Use &drm_crtc_funcs.get_vblank_counter instead.
   194		 *
   195		 * Returns:
   196		 *
   197		 * Raw vblank counter value.
   198		 */
   199		u32 (*get_vblank_counter) (struct drm_device *dev, unsigned int pipe);
   200	
   201		/**
   202		 * @enable_vblank:
   203		 *
   204		 * Enable vblank interrupts for the CRTC specified with the pipe
   205		 * argument.
   206		 *
   207		 * This is deprecated and should not be used by new drivers.
   208		 * Use &drm_crtc_funcs.enable_vblank instead.
   209		 *
   210		 * Returns:
   211		 *
   212		 * Zero on success, appropriate errno if the given @crtc's vblank
   213		 * interrupt cannot be enabled.
   214		 */
   215		int (*enable_vblank) (struct drm_device *dev, unsigned int pipe);
   216	
   217		/**
   218		 * @disable_vblank:
   219		 *
   220		 * Disable vblank interrupts for the CRTC specified with the pipe
   221		 * argument.
   222		 *
   223		 * This is deprecated and should not be used by new drivers.
   224		 * Use &drm_crtc_funcs.disable_vblank instead.
   225		 */
   226		void (*disable_vblank) (struct drm_device *dev, unsigned int pipe);
   227	
   228		/**
   229		 * @get_scanout_position:
   230		 *
   231		 * Called by vblank timestamping code.
   232		 *
   233		 * Returns the current display scanout position from a crtc, and an
   234		 * optional accurate ktime_get() timestamp of when position was
   235		 * measured. Note that this is a helper callback which is only used if a
   236		 * driver uses drm_calc_vbltimestamp_from_scanoutpos() for the
   237		 * @get_vblank_timestamp callback.
   238		 *
   239		 * Parameters:
   240		 *
   241		 * dev:
   242		 *     DRM device.
   243		 * pipe:
   244		 *     Id of the crtc to query.
   245		 * in_vblank_irq:
   246		 *     True when called from drm_crtc_handle_vblank().  Some drivers
   247		 *     need to apply some workarounds for gpu-specific vblank irq quirks
   248		 *     if flag is set.
   249		 * vpos:
   250		 *     Target location for current vertical scanout position.
   251		 * hpos:
   252		 *     Target location for current horizontal scanout position.
   253		 * stime:
   254		 *     Target location for timestamp taken immediately before
   255		 *     scanout position query. Can be NULL to skip timestamp.
   256		 * etime:
   257		 *     Target location for timestamp taken immediately after
   258		 *     scanout position query. Can be NULL to skip timestamp.
   259		 * mode:
   260		 *     Current display timings.
   261		 *
   262		 * Returns vpos as a positive number while in active scanout area.
   263		 * Returns vpos as a negative number inside vblank, counting the number
   264		 * of scanlines to go until end of vblank, e.g., -1 means "one scanline
   265		 * until start of active scanout / end of vblank."
   266		 *
   267		 * Returns:
   268		 *
   269		 * True on success, false if a reliable scanout position counter could
   270		 * not be read out.
   271		 *
   272		 * FIXME:
   273		 *
   274		 * Since this is a helper to implement @get_vblank_timestamp, we should
   275		 * move it to &struct drm_crtc_helper_funcs, like all the other
   276		 * helper-internal hooks.
   277		 */
   278		bool (*get_scanout_position) (struct drm_device *dev, unsigned int pipe,
   279					      bool in_vblank_irq, int *vpos, int *hpos,
   280					      ktime_t *stime, ktime_t *etime,
   281					      const struct drm_display_mode *mode);
   282	
   283		/**
   284		 * @get_vblank_timestamp:
   285		 *
   286		 * Called by drm_get_last_vbltimestamp(). Should return a precise
   287		 * timestamp when the most recent VBLANK interval ended or will end.
   288		 *
   289		 * Specifically, the timestamp in @vblank_time should correspond as
   290		 * closely as possible to the time when the first video scanline of
   291		 * the video frame after the end of VBLANK will start scanning out,
   292		 * the time immediately after end of the VBLANK interval. If the
   293		 * @crtc is currently inside VBLANK, this will be a time in the future.
   294		 * If the @crtc is currently scanning out a frame, this will be the
   295		 * past start time of the current scanout. This is meant to adhere
   296		 * to the OpenML OML_sync_control extension specification.
   297		 *
   298		 * Paramters:
   299		 *
   300		 * dev:
   301		 *     dev DRM device handle.
   302		 * pipe:
   303		 *     crtc for which timestamp should be returned.
   304		 * max_error:
   305		 *     Maximum allowable timestamp error in nanoseconds.
   306		 *     Implementation should strive to provide timestamp
   307		 *     with an error of at most max_error nanoseconds.
   308		 *     Returns true upper bound on error for timestamp.
   309		 * vblank_time:
   310		 *     Target location for returned vblank timestamp.
   311		 * in_vblank_irq:
   312		 *     True when called from drm_crtc_handle_vblank().  Some drivers
   313		 *     need to apply some workarounds for gpu-specific vblank irq quirks
   314		 *     if flag is set.
   315		 *
   316		 * Returns:
   317		 *
   318		 * True on success, false on failure, which means the core should
   319		 * fallback to a simple timestamp taken in drm_crtc_handle_vblank().
   320		 *
   321		 * FIXME:
   322		 *
   323		 * We should move this hook to &struct drm_crtc_funcs like all the other
   324		 * vblank hooks.
   325		 */
   326		bool (*get_vblank_timestamp) (struct drm_device *dev, unsigned int pipe,
   327					     int *max_error,
   328					     ktime_t *vblank_time,
   329					     bool in_vblank_irq);
   330	
   331		/**
   332		 * @irq_handler:
   333		 *
   334		 * Interrupt handler called when using drm_irq_install(). Not used by
   335		 * drivers which implement their own interrupt handling.
   336		 */
   337		irqreturn_t(*irq_handler) (int irq, void *arg);
   338	
   339		/**
   340		 * @irq_preinstall:
   341		 *
   342		 * Optional callback used by drm_irq_install() which is called before
   343		 * the interrupt handler is registered. This should be used to clear out
   344		 * any pending interrupts (from e.g. firmware based drives) and reset
   345		 * the interrupt handling registers.
   346		 */
   347		void (*irq_preinstall) (struct drm_device *dev);
   348	
   349		/**
   350		 * @irq_postinstall:
   351		 *
   352		 * Optional callback used by drm_irq_install() which is called after
   353		 * the interrupt handler is registered. This should be used to enable
   354		 * interrupt generation in the hardware.
   355		 */
   356		int (*irq_postinstall) (struct drm_device *dev);
   357	
   358		/**
   359		 * @irq_uninstall:
   360		 *
   361		 * Optional callback used by drm_irq_uninstall() which is called before
   362		 * the interrupt handler is unregistered. This should be used to disable
   363		 * interrupt generation in the hardware.
   364		 */
   365		void (*irq_uninstall) (struct drm_device *dev);
   366	
   367		/**
   368		 * @master_create:
   369		 *
   370		 * Called whenever a new master is created. Only used by vmwgfx.
   371		 */
   372		int (*master_create)(struct drm_device *dev, struct drm_master *master);
   373	
   374		/**
   375		 * @master_destroy:
   376		 *
   377		 * Called whenever a master is destroyed. Only used by vmwgfx.
   378		 */
   379		void (*master_destroy)(struct drm_device *dev, struct drm_master *master);
   380	
   381		/**
   382		 * @master_set:
   383		 *
   384		 * Called whenever the minor master is set. Only used by vmwgfx.
   385		 */
   386		int (*master_set)(struct drm_device *dev, struct drm_file *file_priv,
   387				  bool from_open);
   388		/**
   389		 * @master_drop:
   390		 *
   391		 * Called whenever the minor master is dropped. Only used by vmwgfx.
   392		 */
   393		void (*master_drop)(struct drm_device *dev, struct drm_file *file_priv);
   394	
   395		/**
   396		 * @debugfs_init:
   397		 *
   398		 * Allows drivers to create driver-specific debugfs files.
   399		 */
   400		int (*debugfs_init)(struct drm_minor *minor);
   401	
   402		/**
   403		 * @gem_free_object: deconstructor for drm_gem_objects
   404		 *
   405		 * This is deprecated and should not be used by new drivers. Use
   406		 * @gem_free_object_unlocked instead.
   407		 */
   408		void (*gem_free_object) (struct drm_gem_object *obj);
   409	
   410		/**
   411		 * @gem_free_object_unlocked: deconstructor for drm_gem_objects
   412		 *
   413		 * This is for drivers which are not encumbered with &drm_device.struct_mutex
   414		 * legacy locking schemes. Use this hook instead of @gem_free_object.
   415		 */
   416		void (*gem_free_object_unlocked) (struct drm_gem_object *obj);
   417	
   418		/**
   419		 * @gem_open_object:
   420		 *
   421		 * Driver hook called upon gem handle creation
   422		 */
   423		int (*gem_open_object) (struct drm_gem_object *, struct drm_file *);
   424	
   425		/**
   426		 * @gem_close_object:
   427		 *
   428		 * Driver hook called upon gem handle release
   429		 */
   430		void (*gem_close_object) (struct drm_gem_object *, struct drm_file *);
   431	
   432		/**
   433		 * @gem_print_info:
   434		 *
   435		 * If driver subclasses struct &drm_gem_object, it can implement this
   436		 * optional hook for printing additional driver specific info.
   437		 *
   438		 * drm_printf_indent() should be used in the callback passing it the
   439		 * indent argument.
   440		 *
   441		 * This callback is called from drm_gem_print_info().
   442		 */
   443		void (*gem_print_info)(struct drm_printer *p, unsigned int indent,
   444				       const struct drm_gem_object *obj);
   445	
   446		/**
   447		 * @gem_create_object: constructor for gem objects
   448		 *
   449		 * Hook for allocating the GEM object struct, for use by core
   450		 * helpers.
   451		 */
   452		struct drm_gem_object *(*gem_create_object)(struct drm_device *dev,
   453							    size_t size);
   454	
   455		/* prime: */
   456		/**
   457		 * @prime_handle_to_fd:
   458		 *
   459		 * export handle -> fd (see drm_gem_prime_handle_to_fd() helper)
   460		 */
   461		int (*prime_handle_to_fd)(struct drm_device *dev, struct drm_file *file_priv,
   462					uint32_t handle, uint32_t flags, int *prime_fd);
   463		/**
   464		 * @prime_fd_to_handle:
   465		 *
   466		 * import fd -> handle (see drm_gem_prime_fd_to_handle() helper)
   467		 */
   468		int (*prime_fd_to_handle)(struct drm_device *dev, struct drm_file *file_priv,
   469					int prime_fd, uint32_t *handle);
   470		/**
   471		 * @gem_prime_export:
   472		 *
   473		 * export GEM -> dmabuf
   474		 */
   475		struct dma_buf * (*gem_prime_export)(struct drm_device *dev,
   476					struct drm_gem_object *obj, int flags);
   477		/**
   478		 * @gem_prime_import:
   479		 *
   480		 * import dmabuf -> GEM
   481		 */
   482		struct drm_gem_object * (*gem_prime_import)(struct drm_device *dev,
   483					struct dma_buf *dma_buf);
   484		int (*gem_prime_pin)(struct drm_gem_object *obj);
   485		void (*gem_prime_unpin)(struct drm_gem_object *obj);
   486		struct reservation_object * (*gem_prime_res_obj)(
   487					struct drm_gem_object *obj);
   488		struct sg_table *(*gem_prime_get_sg_table)(struct drm_gem_object *obj);
   489		struct drm_gem_object *(*gem_prime_import_sg_table)(
   490					struct drm_device *dev,
   491					struct dma_buf_attachment *attach,
   492					struct sg_table *sgt);
   493		int (*gem_prime_begin_cpu_access)(struct drm_gem_object *obj,
 > 494						   enum dma_data_direction direction);
   495		void *(*gem_prime_vmap)(struct drm_gem_object *obj);
   496		void (*gem_prime_vunmap)(struct drm_gem_object *obj, void *vaddr);
   497		int (*gem_prime_mmap)(struct drm_gem_object *obj,
   498					struct vm_area_struct *vma);
   499	
   500		/**
   501		 * @dumb_create:
   502		 *
   503		 * This creates a new dumb buffer in the driver's backing storage manager (GEM,
   504		 * TTM or something else entirely) and returns the resulting buffer handle. This
   505		 * handle can then be wrapped up into a framebuffer modeset object.
   506		 *
   507		 * Note that userspace is not allowed to use such objects for render
   508		 * acceleration - drivers must create their own private ioctls for such a use
   509		 * case.
   510		 *
   511		 * Width, height and depth are specified in the &drm_mode_create_dumb
   512		 * argument. The callback needs to fill the handle, pitch and size for
   513		 * the created buffer.
   514		 *
   515		 * Called by the user via ioctl.
   516		 *
   517		 * Returns:
   518		 *
   519		 * Zero on success, negative errno on failure.
   520		 */
   521		int (*dumb_create)(struct drm_file *file_priv,
   522				   struct drm_device *dev,
   523				   struct drm_mode_create_dumb *args);
   524		/**
   525		 * @dumb_map_offset:
   526		 *
   527		 * Allocate an offset in the drm device node's address space to be able to
   528		 * memory map a dumb buffer. GEM-based drivers must use
   529		 * drm_gem_create_mmap_offset() to implement this.
   530		 *
   531		 * Called by the user via ioctl.
   532		 *
   533		 * Returns:
   534		 *
   535		 * Zero on success, negative errno on failure.
   536		 */
   537		int (*dumb_map_offset)(struct drm_file *file_priv,
   538				       struct drm_device *dev, uint32_t handle,
   539				       uint64_t *offset);
   540		/**
   541		 * @dumb_destroy:
   542		 *
   543		 * This destroys the userspace handle for the given dumb backing storage buffer.
   544		 * Since buffer objects must be reference counted in the kernel a buffer object
   545		 * won't be immediately freed if a framebuffer modeset object still uses it.
   546		 *
   547		 * Called by the user via ioctl.
   548		 *
   549		 * Returns:
   550		 *
   551		 * Zero on success, negative errno on failure.
   552		 */
   553		int (*dumb_destroy)(struct drm_file *file_priv,
   554				    struct drm_device *dev,
   555				    uint32_t handle);
   556	
   557		/**
   558		 * @gem_vm_ops: Driver private ops for this object
   559		 */
   560		const struct vm_operations_struct *gem_vm_ops;
   561	
   562		/** @major: driver major number */
   563		int major;
   564		/** @minor: driver minor number */
   565		int minor;
   566		/** @patchlevel: driver patch level */
   567		int patchlevel;
   568		/** @name: driver name */
   569		char *name;
   570		/** @desc: driver description */
   571		char *desc;
   572		/** @date: driver date */
   573		char *date;
   574	
   575		/** @driver_features: driver features */
   576		u32 driver_features;
   577	
   578		/**
   579		 * @ioctls:
   580		 *
   581		 * Array of driver-private IOCTL description entries. See the chapter on
   582		 * :ref:`IOCTL support in the userland interfaces
   583		 * chapter<drm_driver_ioctl>` for the full details.
   584		 */
   585	
   586		const struct drm_ioctl_desc *ioctls;
   587		/** @num_ioctls: Number of entries in @ioctls. */
   588		int num_ioctls;
   589	
   590		/**
   591		 * @fops:
   592		 *
   593		 * File operations for the DRM device node. See the discussion in
   594		 * :ref:`file operations<drm_driver_fops>` for in-depth coverage and
   595		 * some examples.
   596		 */
   597		const struct file_operations *fops;
   598	
   599		/* Everything below here is for legacy driver, never use! */
   600		/* private: */
   601	
   602		/* List of devices hanging off this driver with stealth attach. */
   603		struct list_head legacy_dev_list;
   604		int (*firstopen) (struct drm_device *);
   605		void (*preclose) (struct drm_device *, struct drm_file *file_priv);
   606		int (*dma_ioctl) (struct drm_device *dev, void *data, struct drm_file *file_priv);
   607		int (*dma_quiescent) (struct drm_device *);
   608		int (*context_dtor) (struct drm_device *dev, int context);
   609		int dev_priv_size;
   610	};
   611	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--0OAP2g/MAC+5xKAE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICBKqNFoAAy5jb25maWcAlFzNc+M2sr/nr1BN3mH3kIzt8Xgn9coHEAQlRCRBA6Bk+cJy
PJqJaz3WrC1vkv/+dTdIEYBApV4OqRG68d0fv240/eMPP87Y23737X7/+HD/9PTX7Ov2efty
v99+nn15fNr+7yxXs1rZmcil/RmYy8fntz/fP374dDW7/Pn8489nP708XMyW25fn7dOM756/
PH59g+6Pu+cffgR2rupCzrury0za2ePr7Hm3n71u9z/07befrroPF9d/eb/HH7I2VrfcSlV3
ueAqF3okqtY2re0KpStmr99tn758uPgJl/Vu4GCaL6Bf4X5ev7t/efj9/Z+frt4/0CpfaRPd
5+0X9/vQr1R8mYumM23TKG3HKY1lfGk14+KYVlXt+INmrirWdLrOO9i56SpZX386RWe31+dX
aQauqobZvx0nYAuGq4XIu7xiHbLCLqwY10o0MydyKeq5XYy0uaiFlryThiH9mJC18+PGxVrI
+cLGx8E23YKtRNfwrsj5SNVrI6ruli/mLM87Vs6VlnZRHY/LWSkzDYuHSy3ZJhp/wUzHm7bT
QLtN0RhfiK6UNVyevPMOgBZlhG2brhGaxmBasOiEBpKoMvhVSG1sxxdtvZzga9hcpNncimQm
dM1ItBtljMxKEbGY1jQCrnWCvGa17RYtzNJUcIELWHOKgw6PlcRpy+xoDhJj06nGygqOJQel
gzOS9XyKMxdw6bQ9VoKmBKoLqtyZqpnq2jZaZcKM5ELedoLpcgO/u0p4d97MLYM9g0SuRGmu
PwztB3WGmzSg9u+fHn97/233+e1p+/r+f9qaVQIlQDAj3v8c6bXUN91aae8qslaWOWxcdOLW
zWcCpbYLEAQ8kkLB/zrLDHYmuzYnK/mEtuztO7QcTJa0nahXsHNcYiXt9YeLgcg1XCWpqYTr
fPduNI99W2eFSVlJOGdWroQ2IC7YL9HcsdaqSKiXIGKi7OZ3sklTMqBcpEnlna/vPuX2bqrH
xPzl3eVICNd0OAB/Qf4BxAy4rFP027vTvdVp8mXi8EHkWFuCriljUb6u3/3jefe8/efhGsya
BXsxG7OSDU/OBMoMMl/dtKIVibmchIAmKL3pmAV/s/BHbo0AE5gcmLV50sHSRZAaEgesDWSm
HKQYVGL2+vbb61+v++23UYoPdh80hnQ24RKAZBZqnaaIohDgt3HqogDTb5bHfGjcwM4gf3qQ
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
xz6oOAttAf0PuCvf23FtAQA=

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--0OAP2g/MAC+5xKAE--
